//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

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

  Widget _buildTopInfo(BuildContext context, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          product.provider,
          style: TextStyle(fontSize: 20.0, color: Colors.grey),
        ),
        Text(
          '\$${product.price}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Theme.of(context).accentColor),
        ),
      ],
    );
  }

  Widget _buildMainProductInfo() {
    return Column(
      children: <Widget>[
        Text(
          product.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              textColor: Colors.white,
              elevation: 6.0,
              child: Text(
                'COMPRAR AHORA',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return RaisedButton(
                  onPressed: () {
                    model.addCartItem(product);
                  },
                  child: new Icon(
                    Icons.add_shopping_cart,
                    size: 23.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  shape: new CircleBorder(),
                  elevation: 4.0,
                  colorBrightness: Theme.of(context).accentColorBrightness,
                  color: Theme.of(context).accentColor,
                  padding: const EdgeInsets.all(14.0),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

//WillPopScope(onWillPop: () { // por lo visto ya no es necesario controlar el false
//      Navigator.pop(context, false); //pasar nuestra propia data
//      return Future.value(false);//omitir que se haga doble pop   5:30 https://www.udemy.com/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/10646434#questions
  //},child:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          FadeInImage(
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover, //para que no se distorsione la imagen
            placeholder: AssetImage('assets/food.jpg'),
          ),
          SizedBox(height: 15.0),
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                return Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTopInfo(context, product.price),
                    SizedBox(height: 10.0),
                    _buildMainProductInfo(),
                    SizedBox(height: 15.0),
                    Text(product.description, style: TextStyle(fontSize: 16.0),textAlign: TextAlign.right,)
                  ],
                ),
              );
            }
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
      bottomNavigationBar: _buildActionButtons(context),
    );
  }
}
