import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;


  void _submitAuthForm(String email, String username, String password,
      bool isLogin, File userImage, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg');

        // String  url ;

        UploadTask putFileResponse = ref.putFile(userImage);
        putFileResponse.whenComplete(() async {
          final url = await ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user.uid)
              .set({'UserName': username, 'email': email, 'userImage': url});
        });
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An Error Occured . Please check your Credentials';
      if (err.message != null) {
        message = err.message;
        setState(() {
          _isLoading = false;
        });
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(message),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}
