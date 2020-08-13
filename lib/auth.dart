import 'package:flutter/material.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'welcome.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class YarnAuth extends StatefulWidget {
  YarnAuth({this.formType, this.onSignedIn});
  final FormType formType;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _YarnAuthState();
}

class _YarnAuthState extends State<YarnAuth> {
  _YarnAuthState();
  final formKey = new GlobalKey<FormState>();
  bool _loading = false;

  String _email;
  String _password;

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
      setState(() => _loading = true);
      try {
        if (widget.formType == FormType.login) {
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
        widget.onSignedIn();
      } catch (e) {
        print(
            'Error: $e'); // if ERROR_USER_NOT_FOUND, then errorborder hint: email does not exist
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _loadingWidget = _loading == true
        ? buildLoadingScreen()
        : Center(); // if loadingstate is true, add it to stack
    return new Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildAuthInterface(),
              ),
              _loadingWidget,
            ],
          ),
        ));
  }

  Widget buildLoadingScreen() {
    return Center(
        // add alpha to take up whole screen
        child: Container(
      alignment: Alignment.center,
      child: Container(
        child: SpinKitCircle(color: Colors.blue, size: 50),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //         <--- border radius here
              ),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      color: Color(0x10000000),
    ));
  }

  List<Widget> buildAuthInterface() {
    String authTerm;
    String headerText;
    String actionTerm;

    if (widget.formType == FormType.login) {
      authTerm = 'Login';
      headerText = authTerm;
      actionTerm = 'logging in';
    } else {
      authTerm = 'Sign up';
      headerText = 'Create an account';
      actionTerm = 'signing up';
    }

    return [
      Container(
          padding: EdgeInsets.all(45.0),
          child: new Form(
              key: formKey,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
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
                        : !EmailValidator.validate(value.trim())
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
//                  Padding(
//                    padding: EdgeInsets.all(
//                        MediaQuery.of(context).size.height * 0.10),
//                  ),
                ],
              ))),
      Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //         <--- border radius here
                ),
          ),
          child: FlatButton(
            color: Colors.black,
            textColor: Colors.white,
            onPressed: submitAuthForm,
            child: Text(
              authTerm,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          )),
    ];
  }
}
