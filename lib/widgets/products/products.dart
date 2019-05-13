import 'package:flutter/material.dart';

import './product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>>
      products; //con final, products solo se puede cambiar desde afuera, no desde adentro

  Products(this.products) {
    //constructor, shortcut, recibe y asigna propiedad a products
    print('Products Widged Constructor');
  }

//expanded, flexible

  Widget _buildProductLists() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        //para cuando habra listas muy gfrandes, de lo contrariom, solo usar ListView
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        //se ejecutara dependiendo del products.length
        itemCount: products.length,
      );
    } else {
      //manera mas elegante y de facil lectura en ves de ternary
      productCards = Center(child: Text('No products found, please add some.'));

      //Si no se quiere regresar nada, anque sea se debe de usar
      // productCards = Container();
    }

    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('Products Widged build');

    return _buildProductLists();
//
//    Widget productCard;
//    if(products.length > 0) {
//      productCard = ListView.builder(
//        itemBuilder: _buildProductItem,
//        //se ejecutara dependiendo del products.length
//        itemCount: products.length,
//      );
//    } else { //manera mas elegante y de facil lectura en ves de ternary
//      productCard = Center(child: Text('No products found, please add some.'));
//    }
//
//    return productCard;
//  }
  }
}
