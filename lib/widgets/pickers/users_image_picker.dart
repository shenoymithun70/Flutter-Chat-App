import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UsersImagePicker extends StatefulWidget {
  UsersImagePicker(this.imagePickFn);
  final Function(File pickedImage) imagePickFn;
  @override
  _UsersImagePickerState createState() => _UsersImagePickerState();
}

class _UsersImagePickerState extends State<UsersImagePicker> {
  File _pickedImage;
  final picker = ImagePicker();

  void _openCamera() async {
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImageFile == null) {
      return;
    }

    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: _openCamera,
          textColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
