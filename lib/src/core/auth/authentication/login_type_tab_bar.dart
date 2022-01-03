import 'package:flutter/material.dart';

class LoginTypeTabBar extends StatefulWidget {
  final Function(bool) isLogin;

  LoginTypeTabBar({this.isLogin});

  @override
  _LoginTypeTabBarState createState() => _LoginTypeTabBarState();
}

class _LoginTypeTabBarState extends State<LoginTypeTabBar> {
  bool loginSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              loginSelected = true;
              widget.isLogin(loginSelected);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'LOGIN',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: loginSelected == true
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              loginSelected = false;
              widget.isLogin(loginSelected);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'SIGNUP',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: loginSelected == false
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
