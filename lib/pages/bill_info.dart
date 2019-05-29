import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer.dart';

class BillInfoPage extends StatefulWidget {
  final MainModel model;

  BillInfoPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _BillInfoPage();
  }
}

class _BillInfoPage extends State<BillInfoPage> {
  Map<String, String> _formData = {
    "first_name": "",
    "last_name": "",
    "adress": "",
    "city": "",
    "cp": "",
    "email": "",
    "phone": "",
    "rfc": ""
  };

  _buildTextFields() {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Nombre',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["first_name"] = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Apellidos',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["last_name"] = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["email"] = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Dirección',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["adress"] = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'RFC',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["rfc"] = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Ciudad',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["city"] = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Código postal',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["cp"] = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Teléfono',
            labelStyle: TextStyle(color: Colors.black),
          ),
//          initialValue: product == null ? '' : product.provider,
          onChanged: (value) {
            //No es necesario el setState, es una llamada al build inncesaria
            _formData["phone"] = value;
          },
        ),
      ],
    );
  }

  _buildForm() {
    return ListView(
      children: <Widget>[
        Text(
          'Introduzca sus datos para facturar.',
          style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
        ),
        _buildTextFields(),
        SizedBox(height: 15.0),
        RaisedButton(
          child: Text('Guardar'),
          color: Theme.of(context).primaryColor,
//                  textColor: Colors.white,
          onPressed: () async {
            try {
              await http.patch(
                'https://flutter-products-3e91e.firebaseio.com/users/${widget.model.username}/bill.json',
                body: json.encode(_formData),
                headers: {
                  "content-type": "application/json",
                  "accept": "application/json",
                },
              );
              Navigator.pushReplacementNamed(context, '/products');
            } catch (e) {
              print(e);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        drawer: DrawerWidget(model),
        appBar: AppBar(
          title: Text('Facturación'),
        ),
        body: Container(margin: EdgeInsets.all(20.0), child: _buildForm()),
      );
    });
  }
}
