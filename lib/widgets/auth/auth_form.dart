import 'package:chatapp/helpers/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn  , this._isLoading);

  final bool _isLoading ;

  final void Function(
      String email, String username, String password, bool isLogin , BuildContext ctx ) submitFn;

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
      widget.submitFn(_userEmail.trim(), _userName.trim(), _userPassword.trim(), _isLogin , context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding:const  EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
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
                        suffixIcon: const Icon(Icons.password)),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    onChanged: (value) => _userPassword = value,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if(widget._isLoading)CircularProgressIndicator(),
                  if(!widget._isLoading)
                  ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'SignUp')),
                  if(!widget._isLoading)
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
      ),
    );
  }
}
