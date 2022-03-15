import 'package:chatapp/helpers/validators.dart';
import 'dart:io';
import 'package:chatapp/picker/user_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this._isLoading);

  final bool _isLoading;

  final void Function(String email, String username, String password,
      bool isLogin, File userImage, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final Email = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();

  bool passIsHidden = true;

   File _userImage;

  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  final _formKey = GlobalKey<FormState>();

  void userImage(File receavedUserImage){
    _userImage =  receavedUserImage;
  }

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please upload the image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (_isValid) {
      //this line triggers the onSaved on every TextFormField
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userName.trim(), _userPassword.trim(),
          _isLogin, _userImage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(userImage),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    controller: Email,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.email],
                    key: ValueKey('Email'),
                    validator: Validators.emailValidator,
                    /* (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email address';
                      }
                      // Check if the entered email has the right format
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      // Return null if the entered email is valid
                      return null;
                    },*/
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Email address',
                        suffixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    const SizedBox(
                      height: 10,
                    ),
                  if (!_isLogin)
                    TextFormField(
                      enableSuggestions: false,
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      controller: userName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: ValueKey('UserName'),
                      validator: Validators.UserNameValidator,
                      /*(value) {
                        MinLengthValidator(4, errorText: 'userName should be atleast 4 Character');
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter a UserName';
                        }
                        // if (value.trim().length < 4) {
                        //   return 'UserName must be Atleast 4 characters long';
                        // }
                        return null;
                      },*/
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: 'Username',
                          suffixIcon: Icon(Icons.account_circle)),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: password,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: ValueKey('password'),
                    validator: Validators.passwordValidator,
                    /*(value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return 'Enter Password';
                    //   }
                    //   if (value.trim().length < 7) {
                    //     return 'Password must be atleast 7 Characters long';
                    //   }
                    //   return null;
                    /},*/
                    decoration: InputDecoration(
                        //hintText: 'Password',
                        // floatingLabelAlignment: FloatingLabelAlignment.start,
                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Password',
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(
                                () => passIsHidden = !passIsHidden,
                              );
                            },
                            child: const Icon(Icons.password))),
                    obscureText: passIsHidden,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    onChanged: (value) => _userPassword = value,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'SignUp')),
                  if (!widget._isLoading)
                    TextButton(
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'I already have an Account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                          userName.clear();
                          password.clear();
                          Email.clear();
                        });
                      },
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
