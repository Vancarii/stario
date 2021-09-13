import 'package:flutter/material.dart';
import 'package:stario/src/main/body/sub_screens/share_sheet.dart';

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

  Route slideRightToLeftJoinedTransitionType(currentPage, nextPage) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 200),
      reverseTransitionDuration: Duration(milliseconds: 200),
      maintainState: true,
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOut;

        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: child,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: currentPage,
            )
          ],
        );
      },
    );
  }
}

showShareSheet(BuildContext context) {
  return Navigator.push(
    context,
    TransparentRoute(
      duration: 0,
      builder: (context) => ShareSheet(),
    ),
  );
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    this.duration = 350,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;
  final int duration;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: duration);

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}
