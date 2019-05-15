import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPage();
  }
}

class _ProductEditPage extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product title',
      ),
//      autovalidate: true,
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        //if(value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should me 5+ characters long.';
        }
      },
      onSaved: (String value) {
        //No es necesario el setState, es una llamada al build inncesaria
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionField(Product product) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      initialValue: product == null ? '' : product.description,
      validator: (String value) {
        //if(value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Description is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Price',
        ),
        initialValue: product == null ? '' : product.price.toString(),
        validator: (String value) {
          //if(value.trim().length <= 0) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Price is required and should be a number.';
          }
        },
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        });
  }

  void _submitForm(Function addProduct, Function updateProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return; //detener ejecucion
    }
    _formKey.currentState
        .save(); //cada vez que se llame savem se ejecuta el onSaved para cada textformfield
    if (selectedProductIndex == null) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      );
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      );
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Save'),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: () => _submitForm(
              model.addProduct,
              model.updateProduct,
              model
                  .selectedProductIndex), //si no se esta editando se pasara null
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? deviceWidth * 0.70
            : deviceWidth * 0.98;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextField(product),
            _buildDescriptionField(product),
            _buildPriceTextField(product),
            //tambien se puede usar un container
            SizedBox(height: 10.0),
            _buildSubmitButton(),
//            GestureDetector(
//              onTap: _submitForm,
//              child: Container(
//                color: Colors.green,
//                padding: EdgeInsets.all(5.0),
//                child: Text('My button'),
//              ),
//            ),
          ],
        ),
      ),
    );
//    return Center(
//      child: RaisedButton(
//        child: Text('Save'),
//        onPressed: () {
//          showModalBottomSheet(context: context, builder: (BuildContext context) {
//            return Center(child: Text('This a modal'));
//          });
//        },
//      ),
//    );
  }

  //Tratar de tener lo menro posible de logica en el build, solo enfocarse al diseño en el build
  //
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
