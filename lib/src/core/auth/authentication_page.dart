import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stario/src/core/auth/register/register_page.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'login/login_page.dart';

enum authType {
  login,
  signUp,
}

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  //bool isLogin = true;

  authType currentAuthType = authType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                currentAuthType == authType.login ? Colors.teal : Colors.deepOrange,
                Colors.black45,
              ],
            )),
            alignment: Alignment.center,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: introTitle(),
                ),
                PageTransitionSwitcher(
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return FadeThroughTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child,
                    );
                  },
                  child: currentAuthType == authType.login ? LoginPage() : RegisterPage(),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        signUpButton(),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget introTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        'STARIO',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    );
  }

  Widget signUpButton() {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          if (currentAuthType == authType.login) {
            currentAuthType = authType.signUp;
          } else {
            currentAuthType = authType.login;
          }
        });
      },
      padding: const EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: currentAuthType == authType.login
                ? 'Don\'t have an account? '
                : 'Already have an account? ',
            style: GoogleFonts.lato(fontSize: 15.0),
            children: [
              TextSpan(
                text: currentAuthType == authType.login ? 'Sign Up' : 'Log In',
                style: GoogleFonts.lato(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
