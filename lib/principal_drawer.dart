import 'package:flutter/material.dart';

import './pages/products.dart';
import './pages/products_admin.dart';

class PrincipalDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        ListTile(
          title: Text('Manage products'),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => ProductsAdminPage())); //se remplaza completamente la pagina actual
          },
        )
      ],
    );
  }
}