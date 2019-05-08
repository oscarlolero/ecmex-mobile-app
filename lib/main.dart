import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import './product_manager.dart';

//shortcut: void main() => runApp(MyApp());
void main() {
//  debugPaintSizeEnabled = true;
//  debugPaintBaselinesEnabled = true;
//  debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //se ejecutara cada vez que _products cambie
    print('MyApp build');
    return MaterialApp(
//      debugShowMaterialGrid: true,
      theme: ThemeData(
//        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('EasyList')),
        body: ProductManager(startingProduct: 'Food Testers'),
      ),
    );
  }
}
