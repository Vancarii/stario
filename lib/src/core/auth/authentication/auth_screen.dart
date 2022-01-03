import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'auth_card.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  double currentSignupStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Theme.of(context).primaryColor, Colors.black45],
              )),
              child: Align(alignment: Alignment.center, child: AuthCard()))),
      /*bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            child: DotsIndicator(
              dotsCount: 3,
              position: currentSignupStep,
              decorator: DotsDecorator(
                color: Colors.black12,
                activeColor: Colors.white,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}
