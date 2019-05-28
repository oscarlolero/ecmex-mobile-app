import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final int price;
  final bool isFavorite;
  final int stock;
  final String provider;

//con los {}, pueden instanciar los parametros en el orden que quieran pero todos son requeridos
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.provider,
      @required this.stock,
      this.isFavorite = false});
}
