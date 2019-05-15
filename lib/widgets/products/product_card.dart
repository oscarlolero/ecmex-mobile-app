import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import './adress_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          color: Colors.purple,
          icon: Icon(Icons.info),
          onPressed: () => Navigator.pushNamed(context, '/product/' + productIndex.toString())
          ),
          //push regresara un future que sera un boolean
//          onPressed: () => Navigator.pushNamed<bool>(context, '/product/' + productIndex.toString())
//                  .then(
//                (bool value) {
//                  if (value) {
////                        deleteProduct(index);
//                  }
//                },
//              ),

        ScopedModelDescendant<ProductsModel>(
          builder: (BuildContext context, Widget child, ProductsModel model) {
            return IconButton(
              color: Colors.red,
              icon: Icon(model.products[productIndex].isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                model.selectProduct(productIndex);
                model.toggleFavoriteProduct();
              },
            );
          }
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          //array de widgets
          Image.asset(product.image),
          //para hacer espacio se puede usar SizedBox(height: 10.0),Container(margin: EdgeInsets.all(10.0), Padding()
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefault(product.title),
                SizedBox(width: 8.0),
                PriceTag(product.price.toString()),
              ],
            ),
          ),
          AdressTag('Union Square, San Francisco'),
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
