import 'package:flutter/material.dart';

import '../../scoped-models/main.dart';

class DrawerWidget extends StatelessWidget {
  final MainModel model;

  DrawerWidget(this.model);

  Widget _buildDrawer(BuildContext context) {
    Widget content;
    if (model.isAdmin) {
      content = Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Escoge'),
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Productos'),
              onTap: () {
                Navigator.pushReplacementNamed(context,
                    '/products'); //se remplaza completamente la pagina actual
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manejar productos'),
              onTap: () {
                Navigator.pushReplacementNamed(context,
                    '/admin'); //se remplaza completamente la pagina actual
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_shared),
              title: Text('Facturación'),
              onTap: () {
                Navigator.pushReplacementNamed(context,
                    '/bill'); //se remplaza completamente la pagina actual
              },
            )
          ],
        ),
      );
    } else {
      content = Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Escoge'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Productos'),
              onTap: () {
                Navigator.pushReplacementNamed(context,
                    '/products'); //se remplaza completamente la pagina actual
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_shared),
              title: Text('Facturación'),
              onTap: () {
                Navigator.pushReplacementNamed(context,
                    '/bill'); //se remplaza completamente la pagina actual
              },
            ),
          ],
        ),
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildDrawer(context);
  }
}
