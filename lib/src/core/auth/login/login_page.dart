import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stario/src/core/auth/register/register_page.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/widgets/custom_rounded_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  String email;
  //String username;
  String password;

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
              nextButton(),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome back to',
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
                            'Login to your account',
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
                                  context, MaterialPageRoute(builder: (context) => RegisterPage()));
                            },
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              'Register',
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
      ),
    );
  }

  Widget inputTextFields() {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*CustomRoundedTextField(
              minLines: 1,
              maxLines: 1,
              keyboard: TextInputType.name,
              keyboardAction: TextInputAction.next,
              labelText: 'Username',
              startIcon: Icon(Icons.account_circle),
              borderColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              onTextChanged: (userInput) {
                username = userInput;
                print('dis the username' + userInput);
              },
            ),*/
            CustomRoundedTextField(
              minLines: 1,
              maxLines: 1,
              keyboard: TextInputType.emailAddress,
              keyboardAction: TextInputAction.next,
              labelText: 'Email',
              startIcon: Icon(Icons.email),
              borderColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              onTextChanged: (emailInput) {
                email = emailInput;
                print('dis the email' + emailInput);
              },
            ),
            CustomRoundedTextField(
              minLines: 1,
              maxLines: 1,
              keyboard: TextInputType.name,
              keyboardAction: TextInputAction.done,
              labelText: 'Password',
              startIcon: Icon(Icons.lock),
              password: true,
              borderColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              onTextChanged: (passwordInput) {
                password = passwordInput;
                print('dis the password' + passwordInput);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget nextButton() {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: CupertinoButton(
          onPressed: () async {
            print('$email $password');
            try {
              final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
              if (user != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SongBottomSheet()));
              }
            } catch (e) {
              print(e);
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
      ),
    );
  }
}
