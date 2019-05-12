import 'package:flutter/material.dart';

import './products.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    print('ProductManager State  build');
    return Column(children: <Widget>[
      Expanded(child: Products(products))
    ]);
  }
}

/*
//Antes de la movedera
class _ProductManagerState extends State<ProductManager> {
  //aqui se pueden manejar datos internos
  final List<Map<String, String>> _products =
      []; //array igual que js, no se podria hacer _products = ['asdas'] pero si metodos como add, si no se usa const para que ni el add te deje
  //con static seria  final List<String> _products = const [];
  @override
  void initState() {
    //corre antes del build
    print('ProductManager State  initState');
    super.initState();

    if(widget.startingProduct != null) {
      _products
          .add(widget.startingProduct); //asi es como se tiene que inicializar
    }

  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('ProductManager State  didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ProductManager State  build');
    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.all(10.0), child: ProductControl(_addProduct)),
      Expanded(child: Products(_products, deleteProduct: _deleteProduct))
    ]);
  }
}

 */