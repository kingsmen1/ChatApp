import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  //form password validator
  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    MaxLengthValidator(12,
        errorText: 'password should not be more than  8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-_])',
        errorText: 'passwords must have at least one special character')
  ]);

  //form email validator
  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: '*Required*'),
    EmailValidator(errorText: 'Email is no Valid!')
  ]);

//userName validator
  static final UserNameValidator = MultiValidator([
    RequiredValidator(errorText: '*Required*'),
    MinLengthValidator(4,
        errorText: 'Username should be atlest 4 characters long')
  ]);
}
