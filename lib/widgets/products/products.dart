import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../scoped-models/products.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {

//expanded, flexible

  Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        //para cuando habra listas muy gfrandes, de lo contrariom, solo usar ListView
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
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

    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
          return _buildProductList(model.products);
        },);
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
