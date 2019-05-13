import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePage();
  }
}

class _ProductCreatePage extends State<ProductCreatePage> {
  String _titleValue, _descriptionValue; //se puede o no inicializar
  double _priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                  labelText: 'Product tittle',
                ),
                onChanged: (String value) {
                  setState(() {
                    _titleValue = value;
                  });
                }),
            TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (String value) {
                  setState(() {
                    _descriptionValue = value;
                  });
                }),
            TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                onChanged: (String value) {
                  setState(() {
                    _priceValue = double.parse(value);
                  });
                }),
            //tambien se puede usar un container
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                // dynamic porque puede ser string o double
                final Map<String, dynamic> product = {
                  'title': _titleValue,
                  'description': _descriptionValue,
                  'price': _priceValue,
                  'image': 'assets/food.jpg'
                };
                widget.addProduct(product);
                Navigator.pushReplacementNamed(context, '/products');
              },
            )
          ],
        ));
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
}
