import 'package:flutter/material.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome.dart';

class Yarn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _YarnState();
}

class _YarnState extends State<Yarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('WELCOME!!!')));
  }
}
