import 'dart:io';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../../models/product.dart';
import '../../../scoped-models/main.dart';
import '../../../widgets/products/image.dart';

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
    'image': null,
    'provider': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _setImage(File image) {
    _formData['image'] = image;
  }

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Título', labelStyle: TextStyle(color: Colors.black)),
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

  Widget _buildProviderTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Proveedor', labelStyle: TextStyle(color: Colors.black)),
//      autovalidate: true,
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        //if(value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Provider is required and should me 5+ characters long.';
        }
      },
      onSaved: (String value) {
        //No es necesario el setState, es una llamada al build inncesaria
        _formData['provider'] = value;
      },
    );
  }

  Widget _buildDescriptionField(Product product) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
          labelText: 'Descripción', labelStyle: TextStyle(color: Colors.black)),
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
            labelText: 'Precio', labelStyle: TextStyle(color: Colors.black)),
        initialValue: product == null ? '' : product.price.toString(),
        validator: (String value) {
          //if(value.trim().length <= 0) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Price is required and should be a number.';
          }
        },
        onSaved: (String value) {
          _formData['price'] = int.parse(value);
        });
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return; //detener ejecucion
    }
    _formKey.currentState
        .save(); //cada vez que se llame savem se ejecuta el onSaved para cada textformfield
    if (selectedProductIndex == -1) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
        _formData['provider'],
      ).then((bool sucess) {
        if (sucess) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context, //ya tenemos una propiedad que guarda el context
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Close'),
                      textColor: Colors.deepOrange,
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                );
              });
        }
      }); //_ ignore value);
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
//        _formData['image'],
        _formData['price'],
        _formData['provider'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null))); //_ ignore value);
    }
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                child: Text('Guardar'),
                color: Theme.of(context).primaryColor,
//                  textColor: Colors.white,
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model
                        .selectedProductIndex), //si no se esta editando se pasara null
              );
      },
    );
  }

  Widget _buildPageContent(
      BuildContext context, Product product, int selectedProductIndex) {
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
              SizedBox(height: 15.0),
              _buildTitleTextField(product),
              _buildProviderTextField(product),
              _buildDescriptionField(product),
              _buildPriceTextField(product),
              selectedProductIndex == -1 ? ImageInput(_setImage) : SizedBox(height: 10.0),

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
          )),
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
        final Widget pageContent = _buildPageContent(
            context, model.selectedProduct, model.selectedProductIndex);
        return model.selectedProductIndex ==
                -1 //regresa -1 si no encuentra nada el getter
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Editar product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
