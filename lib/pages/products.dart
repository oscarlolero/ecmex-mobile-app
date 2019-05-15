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
  void initState() {//cuando se renderiza por primera vez
    widget.model.fetchProducts();

    super.initState();
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
          Widget content =  Center(child: Text('No products found.'),);
          if(model.displayedProducts.length > 0 && !model.isLoading) {
            content = Products();
          } else if(model.isLoading) {
            content = Center(child: CircularProgressIndicator(backgroundColor: Colors.deepOrange,));
          }
        return content;
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            }
          )
        ],
      ),
      body: _buildProductsList(),
    );
  }
}
