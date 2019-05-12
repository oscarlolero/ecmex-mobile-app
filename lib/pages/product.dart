//import 'dart:async';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action cannot be undone!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Discard'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Continue'),
                onPressed: () {
                  Navigator.pop(context); //cierra el dialogo
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return //WillPopScope(onWillPop: () { // por lo visto ya no es necesario controlar el false
//      Navigator.pop(context, false); //pasar nuestra propia data
//      return Future.value(false);//omitir que se haga doble pop   5:30 https://www.udemy.com/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/10646434#questions
        //},child:
        Scaffold(
            appBar: AppBar(title: Text(title)),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(imageUrl),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(title),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Delete'),
                    onPressed: () => _showWarningDialog(context),
                  ),
                )
              ],
            ));
  }
}
