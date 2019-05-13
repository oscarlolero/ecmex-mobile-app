import 'package:flutter/material.dart';

import './price_tag.dart';
import './adress_tag.dart';
import '../ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.info),
          //push regresara un future que sera un boolean
          onPressed: () => Navigator.pushNamed<bool>(
                      context, '/product/' + productIndex.toString())
                  .then(
                (bool value) {
                  if (value) {
//                        deleteProduct(index);
                  }
                },
              ),
        ),
        IconButton(
          color: Colors.red,
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
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
          Image.asset(product['image']),
          //para hacer espacio se puede usar SizedBox(height: 10.0),Container(margin: EdgeInsets.all(10.0), Padding()
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefault(product['title']),
                SizedBox(width: 8.0),
                PriceTag(product['price'].toString()),
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
