import 'package:flutter/material.dart';

//!  colorBorder   =   outLine
//!  colorPrimary   =   primary
//!  colorOnPrimary   =   oPrimary
//!  colorFont   =    secondery
//!  colorFont2   =   onSecondery
//!  colorGreen   =   primaryContainer
//!  colorRed   =     secondaryContainer
//!  colorGrey   =    tertiaryContainer
//
// theme light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    // colorPrimary
    // primary: Color.fromARGB(255, 22, 67, 82),
    primary: Color.fromARGB(255, 149, 121, 167),
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
