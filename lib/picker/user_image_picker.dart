import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);


  final void Function  (File pickedImage ) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File pickedImage;

  void uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final _image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    final userImage = File(_image.path);
    setState(() {
      pickedImage = userImage;
    });
    widget.imagePickFn(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pickedImage == null
            ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
                height: 250,
                color: Colors.red,
                width: 200,
                child: Image.asset('assets/images/no_image.jpg' , fit: BoxFit.cover,)))
            :ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
                color: Colors.red,
                height: 250,
                width: 200,
                child: Image.file(pickedImage ,fit: BoxFit.cover,) )),
        TextButton.icon(
            onPressed: uploadImage,
            icon: Icon(Icons.image),
            label: Text('Upload Image')),
      ],
    );
  }
}
