import 'package:flutter/material.dart';

import '../../../scoped-models/main.dart';

class UserDrawer extends StatelessWidget {
  final MainModel model;

  UserDrawer(this.model);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context,
                  '/products'); //se remplaza completamente la pagina actual
            },
          ),
        ],
      ),
    );
  }
}
