import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products; //con final, products solo se puede cambiar desde afuera, no desde adentro

  Products([this.products = const []]) { //constructor, shortcut, recibe y asigna propiedad a products
    print('Products Widged Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('Products Widged build');
    return  Column(
      children: products
          .map(
            (element) => Card(
          child: Column(
            children: <Widget>[
              //array de widgets
//              Image.asset('assets/food.jpg'),
              Text(element)
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}