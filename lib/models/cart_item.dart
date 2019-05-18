import 'package:flutter/material.dart';
import './product.dart';
class CartItem {
  final Product product;
  int amount;

  CartItem({@required this.product, @required this.amount});
}