import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    //cuando se renderiza por primera vez
    widget.model.fetchProducts();

    super.initState();
  }

  Widget _buildProductsList(MainModel model) {
    Widget content = Center(
      child: Text('No products found.'),
    );
    if (model.displayedProducts.length > 0 && !model.isLoading) {
      content = Products();
    } else if (model.isLoading) {
      content = Center(child: CircularProgressIndicator());
    }
    return RefreshIndicator(
      child: content,
      onRefresh: model.fetchProducts,
    );
  }

  Widget _buildTiles(MainModel model) {
    Widget content;
    if (model.isAdmin) {
      Column(
        children: <Widget>[
          content = ListTile(
            leading: Icon(Icons.edit),
            title: Text('Administrar productos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_bus),
            title: Text('Proveedores'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/providers');
            },
          ),
        ],
      );
    } else {
      content = ListTile(
        leading: Icon(Icons.contact_mail),
        title: Text('Facturación'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/admin');
        },
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Escoge'),
              ),
              _buildTiles(model),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('ECTech'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            )
          ],
        ),
        body: _buildProductsList(model),
      );
    });
  }
}
