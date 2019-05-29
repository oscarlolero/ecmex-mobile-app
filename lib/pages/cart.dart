import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../config/server.dart' as server;
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final MainModel model;

  CartPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Future<bool> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Requiere factura?'),
          content: const Text(
              'Se generará una factura con los datos anteriormente proporciodados.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }


  Widget _buildActionButtons() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total:'),
                subtitle: Text('\$${model.getTotalPrice.toString()}'),
              ),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () async {
                  bool requireBill = await _asyncConfirmDialog(context);
                  bool succed = await model.purchaseProducts(requireBill);
                  if(succed) {
                    model.clearAllCartProduct();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Compra realizada'),
                          content: Text('¡Gracias por tu compra!'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cerrar', style: TextStyle(color: Colors.deepOrange),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Ha ocurrido un error'),
                          content: Text('Hay un error con tu compra'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cerrar', style: TextStyle(color: Colors.deepOrange),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Comprar todo',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      );

//      return Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          RaisedButton(
//            onPressed: () {
////                    model.finalizePurchase();
//            },
//            shape: new RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(5.0)),
//            padding:
//                EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
//            textColor: Colors.white,
//            elevation: 6.0,
//            child: Text(
//              'Comprar todo',
//              style: TextStyle(
//                fontSize: 18,
//              ),
//            ),
//          ),
//          SizedBox(height: 100.0,)
//        ],
//      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allCartItems[index].product.title),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              onDismissed: (DismissDirection direction) {
                model.deleteCartProduct(model.allCartItems[index]);
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            model.allCartItems[index].product.image)),
//            backgroundImage:
//                            AssetImage(model.allProducts[index].image)),
                    title: Text(model.allCartItems[index].product.title),
                    subtitle: Text('Qty: ${model.getItemAmount(index)}'),
                    trailing: Text(
                      '\$${(model.allCartItems[index].product.price * model.getItemAmount(index)).toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.allCartItems.length,
        );
      }),
      bottomNavigationBar: _buildActionButtons(),
    );
  }
}
