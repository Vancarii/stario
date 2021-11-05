import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginTest extends StatefulWidget {
  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController controller = TextEditingController();
//  final RegExp _phoneRegex = RegExp(r"^\+{1}\d{10, 15}\$");
  bool isError = false;
  bool isWriting = false;
  bool isLoginPressed = false;
  int counter = 0;
  String myErrorString = "";
  TextSelection currentPosition;
  final _textKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapSample'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: _textKey,
              child: TextFormField(
                controller: controller,
                validator: (str) {
                  myErrorString = "";
                  if (isLoginPressed) {
                    isError = true;
                    if (str.isEmpty) {
                      myErrorString = 'err_empty_field';
                      return myErrorString;
                    } else if (str.length < 10) {
                      myErrorString = 'err_invalid_phone';
                      validateMe();
                      return myErrorString;
                    }
                    /*else if (!_phoneRegex.hasMatch(str)) {
                      myErrorString = 'err_invalid_phone';
                      validateMe();
                      return myErrorString;
                    }*/
                    isError = false;
                    myErrorString = "";
                  } else {
                    myErrorString = "";
                  }
                },
              ),
              onChanged: () {
                counter++;
                if (counter == 9) {
                  counter = 0;
                  isLoginPressed = false;
                }
                if (isLoginPressed) {
                } else {
                  isWriting = true;
                  isLoginPressed = false;
                  myErrorString = "";
                  _textKey.currentState.validate();
                }
              },
            ),
            RaisedButton(
              onPressed: () {
                counter = 1;
                isWriting = false;
                isLoginPressed = true;
                _textKey.currentState.validate();
              },
              child: Text('login'),
            )
          ],
        ),
      ),
    );
  }

  void validateMe() {
    if (isLoginPressed) {
      currentPosition = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
      String currentText = controller.text;
      _textKey.currentState.reset();
      controller.text = currentText;
      controller.selection = currentPosition;
      isWriting = false;
      isLoginPressed = true;
    }
  }
}
