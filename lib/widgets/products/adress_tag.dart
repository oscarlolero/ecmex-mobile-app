import 'package:flutter/material.dart';

class AdressTag extends StatelessWidget {
  final String adress;

  AdressTag(this.adress);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
      margin: EdgeInsets.only(top: 7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(4.0)),
      child: Text(
        adress,
        style: TextStyle(fontFamily: 'Oswald'),
      ),
    );
  }
}