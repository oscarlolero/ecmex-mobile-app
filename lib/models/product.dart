import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final String image;
  final double price;
  final bool isFavorite;

//con los {}, pueden instanciar los parametros en el orden que quieran pero todos son requeridos
  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      this.isFavorite = false});
}
