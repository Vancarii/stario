import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stario/src/core/auth/register/register_page.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'login/login_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLogin = true;

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
              colors: [Colors.teal, Colors.black45],
            )),
            alignment: Alignment.center,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2, child: introTitle()),
                //LoginPage(),
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
        Navigator.of(context)
            .push(RouteTransitions().slideUpJoinedTransitionType(LoginPage(), RegisterPage()));
        //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      padding: const EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        /*decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white60),
            ),
            color: Colors.transparent),*/
        child: Column(
          children: [
            Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: GoogleFonts.lato(fontSize: 15.0),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: GoogleFonts.lato(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            /*Text(
              'Don\'t have an account? Sign Up',
              textAlign: TextAlign.end,
              style: GoogleFonts.lato(
                //fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
