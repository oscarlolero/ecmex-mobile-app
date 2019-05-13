import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  String _username, _password;
  bool _acceptTerms = false;

  _buildBackgroundImage() {
    return BoxDecoration(
      image: DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        fit: BoxFit.cover,
        image: AssetImage('assets/background.jpg'),
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Username', filled: true, fillColor: Colors.white),
      onChanged: (String value) {
        _username = value;
      },
    );
  }

  Widget _buildUPasswordTextField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      onChanged: (String value) {
        _password = value;
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

  void _submitForm() {
    Navigator.pushReplacementNamed(
        context, '/products'); //se remplaza completamente la pagina actual
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        decoration: _buildBackgroundImage(),
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildUsernameTextField(),
                SizedBox(height: 10.0),
                _buildUPasswordTextField(),
                _buildAcceptTermsSwitch(),
                SizedBox(height: 15.0),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('LOGIN', style: TextStyle(color: Colors.white)),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
