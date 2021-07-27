import 'package:flutter/material.dart';

class RouteTransitions {
  Route slideRightToLeftTransitionType(secondPage) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 100),
      reverseTransitionDuration: Duration(milliseconds: 150),
      pageBuilder: (context, animation, secondaryAnimation) => secondPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
