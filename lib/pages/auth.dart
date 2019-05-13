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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: AssetImage('assets/background.jpg'),
          ),
        ),
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.white),
                  onChanged: (String value) {
                    _username = value;
                  },
                ),
                SizedBox(height: 10.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white),
                  onChanged: (String value) {
                    _password = value;
                  },
                ),
                SwitchListTile(
                  title: Text('Accept terms'),
                  activeColor: Theme.of(context).primaryColor,
                  value: _acceptTerms,
                  onChanged: (bool value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                ),
                SizedBox(height: 15.0),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('LOGIN', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context,
                        '/products'); //se remplaza completamente la pagina actual
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
