import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../models/sale.dart';

import '../widgets/ui_elements/drawer.dart';

class SalesPage extends StatefulWidget {
  final MainModel model;

  SalesPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SalesPage();
  }
}

class _SalesPage extends State<SalesPage> {
  Future<List> _fetchSalesList() async {
    final List<Sale> fetchedSalesList = [];

    http.Response response = await http
        .get('https://flutter-products-3e91e.firebaseio.com/sales.json');

    final Map<String, dynamic> salesListData = json.decode(response.body);

    salesListData.forEach((String saleId, dynamic saleData) {
      final Sale sale = Sale(
          id: saleId,
          title: saleData['title'],
          price: saleData['price'],
          qty: saleData['qty'].toString());
      fetchedSalesList.add(sale);
    });
    return fetchedSalesList;
  }

//  Widget _buildSalesTiles() {
//    return
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(widget.model),
      appBar: AppBar(
        title: Text('Ventas'),
      ),
      body: FutureBuilder<List>(
        future: _fetchSalesList(),
        initialData: List(),
        builder: (context, fetchedSalesList) {
          return fetchedSalesList.hasData
              ? ListView.builder(
                  itemCount: fetchedSalesList.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = fetchedSalesList.data[index];
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.attach_money),
                          title: Text(fetchedSalesList.data[index].title),
                          subtitle: Text(
                              'Precio unidad: ${fetchedSalesList.data[index].price}. Cantidad: ${fetchedSalesList.data[index].qty}'),
                          trailing: Text(
                              'Total: \$${int.parse(fetchedSalesList.data[index].price.substring(1)) * int.parse(fetchedSalesList.data[index].qty)}'),
                        ),
                        Divider(),
                      ],
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
