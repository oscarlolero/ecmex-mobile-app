import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../models/product.dart';

class ProductsAdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); //si no se pasa un node se oculta el teclado
        },
        child: Scaffold(
          drawer: Drawer(
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
                    Navigator.pushReplacementNamed(context, '/products'); //se remplaza completamente la pagina actual
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Manage products'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: 'Create product',
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'My products',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(),
              ProductListPage()
            ],
          ),
        ),
      ),
    );
  }
}
