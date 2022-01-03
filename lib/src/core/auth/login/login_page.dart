import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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

  String _loginUsername;
  String _loginEmail;
  String _loginPassword;

  String emailErrorMessage;
  String passwordErrorMessage;

  bool loginButtonPressed = false;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).primaryColor, Colors.black45],
          )),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              introTitle(),
              inputTextFields(),
              buttonsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget introTitle() {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Hero(
                tag: 'intro_logo',
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'STARIO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
        ],
      ),
    );
  }

  Widget usernameTextField() {
    return CustomRoundedTextField(
      minLines: 1,
      maxLines: 1,
      keyboard: TextInputType.name,
      keyboardAction: TextInputAction.next,
      labelText: 'Username',
      startIcon: Icon(Icons.account_circle),
      borderColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      onTextChanged: (userInput) {
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
      borderColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      errorText: emailErrorMessage,
      onTextChanged: (emailInput) {
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
        icon: passwordIsVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        onPressed: () {
          setState(() {
            passwordIsVisible = !passwordIsVisible;
          });
        },
      ),
      password: !passwordIsVisible,
      borderColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(top: 15.0),
      errorText: passwordErrorMessage,
      onTextChanged: (passwordInput) {
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

  CupertinoButton otherLoginMethodButton({IconData icon, Function onPressed}) {
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
              color: Colors.white,
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

  Widget buttonsRow() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                child: RoundedLoadingButton(
                  borderRadius: 10.0,
                  color: Theme.of(context).accentColor,
                  width: 200,
                  height: 60,
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
                        Timer(Duration(seconds: 1), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongBottomSheet(),
                            ),
                          );
                        });
                      }
                    } catch (e) {
                      _loginBtnController.error();
                      print(e);
                    }
                  },
                ),
              ),
              /*CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                onPressed: () async {
                  setState(() {
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
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => SongBottomSheet()));
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  width: 200,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Theme.of(context).accentColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(2, 2)),
                    ],
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),*/
              otherLoginMethodButton(icon: FontAwesomeIcons.facebook, onPressed: () {}),
              otherLoginMethodButton(icon: FontAwesomeIcons.google, onPressed: () {}),
            ],
          ),
          CupertinoButton(
            onPressed: () {
              Navigator.of(context).push(
                  RouteTransitions().slideUpJoinedTransitionType(LoginPage(), RegisterPage()));
              //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white70,
                ),
                Text(
                  'Sign Up',
                  textAlign: TextAlign.end,
                  style: GoogleFonts.lato(
                    //fontStyle: FontStyle.italic,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
