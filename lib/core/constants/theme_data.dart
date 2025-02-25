// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFF7F5F8),
    onSurface: Color(0xff6C5070),
    primary: Color(0xff6C5070),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xff6C5070),
    onSecondary: Color(0xff6C5070),
    surface: Color.fromARGB(255, 252, 247, 255),
    error: Color.fromARGB(255, 214, 130, 130),
    onError: Color.fromARGB(198, 111, 255, 157),

    // primaryContainer: Color(0xff01DC82),
    outline: Color.fromARGB(255, 194, 180, 196),
    //used in some conditions
    secondaryContainer: Color(0xff6C5070),
    tertiaryContainer: Color(0xFFDDDDDD),
    tertiary: Color(0xFFFFE15D),
    scrim: Color(0xff94B3FD),
  ),
);
//
// theme dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 75, 53, 79),
    onBackground: Color(0xFFFFFFFF),
    primary: Color(0xff6C5070),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color.fromARGB(255, 254, 245, 255),
    onSecondary: Color.fromARGB(255, 121, 67, 128),
    surface: Color.fromARGB(131, 108, 80, 112),
    error: Color(0xffEA728C),
    onError: Color.fromARGB(198, 111, 255, 157),

    // primaryContainer: Color(0xff01DC82),
    outline: Color.fromARGB(255, 194, 180, 196),
    secondaryContainer: Color(0xFFFFE15D),
    tertiaryContainer: Color(0xff6C5070),
    tertiary: Color(0xFFFFE15D),
    scrim: Color(0xff94B3FD),
  ),
);
