import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  final Map<String, dynamic> _formData = {'username': null, 'password': null};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;

  BoxDecoration _buildBackgroundImage() {
    return BoxDecoration(
      image: DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        fit: BoxFit.cover,
        image: AssetImage('assets/background.jpg'),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(child: 
      Image(image: AssetImage('assets/logo.jpg')),);
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
//      autofocus: true,

      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
          icon: Icon(
            Icons.supervised_user_circle,
            color: Colors.grey,
          ),
          labelText: 'Usuario',
          filled: true),
      validator: (String value) {
        //TODO: Activar validaciones de login
        if (value.isEmpty) {
          return 'Por favor ingresa un usuario.';
        }
      },
      onSaved: (String value) {
        _formData['username'] = value;
      },
    );
  }

  Widget _buildUPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          icon: Icon(
            Icons.vpn_key,
            color: Colors.grey,
          ),
          labelText: 'Contraseña',
          filled: true),
      validator: (String value) {
        if (value.isEmpty || value.length < 3) {
          return 'Contraseña inválida';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildAcceptTermsSwitch() {
    return SwitchListTile(
      title: Text('Accept terms'),
      activeColor: Theme.of(context).primaryColor,
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
  }

  void _submitForm(Function login) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    Map<String, dynamic> serverResponse =
        await login(_formData['username'], _formData['password']);
    if (serverResponse['success']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ha ocurrido un error'),
            content: Text(serverResponse['message']),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Cerrar',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
    //se remplaza completamente la pagina actual
  }

  @override
  Widget build(BuildContext context) {
    //que sea del tamaño del 80% del device width
    //MediaQuery.of(context).size.width * 0.8,
//    final double deviceWidth = MediaQuery.of(context).size.width;
//    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? 500.0
            : deviceWidth * 0.95;

    return Scaffold(
//      appBar: AppBar(title: Text('Login')),
      body: Container(
        color: Colors.white,
//        decoration: _buildBackgroundImage(),
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              // MediaQuery.of(context).orientation == Orientation.portrait ?
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildLogo(),
                    SizedBox(height: 30.0),
                    Text('Ingresa tus datos para iniciar sesión.'),
                    SizedBox(height: 25.0),
                    _buildUsernameTextField(),
                    SizedBox(height: 15.0),
                    _buildUPasswordTextField(),
                    //_buildAcceptTermsSwitch(),
                    SizedBox(height: 60.0),
                    ScopedModelDescendant<MainModel>(builder:
                        (BuildContext context, Widget snapshot,
                            MainModel model) {
                      return RaisedButton(
                        color: Theme.of(context).primaryColor,
                        elevation: 6.0,
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        child: Text('Iniciar sesión', style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                        onPressed: () {
                          _submitForm(model.login);
                        }, //se añade el arrow y () para que se ejecute cuando se ejecute la funcion y no cuando se haga el build
                      );
                    }),
                    SizedBox(height: 10.0,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
