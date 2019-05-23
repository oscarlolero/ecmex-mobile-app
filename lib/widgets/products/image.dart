import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function setImage;

  ImageInput(this.setImage);

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile = null;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxHeight: 400).then((File image) {
      setState(() {
        //update state
        _imageFile = image;
      });
      widget.setImage(image);//para poder usar la imagen en product edit
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Escoge una opción',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).accentColor,
                child: Text('Cámara'),
                onPressed: () {
                  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).accentColor,
                child: Text('Galería'),
                onPressed: () {
                  _getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0),
        OutlineButton(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2.0,
          ),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Añadir imagen',
                style: TextStyle(color: Theme.of(context).accentColor),
              )
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _imageFile == null
            ? Text('Por favor añada una imagen.')
            : Image.file(
          _imageFile,
          fit: BoxFit.contain,// la ajusta bonito :v
          height: 300.0,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}
