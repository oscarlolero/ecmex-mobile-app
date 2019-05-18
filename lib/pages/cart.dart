import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

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
                onPressed: () {},
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
