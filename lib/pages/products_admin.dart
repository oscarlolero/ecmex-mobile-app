import 'package:flutter/material.dart';

import 'package:first_app/pages/subpage/product/product_edit.dart';
import 'package:first_app/pages/subpage/product/product_list.dart';

import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;

  ProductsAdminPage(this.model);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); //si no se pasa un node se oculta el teclado
        },
        child: Scaffold(
          drawer: DrawerWidget(model),
          appBar: AppBar(
            title: Text('Manejar productos'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: 'Crear producto',
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'Editar producto',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(),
              ProductListPage(model)
            ],
          ),
        ),
      ),
    );
  }
}
