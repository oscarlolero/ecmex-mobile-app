import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  //aqui no se puede manejar datos internos
  final String startingProduct;

  ProductManager({this.startingProduct = 'Sweets Tester'}) {
    print('ProductManager Widged Constructor');
  }

  //ahora es stateful porque se planea manehar la lista de productos y cambiarlos
  @override
  State<StatefulWidget> createState() {
    print('ProductManager Widged createState');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  //aqui se pueden manejar datos internos
  final List<String> _products =
      []; //array igual que js, no se podria hacer _products = ['asdas'] pero si metodos como add, si no se usa const para que ni el add te deje
  //con static seria  final List<String> _products = const [];
  @override
  void initState() {
    //corre antes del build
    print('ProductManager State  initState');
    super.initState();
    _products
        .add(widget.startingProduct); //asi es como se tiene que inicializar
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('ProductManager State  didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(String productName) {
    setState(() {
      _products.add(productName);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ProductManager State  build');
    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.all(10.0), child: ProductControl(_addProduct)),
      Expanded(child: Products(_products))
    ]);
  }
}
