import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final int productIndex;
  final Map<String, dynamic> product;

  ProductEditPage(
      {this.addProduct,
      this.updateProduct,
      this.product,
      this.productIndex}); //PARAMETROS OPCIONALES

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

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product tittle',
      ),
//      autovalidate: true,
      initialValue: widget.product == null ? '' : widget.product['title'],
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

  Widget _buildDescriptionField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      initialValue: widget.product == null ? '' : widget.product['description'],
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

  Widget _buildPriceTextField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Price',
        ),
        initialValue:
            widget.product == null ? '' : widget.product['price'].toString(),
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

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return; //detener ejecucion
    }
    _formKey.currentState
        .save(); //cada vez que se llame savem se ejecuta el onSaved para cada textformfield
    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildPageContent(BuildContext context) {
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
            _buildTitleTextField(),
            _buildDescriptionField(),
            _buildPriceTextField(),
            //tambien se puede usar un container
            SizedBox(height: 10.0),
//            GestureDetector(
//              onTap: _submitForm,
//              child: Container(
//                color: Colors.green,
//                padding: EdgeInsets.all(5.0),
//                child: Text('My button'),
//              ),
//            ),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: _submitForm,
            )
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
    final Widget pageContent = _buildPageContent(context);
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit product'),
            ),
            body: pageContent,
          );
  }
}
