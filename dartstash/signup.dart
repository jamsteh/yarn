import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import '../lib/welcome.dart';

class YarnSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _YarnSignUpState();
}

// create a form object/widget for less code / easier readability
class _YarnSignUpState extends State<YarnSignUp> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType formType = FormType.register;
  String _errMsg;

  bool isValidAccount() {
    final currentForm = formKey.currentState;
    if (currentForm.validate()) {
      currentForm.save();
      return true;
    }
    return false;
  }

  void submitAuthForm() async {
    if (isValidAccount()) {
      try {
        if (formType == FormType.login) {
          FirebaseUser user = (await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _email.trim(), password: _password))
              .user;
          print('Signed in: ${user.uid}');
        } else {
          FirebaseUser user = (await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _email.trim(), password: _password))
              .user;
          print('Created account: ${user.uid}');
        }
      } catch (e) {
        print(
            'Error: $e'); // if ERROR_USER_NOT_FOUND, then errorborder hint: email does not exist

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildAuthInterface(),
          ),
        ));
  }

  List<Widget> buildAuthInterface() {
    String headerText;
    String actionTerm;

    if (formType == FormType.login) {
      headerText = 'Login';
      actionTerm = 'logging in';
    } else {
      headerText = 'Create an account';
      actionTerm = 'signing up';
    }

    return [
      Container(
          padding: EdgeInsets.all(45.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Align(
                      alignment: Alignment.topLeft,
                      child: new Text(
                        headerText,
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold),
                      )),
                  new Padding(padding: EdgeInsets.all(8.0)),
                  new TextFormField(
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'University E-mail',
                        fillColor: Colors.grey[200],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[200], width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (value) => value.isEmpty
                        ? 'FIELD REQUIRED'
                        : EmailValidator.validate(value)
                            ? 'INVALID EMAIL'
                            : null,
                    onSaved: (value) => _email = value,
                  ),
                  new Padding(padding: EdgeInsets.all(5.0)),
                  new TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[200], width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (value) => value.isEmpty
                        ? 'FIELD REQUIRED'
                        : value.length < 6
                            ? 'PASSWORD MUST BE AT LEAST 6 CHARACTERS'
                            : null,
                    onSaved: (value) => _password = value,
                  ),
                  new Padding(padding: EdgeInsets.all(25.0)),
                  new Text(
                    'By $actionTerm, you accept yarn\'s \nTerms of Service and Privacy Policy',
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.10),
                  ),
                  Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                      child: FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: submitAuthForm,
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      )),
                ],
              )))
    ];
  }
}
