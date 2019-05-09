import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct; //store reference of a func

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        addProduct({
          'title': 'Caca',
          'image': 'assets/food.jpg'
        });
      },
      child: Text('Add product'),
    );
  }
}