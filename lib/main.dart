import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'welcome.dart';

void main() {
  Paint.enableDithering = true;
  runApp(YarnMain()); // app name idea: yall
}

class YarnMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yarn',
      theme: ThemeData(
          buttonTheme: ButtonThemeData(),
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Helvetica'),
      // the reason why this isn't working is because I haven't added
      // a home route yet. add home: and add a stateful widget
      // with a constructor for this class
      home: YarnWelcome(),
    );
  }
}
