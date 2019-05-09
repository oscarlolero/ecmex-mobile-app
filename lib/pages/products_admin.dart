import 'package:flutter/material.dart';

import './products.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('Products'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) => ProductsPage())); //se remplaza completamente la pagina actual
            },
          ),
        ],
      )),
      appBar: AppBar(title: Text('Manage products')),
      body: Center(child: Text('Alo')),
    );
  }
}
