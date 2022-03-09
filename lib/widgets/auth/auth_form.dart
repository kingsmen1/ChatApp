import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      //this line triggers the onSaved on every TextFormField
      _formKey.currentState.save();
      print(_userPassword);
      print(_userName);
      print(_userEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
              TextFormField(
              key: ValueKey('Email'),
              validator: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return 'Please enter your email address';
                }
                // Check if the entered email has the right format
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                // Return null if the entered email is valid
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email address',
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                _userEmail = value;
              },
            ),
              if (!_isLogin)
              TextFormField(
                key: ValueKey('UserName'),
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Enter a UserName';
                  }
                  if (value
                      .trim()
                      .length < 4) {
                    return 'UserName must be Atleast 4 characters long';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                onSaved: (value) {
                  _userName = value;
                },
              ),

              TextFormField(
                key: ValueKey('password'),
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Enter Password';
                  }
                  if (value
                      .trim()
                      .length < 7) {
                    return 'Password must be atleast 7 Characters long';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                onSaved: (value) {
                  _userPassword = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: _trySubmit,
                  child: Text(_isLogin ? 'Login' : 'SignUp')),
              TextButton(
                child: Text(_isLogin
                    ? 'Create New Account'
                    : 'I already have an Account'),
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    print(_isLogin);
                  });
                },
              ),
              ],
            )),
      ),
    ),);
  }
}
