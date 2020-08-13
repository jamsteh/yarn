import 'package:flutter/material.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'welcome.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      )),
    );
  }
}
