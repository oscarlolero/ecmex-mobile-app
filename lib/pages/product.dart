//import 'dart:async';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

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
                    onPressed: () => Navigator.pop(context, true),
                  ),
                )
              ],
            ));
  }
}
