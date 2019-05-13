import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';

//shortcut: void main() => runApp(MyApp());
void main() {
//  debugPaintSizeEnabled = true;
//  debugPaintBaselinesEnabled = true;
//  debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    //se ejecutara cada vez que _products cambie
    print('MyApp build');
    return MaterialApp(
//      debugShowMaterialGrid: true,
      theme: ThemeData(
//      brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
//      home: AuthPage(), lo mismo que la ruta '/', no s epeuden poner al mismo tiempo
      routes: {
        '/': (BuildContext context) =>
            AuthPage(),
        '/products': (BuildContext context) =>
            ProductsPage(_products),
        '/admin': (BuildContext context) => ProductsAdminPage(_addProduct, _deleteProduct),
      },
      //se ejecuta si la ruta no fue encontrada en routes
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split(
            '/'); //regresarà una lista: '', 'products', '2' el 2 es el index
        //el primer elemento sera una cadena vacia si la cadena no empieza con /, por lo tanto es invalido
        if (pathElements[0] != '') {
          return null; // solo es un extra check
        }

        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>( //regresara un bool
              builder: (BuildContext context) =>
                  ProductPage(
                      _products[index]['title'], _products[index]['image']));
        }

        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) =>
            ProductsPage(_products));
      },
    );
  }
}
