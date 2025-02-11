import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stario/src/core/auth/login/login_page.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'package:stario/src/shared_prefs/shared_prefs.dart';
import 'package:stario/src/widgets/custom_rounded_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //database
  final _firestore = FirebaseFirestore.instance;

  //authentication
  final _auth = FirebaseAuth.instance;

  String _newUserUid;

  final RoundedLoadingButtonController _registerBtnController = RoundedLoadingButtonController();

  String _registerName;
  String _registerEmail;
  String _registerUsername;
  String _registerPassword;

  String nameErrorMessage;
  String usernameErrorMessage;
  String emailErrorMessage;
  String passwordErrorMessage;

  bool passwordIsVisible = false;

  bool _registerButtonPressed = false;

  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return inputTextFields(); /*SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Theme.of(context).primaryColor, Colors.black45],
            )),
            alignment: Alignment.center,
            child: Column(
              */ /* mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,*/ /*
              children: [
                Expanded(flex: 2, child: introTitle()),
                inputTextFields(),
                //nextButton(),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        logInButton(),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );*/
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
      color: Colors.transparent,
      //padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            nameTextField(),
            usernameTextField(),
            emailTextField(),
            passwordTextField(),
            signUpButton(),
            orDivider(),
            buttonsRow(),
          ],
        ),
      ),
    );
  }
  /*Widget introTitle() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Welcome to',
                  style: GoogleFonts.lato(
                    fontStyle: FontStyle.italic,
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                  ),
                ),
                Text(
                  'Stario',
                  style: GoogleFonts.marckScript(
                    fontWeight: FontWeight.w600,
                    fontSize: 69.0,
                    shadows: [
                      BoxShadow(
                          color: Colors.white38,
                          blurRadius: 5,
                          spreadRadius: 5,
                          offset: Offset(5, 5)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Register a new account',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.lato(
                            //fontStyle: FontStyle.italic,
                            color: Colors.white54,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            'Login',
                            textAlign: TextAlign.end,
                            style: GoogleFonts.lato(
                              //fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

  Widget nameTextField() {
    return CustomRoundedTextField(
      minLines: 1,
      maxLines: 1,
      formatter: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
      ],
      keyboard: TextInputType.name,
      keyboardAction: TextInputAction.next,
      labelText: 'Full name',
      startIcon: Icon(Icons.person),
      borderColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      errorText: nameErrorMessage,
      onTextChanged: (userInput) {
        _registerBtnController.reset();

        _registerName = userInput;
        print('dis the name' + _registerName);

        if (nameErrorMessage != null) {
          nameErrorMessage = null;
        }
      },
      /* validator: (value) {
        if (_registerButtonPressed = true) {
          _registerButtonPressed = false;
          if (value.isEmpty) {
            nameErrorMessage = 'Please enter your name';
          }
        }
      },*/
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
      labelText: 'Unique Username / Handle',
      startIcon: Icon(FontAwesomeIcons.at),
      borderColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      errorText: usernameErrorMessage,
      onTextChanged: (userInput) {
        _registerBtnController.reset();

        _registerUsername = userInput;
        print('dis the username' + userInput);
        setState(() {
          if (usernameErrorMessage != null) {
            usernameErrorMessage = null;
          }
        });
      },
      validator: (value) {
        if (_registerButtonPressed = true) {
          _registerButtonPressed = false;
          if (value.isEmpty) {
            usernameErrorMessage = 'Please enter a username';
          } else if (value.length < 4) {
            usernameErrorMessage = 'Username must be longer than 4 characters';
          } else if (value.length > 50) {
            usernameErrorMessage = 'Username cannot be longer than 50 characters';
          } else {
            usernameErrorMessage = null;
          }
        }
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
        _registerBtnController.reset();

        _registerEmail = emailInput;
        print('dis the email' + emailInput);

        setState(() {
          if (emailErrorMessage != null) {
            emailErrorMessage = null;
          }
        });
      },
      validator: MultiValidator(
        [
          EmailValidator(errorText: 'Enter a valid email address'),
        ],
      ),
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
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      errorText: passwordErrorMessage,
      onTextChanged: (passwordInput) {
        _registerBtnController.reset();

        _registerPassword = passwordInput;
        print('dis the password' + passwordInput);

        setState(() {
          if (passwordErrorMessage != null) {
            passwordErrorMessage = null;
          }
        });
      },
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

  /*Widget nextButton() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                //fontStyle: FontStyle.italic,
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          ),
          CupertinoButton(
            onPressed: () async {
              print('$_registerEmail $_registerPassword $_registerUsername');
              setState(() {
                _registerButtonPressed = true;
                if (_registerUsername == null) {
                  usernameErrorMessage = 'Please enter a username';
                }
                if (_registerEmail == null) {
                  emailErrorMessage = 'Please enter an email';
                }
                if (_registerPassword == null) {
                  passwordErrorMessage = 'Please enter a password';
                }
              });
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: _registerEmail, password: _registerPassword);
                if (newUser != null) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SongBottomSheet()));
                }
              } catch (e) {
                print(e.message);
                setState(() {
                  //errorMessage = e.message.toString();
                });
              }
            },
            child: Container(
              width: 69,
              height: 69,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black, blurRadius: 2, spreadRadius: 2, offset: Offset(2, 2)),
                ],
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  Widget signUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: RoundedLoadingButton(
        borderRadius: 10.0,
        color: Colors.deepOrange,
        successColor: Colors.deepOrange,
        width: MediaQuery.of(context).size.width,
        child: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        controller: _registerBtnController,
        onPressed: () async {
          print('$_registerEmail $_registerPassword $_registerUsername');

          setState(() {
            _registerBtnController.start();

            _registerButtonPressed = true;
            if (_registerName == null) {
              nameErrorMessage = 'Please enter a name';
            }
            if (_registerUsername == null) {
              usernameErrorMessage = 'Please enter a username';
            }
            if (_registerEmail == null) {
              emailErrorMessage = 'Please enter an email';
            }
            if (_registerPassword == null) {
              passwordErrorMessage = 'Please enter a password';
            }
          });
          try {
            //FIREBASE
            //Creates a new use in the firebase AUTHENTICATION section
            final newUser = await _auth.createUserWithEmailAndPassword(
                email: _registerEmail, password: _registerPassword);

            if (newUser != null) {
              _registerBtnController.success();

              //Creates a new user document in the DATABASE 'users' collection

              //saves user UID
              _newUserUid = newUser.user.uid;

              _firestore.collection('users').doc(_registerUsername).set({
                'artist name': _registerName,
                'uid': _newUserUid,
                //TODO: use this for user 'new release'
                /*'songs': [
                  {'song name': 'name1', 'song location': 'locate1'},
                  {'song name': 'name2', 'song location': 'locate2'},
                ],*/
              });

              //Save the username  so that it stays logged in and the app knows whos logged in
              SharedPrefs.instance.username = '$_registerUsername';
              SharedPrefs.instance.artistName = '$_registerName';

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
            _registerBtnController.error();

            print(e.message);
            setState(() {
              //errorMessage = e.message.toString();
            });
          }
        },
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

  Widget logInButton() {
    return CupertinoButton(
      onPressed: () {
        Navigator.pop(context);
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
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: GoogleFonts.lato(fontSize: 15.0),
                children: [
                  TextSpan(
                    text: 'Log In',
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
