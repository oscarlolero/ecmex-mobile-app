import 'package:flutter/material.dart';
import './product.dart';
class CartItem {
  final Product product;
  int amount;

  CartItem({@required this.product, @required this.amount});

  Map<String,dynamic> toJson(){
    return {
      "productId": this.product.id,
      "title": this.product.title,
      "qty": this.amount,
      "price": this.product.price
    };
  }

  static List encondeToJson(List<CartItem> list){
    List jsonList = List();
    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }
}