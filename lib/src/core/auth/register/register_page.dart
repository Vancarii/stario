import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stario/src/core/auth/login/login_page.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/widgets/custom_rounded_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  String email;
  String username;
  String password;

  String usernameErrorMessage;
  String emailErrorMessage;
  String passwordErrorMessage;

  bool nextButtonPressed = false;

  Key _formKey = GlobalKey<FormState>();

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              introTitle(),
              inputTextFields(),
              nextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget introTitle() {
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
  }

  Widget inputTextFields() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomRoundedTextField(
              minLines: 1,
              maxLines: 1,
              formatter: [
                FilteringTextInputFormatter.allow(RegExp('[a-z0-9._-]')),
              ],
              keyboard: TextInputType.name,
              keyboardAction: TextInputAction.next,
              labelText: 'Username',
              startIcon: Icon(Icons.account_circle),
              borderColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              errorText: usernameErrorMessage,
              onTextChanged: (userInput) {
                username = userInput;
                print('dis the username' + userInput);
                setState(() {
                  if (usernameErrorMessage != null) {
                    usernameErrorMessage = null;
                  }
                });
              },
              validator: (value) {
                if (nextButtonPressed = true) {
                  nextButtonPressed = false;
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
            ),
            CustomRoundedTextField(
              minLines: 1,
              maxLines: 1,
              keyboard: TextInputType.emailAddress,
              keyboardAction: TextInputAction.next,
              labelText: 'Email',
              startIcon: Icon(Icons.email),
              borderColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              errorText: emailErrorMessage,
              onTextChanged: (emailInput) {
                email = emailInput;
                print('dis the email' + emailInput);

                setState(() {
                  if (emailErrorMessage != null) {
                    emailErrorMessage = null;
                  }
                });
              },
              validator: EmailValidator(errorText: 'enter a valid email address'),
            ),
            CustomRoundedTextField(
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
              password: true,
              borderColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              errorText: passwordErrorMessage,
              onTextChanged: (passwordInput) {
                password = passwordInput;
                print('dis the password' + passwordInput);

                setState(() {
                  if (passwordErrorMessage != null) {
                    passwordErrorMessage = null;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget nextButton() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          /*Padding(
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
          ),*/
          CupertinoButton(
            onPressed: () async {
              print('$email $password $username');
              setState(() {
                nextButtonPressed = true;
                if (username == null) {
                  usernameErrorMessage = 'Please enter a username';
                }
                if (email == null) {
                  emailErrorMessage = 'Please enter an email';
                }
                if (password == null) {
                  passwordErrorMessage = 'Please enter a password';
                }
              });
              try {
                final newUser =
                    await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
  }
}
