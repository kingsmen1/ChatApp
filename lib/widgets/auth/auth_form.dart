import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(
      String email, String username, String password, bool isLogin) submitFn;

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
      widget.submitFn(_userEmail, _userName, _userPassword, _isLogin);
    }
  }

  //form password validator
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    MaxLengthValidator(12,
        errorText: 'password should not be more than  8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-_])',
        errorText: 'passwords must have at least one special character')
  ]);

  //form email validator
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: '*Required*'),
    EmailValidator(errorText: 'Email is no Valid!')
  ]);

  final UserNameValidator = MultiValidator([
    RequiredValidator(errorText: '*Required*'),
    MinLengthValidator(4,
        errorText: 'Username should be atlest 4 characters long')
  ]);

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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.email],
                    key: ValueKey('Email'),
                    validator: emailValidator,
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
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email)),
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
                      validator: UserNameValidator,
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
                          prefixIcon: Icon(Icons.account_circle)),
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
                    validator: passwordValidator,
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password)),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    onChanged: (value) => _userPassword = value,
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
      ),
    );
  }
}
