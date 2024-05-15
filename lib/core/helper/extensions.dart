import 'package:flutter/material.dart';

import '../widgets/animated/animated_navigator/ainmated_zoom_navigator.dart';
import '../widgets/animated/animated_navigator/animated_left_to_right_navigator.dart';

// Navigation extension for help me => context.pushNamed/pushReplacementNamed...()
extension Navigation on BuildContext {
  Future<dynamic> push(
    Widget screen,
  ) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<dynamic> pushReplacement(
    Widget screen,
  ) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<dynamic> pushZoomAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).push(
      ZoomPageRoute(page: screen),
    );
  }

  Future<dynamic> pushReplacementZoomAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).pushReplacement(
      ZoomPageRoute(page: screen),
    );
  }

  Future<dynamic> pushLeftToRightAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).push(
      LeftToRightPageRoute(page: screen),
    );
  }

  Future<dynamic> pushReplacementLeftToRightAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).pushReplacement(
      LeftToRightPageRoute(page: screen),
    );
  }

  Future<dynamic> pushTopToBottomAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> pushReplacementTopToBottomAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionDuration: const Duration(microseconds: 120),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> pushBottomToTop(
    Widget screen,
  ) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 120),
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> pushReplacementBottomToTop(
    Widget screen,
  ) {
    return Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 120),
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void pop() => Navigator.of(this).pop();
}
