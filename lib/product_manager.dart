import 'package:flutter/material.dart';

import './products.dart';

class ProductManager extends StatefulWidget { //aqui no se puede manejar datos internos
  final String startingProduct;
  ProductManager(this.startingProduct) {
    print('ProductManager Widged Constructor');
  }

  //ahora es stateful porque se planea manehar la lista de productos y cambiarlos
  @override
  State<StatefulWidget> createState() {
    print('ProductManager Widged createState');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> { //aqui se pueden manejar datos internos
  List<String> _products = []; //array

  @override
  void initState() {//corre antes del build
    print('ProductManager State  initState');
    super.initState();
    _products.add(widget.startingProduct);//asi es como se tiene que inicializar
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('ProductManager State  didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('ProductManager State  build');
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            setState(() {
              _products.add('Advanced Food Tester');
            });
          },
          child: Text('Add product'),
        ),
      ),
      Products(_products)
    ]);
  }
}
