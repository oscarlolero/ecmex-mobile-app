import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './scoped-models/main.dart';
import './models/product.dart';
import './pages/cart.dart';
import './pages/bill_info.dart';
import './pages/sales.dart';

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
  @override
  Widget build(BuildContext context) {
    //se ejecutara cada vez que _products cambie
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      //se crea una instancia del modelo, solo una vez en toda la app
      model: model,
      child: MaterialApp(
//      debugShowMaterialGrid: true,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color(0xff05039B),
          buttonColor: Color(0xffFF5733),
//          buttonColor: Colors.deepOrange,
        ),
//      home: AuthPage(), lo mismo que la ruta '/', no s epeuden poner al mismo tiempo
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductsAdminPage(model),
          '/cart': (BuildContext context) => CartPage(model),
          '/bill': (BuildContext context) => BillInfoPage(model),
          '/sales': (BuildContext context) => SalesPage(model),
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
            final String productId = pathElements[2];
            final Product product =
                model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });

            return MaterialPageRoute<bool>(
              //regresara un bool
              builder: (BuildContext context) => ProductPage(product),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(model));
        },
      ),
    );
  }
}
