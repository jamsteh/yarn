import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class YarnSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _YarnSignUpState();
}

class _YarnSignUpState extends State<YarnSignUp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // add Login text top left
              Container(
                  padding: EdgeInsets.all(45.0),
                  child: new Form(
                      child: new Column(
                    children: <Widget>[
                      new Align(
                          alignment: Alignment.topLeft,
                          child: new Text(
                            'Create an account',
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
                                  borderSide: BorderSide(
                                      color: Colors.grey[200], width: 2.0)))),
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
                                  borderSide: BorderSide(
                                      color: Colors.grey[200], width: 2.0)))),
                      new Padding(padding: EdgeInsets.all(25.0)),
                      new Text(
                        'By signing up, you accept yarn\'s \nTerms of Service and Privacy Policy',
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
                            onPressed: () => {/* add account to firebase */},
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          )),
                    ],
                  )))
            ],
          ),
        ));
  }
}
