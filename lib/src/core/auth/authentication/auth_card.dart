import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'auth_screen.dart';
import 'auth_textfield.dart';
import 'login_type_tab_bar.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with TickerProviderStateMixin {
  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool isLogin = true;

  AnimationController _opacityAnimController;
  AnimationController _firstLoadAnimController;
  AnimationController _sizeAnimationController;

  unfocusAllNodes() {
    usernameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  Animation<Offset> firstLoadAnimation({int speed}) {
    return Tween<Offset>(
      begin: Offset(
        speed == 1
            ? -2.0
            : speed == 2
                ? -4.0
                : speed == 3
                    ? -6.0
                    : -2.0,
        0.0,
      ),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _firstLoadAnimController,
      curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  Animation<double> opacityAnimation() {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _opacityAnimController,
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.linear),
    ));
  }

  Animation<double> sizeAnimation({bool isTextField}) {
    return Tween<double>(
      begin: isTextField == true ? 0.0 : 1.0,
      end: isTextField == true ? 1.0 : 0.0,
    ).animate(CurvedAnimation(
      parent: _sizeAnimationController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOutBack),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeInOutQuad),
    ));
  }

  @override
  void initState() {
    _firstLoadAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _opacityAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));

    Future.delayed(Duration(milliseconds: 400), () {
      _firstLoadAnimController.forward();
      _opacityAnimController.forward();
    });

    _sizeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));

    super.initState();
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(35.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: opacityAnimation(),
                    child: LoginTypeTabBar(
                      isLogin: (login) {
                        setState(() {
                          isLogin = login;
                          print(isLogin);
                          unfocusAllNodes();
                          if (isLogin == false) {
                            _sizeAnimationController.forward();
                          } else {
                            _sizeAnimationController.reverse();
                          }
                        });
                      },
                    ),
                  ),
                  /*Divider(
                    color: Colors.black.withOpacity(0.4),
                    endIndent: 15.0,
                    indent: 15.0,
                    thickness: 0.5,
                  ),*/
                  SizedBox(
                    height: 15.0,
                  ),
                  buildUsernameField(),
                  buildEmailField(),
                  buildPasswordField(),
                  buildConfirmPasswordField(),
                  FadeTransition(
                    opacity: opacityAnimation(),
                    child: SizeTransition(
                      sizeFactor: sizeAnimation(isTextField: false),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: InkWell(
                      onTap: () {
                        if (isLogin == true) {
                          Navigator.pushReplacement(
                              context,
                              RouteTransitions().slideRightToLeftJoinedTransitionType(
                                  AuthScreen(), SongBottomSheet()));
                        }
                      },
                      child: FadeTransition(
                        opacity: opacityAnimation(),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            boxShadow: [
                              BoxShadow(spreadRadius: 2, blurRadius: 2, offset: Offset(2, 2))
                            ],
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Text(
                            isLogin == true ? 'Login' : 'Next',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUsernameField() {
    return SlideTransition(
      position: firstLoadAnimation(speed: 1),
      child: AuthTextField(
        node: usernameFocusNode,
        keyboardAction: TextInputAction.next,
        keyboard: TextInputType.name,
        labelText: 'Username',
        startIcon: Icon(Icons.account_circle),
        onSubmit: (String text) {
          usernameFocusNode.unfocus();
          if (isLogin == true) {
            FocusScope.of(context).requestFocus(passwordFocusNode);
          } else {
            FocusScope.of(context).requestFocus(emailFocusNode);
          }
        },
      ),
    );
  }

  Widget buildEmailField() {
    return SizeTransition(
      sizeFactor: sizeAnimation(isTextField: true),
      child: AuthTextField(
        node: emailFocusNode,
        keyboardAction: TextInputAction.next,
        keyboard: TextInputType.emailAddress,
        onSubmit: (String text) {
          emailFocusNode.unfocus();
          FocusScope.of(context).requestFocus(passwordFocusNode);
        },
        labelText: 'Email',
        startIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildPasswordField() {
    return SlideTransition(
      position: firstLoadAnimation(speed: 2),
      child: AuthTextField(
        node: passwordFocusNode,
        keyboardAction: isLogin == true ? TextInputAction.done : TextInputAction.next,
        password: true,
        onSubmit: (String text) {
          passwordFocusNode.unfocus();
          if (isLogin == true) {
            //submit
          } else {
            FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
          }
          //login or if its signup then go to confirm password
        },
        labelText: 'Password',
        startIcon: Icon(Icons.lock),
      ),
    );
  }

  Widget buildConfirmPasswordField() {
    return SizeTransition(
      sizeFactor: sizeAnimation(isTextField: true),
      child: AuthTextField(
        node: confirmPasswordFocusNode,
        password: true,
        keyboardAction: TextInputAction.done,
        keyboard: TextInputType.name,
        onSubmit: (String text) {
          unfocusAllNodes();
          //submit
        },
        labelText: 'Confirm Password',
        startIcon: Icon(Icons.lock),
      ),
    );
  }
}
