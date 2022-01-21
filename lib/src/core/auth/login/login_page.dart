import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stario/src/core/auth/register/register_page.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'package:stario/src/widgets/custom_rounded_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  final RoundedLoadingButtonController _loginBtnController = RoundedLoadingButtonController();

  bool passwordIsVisible = false;

  bool loginButtonPressed = false;

  String _loginUsername;
  String _loginEmail;
  String _loginPassword;

  String emailErrorMessage;
  String passwordErrorMessage;

  String logInErrorMessage;

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
                inputTextFields(),
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

  Widget inputTextFields() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //usernameTextField(),
          emailTextField(),
          passwordTextField(),
          forgotPasswordButton(),
          logInButton(),
          orDivider(),
          buttonsRow(),
        ],
      ),
    );
  }

  Widget buttonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        otherLoginMethodButton(
            icon: FontAwesomeIcons.facebook, onPressed: () {}, borderColor: Colors.blue),
        otherLoginMethodButton(
            icon: FontAwesomeIcons.google, onPressed: () {}, borderColor: Colors.red),
        otherLoginMethodButton(
            icon: FontAwesomeIcons.twitter, onPressed: () {}, borderColor: Colors.lightBlueAccent),
      ],
    );
  }

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.white60,
              thickness: 1,
            ),
          ),
          Text('OR'),
          Expanded(
            child: Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.white60,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget logInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: RoundedLoadingButton(
        borderRadius: 10.0,
        color: Theme.of(context).accentColor,
        width: MediaQuery.of(context).size.width,
        child: Text(
          'Log In',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        controller: _loginBtnController,
        onPressed: () async {
          setState(() {
            _loginBtnController.start();

            loginButtonPressed = true;
            if (_loginEmail == null) {
              emailErrorMessage = 'Please enter an email';
            }
            if (_loginPassword == null) {
              passwordErrorMessage = 'Please enter a password';
            }
          });
          print('$_loginUsername $_loginEmail $_loginPassword');
          try {
            final user = await _auth.signInWithEmailAndPassword(
                email: _loginEmail, password: _loginPassword);
            if (user != null) {
              _loginBtnController.success();
              //Navigator.of(context).popUntil((route) => route.isFirst);

              //Save the user email so that it stays login
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', '$_loginEmail');

              Timer(
                Duration(milliseconds: 500),
                () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongBottomSheet(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              );
            }
          } catch (e) {
            _loginBtnController.error();
            print('errormessage: $e');
            print('REPLACED ERROR MESSAGE' +
                e.toString().substring(e.toString().indexOf(']') + 1, e.toString().length));
          }
        },
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

  Widget usernameTextField() {
    return CustomRoundedTextField(
      minLines: 1,
      maxLines: 1,
      formatter: [
        FilteringTextInputFormatter.allow(RegExp('[a-z0-9._-]')),
      ],
      keyboard: TextInputType.name,
      keyboardAction: TextInputAction.next,
      labelText: 'Username',
      startIcon: Icon(Icons.account_circle),
      borderColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      onTextChanged: (userInput) {
        _loginBtnController.reset();

        _loginUsername = userInput;
        print('dis the username' + userInput);
      },
    );
  }

  Widget emailTextField() {
    return CustomRoundedTextField(
      minLines: 1,
      maxLines: 1,
      keyboard: TextInputType.emailAddress,
      keyboardAction: TextInputAction.next,
      labelText: 'Email',
      startIcon: Icon(Icons.email),
      borderColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      errorText: emailErrorMessage,
      onTextChanged: (emailInput) {
        _loginBtnController.reset();

        _loginEmail = emailInput;
        print('dis the email' + emailInput);
        setState(() {
          if (emailErrorMessage != null) {
            emailErrorMessage = null;
          }
          if (loginButtonPressed == true) {
            print('this is the email value $emailInput');
            loginButtonPressed = false;
            if (emailInput.isEmpty) {
              emailErrorMessage = 'Please enter an email';
            } else {
              emailErrorMessage = null;
            }
          }
        });
      },
      /* validator: (value) {
                if (_loginButtonPressed = true) {
                  print('this is the email value $value');
                  _loginButtonPressed = false;
                  if (value.isEmpty) {
                    emailErrorMessage = 'Please enter an email';
                  } else {
                    emailErrorMessage = null;
                  }
                }
              },*/
    );
  }

  Widget passwordTextField() {
    return CustomRoundedTextField(
      minLines: 1,
      maxLines: 1,
      formatter: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.deny(RegExp('[ ]'))
      ],
      keyboard: TextInputType.name,
      keyboardAction: TextInputAction.done,
      labelText: 'Password',
      startIcon: Icon(Icons.lock),
      endIcon: IconButton(
        icon: passwordIsVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        onPressed: () {
          setState(() {
            passwordIsVisible = !passwordIsVisible;
          });
        },
      ),
      password: !passwordIsVisible,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.only(top: 10.0),
      errorText: passwordErrorMessage,
      onTextChanged: (passwordInput) {
        _loginBtnController.reset();

        _loginPassword = passwordInput;
        print('dis the password' + passwordInput);

        setState(() {
          if (passwordErrorMessage != null) {
            passwordErrorMessage = null;
          }
        });
      },
    );
  }

  Widget forgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  CupertinoButton otherLoginMethodButton(
      {IconData icon, Function onPressed, Color borderColor = Colors.white}) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.transparent,
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          )),
      onPressed: onPressed,
    );
  }
}
