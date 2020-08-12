import 'package:flutter/material.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome.dart';
import 'yarn.dart';

class YarnRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _YarnRootState();
}

class _YarnRootState extends State<YarnRoot> {
  AuthStatus _authStatus = AuthStatus.notAuthenticated;

  // create method to check if initally authenticated
  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  void _signedIn() {
    setState(() {
      print('state changed for root');
      _authStatus = AuthStatus.authenticated;
    });
  }

  @override
  void initState() {
    super.initState();
    currentUser().then((userId) {
      setState(() {
        //_authStatus = userId == null
        //    ? AuthStatus.notAuthenticated
        //    : AuthStatus.authenticated;
        print(userId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notAuthenticated:
        return new YarnWelcome(
          onSignedIn: _signedIn,
        );
      case AuthStatus.authenticated:
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Yarn()),
            (Route<dynamic> route) => false,
          );
        });
    }
  }
}

enum AuthStatus { authenticated, notAuthenticated }
