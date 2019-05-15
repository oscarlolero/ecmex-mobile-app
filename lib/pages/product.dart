//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/title_default.dart';
import '../models/product.dart';
import '../scoped-models/products.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

//  _showWarningDialog(BuildContext context) {
//
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Text('Are you sure?'),
//            content: Text('This action cannot be undone!'),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Discard'),
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//              ),
//              FlatButton(
//                child: Text('Continue'),
//                onPressed: () {
//                  Navigator.pop(context); //cierra el dialogo
//                  Navigator.pop(context, true);
//                },
//              ),
//            ],
//          );
//        });
//  }

  Widget _buildAdressPriceRow(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Union Square, San Francisco',
          style: TextStyle(color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$${price.toString()}',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

//WillPopScope(onWillPop: () { // por lo visto ya no es necesario controlar el false
//      Navigator.pop(context, false); //pasar nuestra propia data
//      return Future.value(false);//omitir que se haga doble pop   5:30 https://www.udemy.com/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/10646434#questions
  //},child:
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        final Product product = model.products[productIndex];
        return Scaffold(
          appBar: AppBar(title: Text(product.title)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(product.image),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              _buildAdressPriceRow(product.price),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
              ),

//                Container(
//                  padding: EdgeInsets.all(10.0),
//                  child: RaisedButton(
//                    color: Theme.of(context).accentColor,
//                    child: Text('Delete'),
//                    onPressed: () => _showWarningDialog(context),
//                  ),
//                )
            ],
          ),
        );
      },
    );
  }
}
