import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'auth.dart';

class YarnWelcome extends StatefulWidget {
  YarnWelcome({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _YarnWelcomeState();
}

enum FormType { login, register }

class _YarnWelcomeState extends State<YarnWelcome> {
  Color color1 = Colors.white;
  Color color2 = Colors.black;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/yarn_ball.svg',
                    width: 150, height: 150)),
            Align(
                alignment: Alignment.center,
                child: Text(
                  'yarn',
                  style: TextStyle(
                      fontFamily: 'Sriracha',
                      fontSize: 75,
                      color: Colors.black),
                )),
            Padding(
              padding: EdgeInsets.all(125),
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
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
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => YarnAuth(
                                formType: FormType.login,
                                onSignedIn: widget.onSignedIn,
                              ),
                            ))
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ))),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //         <--- border radius here
                          ),
                    ),
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => YarnAuth(
                                formType: FormType.register,
                                onSignedIn: widget.onSignedIn,
                              ),
                            ))
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
