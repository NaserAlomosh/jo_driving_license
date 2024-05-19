import 'package:flutter/material.dart';

//!  background   =    background
//!  font familiar with bg   =    onBackground
//!  containers familiar with background   =    surface
//!  color of buttons  =   primary
//!  color of font buttons  =   onPrimary
//!  color of buttons  =   primary
//!  stars & more   =   tertiary
//!  unchoosen answers & more   =   tertiaryContainer
//!  error   =   wrong answers
//!  onError   =   correct answers

// theme light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 255, 255, 255),
      onBackground: Color.fromARGB(255, 98, 94, 102),
      primary: Color(0xff7469B6),
      onPrimary: Color(0xFFFFFFFF),
      // secondary: Color.fromARGB(255, 211, 203, 212),
      // onSecondary: Color.fromARGB(255, 104, 101, 101),
      surface: Color.fromARGB(255, 238, 229, 245),
<<<<<<< HEAD
      primaryContainer: Color(0xff01DC82),
      outline: Color(0xffEBECF1),
      secondaryContainer: Color(0xfff43f5e),
      tertiaryContainer: Color(0xFFDDDDDD),
=======
      error: Color.fromARGB(255, 214, 130, 130),
      onError: Color.fromARGB(255, 122, 176, 134),
      // primaryContainer: Color(0xff01DC82),
      // outline: Color(0xffEBECF1),
      // secondaryContainer: Color(0xfff43f5e),
      // tertiaryContainer: Color(0xFFDDDDDD),
      tertiary: Color(0xFFFFE15D)),
);

// theme dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    // colorPrimary
    primary: Color.fromARGB(255, 43, 50, 117),
    // colorOnPrimary
    onPrimary: Color(0xFFFFFFFF),
    // colorButtons and Icons
    secondary: Color(0xffF58025),
    // color Font
    onSecondary: Color.fromARGB(91, 255, 255, 255),
    // background
    background: Color.fromARGB(255, 255, 255, 255),
    // background: Color.fromARGB(171, 3, 0, 54),
    // colorGreen
    primaryContainer: Color(0xff01DC82),
    // colorBorder
    outline: Color(0xffEBECF1),
    // colorRed
    secondaryContainer: Color(0xfff43f5e),
    // colorGrey
    // tertiaryContainer:const Color(0xffEBECF1),
    tertiaryContainer: Color(0xFFDDDDDD),
    // black color
    tertiary: Colors.black,
  ),
);
