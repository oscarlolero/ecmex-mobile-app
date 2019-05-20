import 'package:flutter/material.dart';

import '../../../scoped-models/main.dart';

 class AdminDrawer extends StatelessWidget {
   final MainModel model;

   AdminDrawer(this.model);
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
              leading: Icon(Icons.edit),
              title: Text('Manejar productos'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin'); //se remplaza completamente la pagina actual
              },
            ),
          ],
        ),
      );
  }
 }