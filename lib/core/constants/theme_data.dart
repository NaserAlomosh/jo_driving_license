import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      background: Color(0xFFF7F5F8),
      onBackground: Color(0xff6C5070),
      primary: Color(0xff6C5070),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xff6C5070),
      onSecondary: Color(0xff6C5070),
      surface: Color.fromARGB(255, 238, 229, 245),
      error: Color.fromARGB(255, 221, 143, 143),
      onError: Color(0xff96E9C6),
      // primaryContainer: Color(0xff01DC82),
      outline: Color.fromARGB(255, 194, 180, 196),
      //used in some conditions
      secondaryContainer: Color(0xff6C5070),
      tertiaryContainer: Color(0xFFDDDDDD),
      tertiary: Color(0xFFFFE15D)),
);

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
      surface: Color.fromARGB(255, 164, 146, 167),
      error: Color(0xffEA728C),
      onError: Color(0xff94B3FD),
      // primaryContainer: Color(0xff01DC82),
      outline: Color.fromARGB(255, 194, 180, 196),
      secondaryContainer: Color(0xFFFFE15D),
      tertiaryContainer: Color(0xff6C5070),
      tertiary: Color(0xFFFFE15D)),
);
