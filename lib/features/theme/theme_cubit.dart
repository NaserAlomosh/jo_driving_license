import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOptions { light, dark }

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await prefs.setString('theme', currentTheme.toString());
    emit(currentTheme);
  }

  Future<void> initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');
    if (savedTheme != null) {
      emit(convertToThemeMode(savedTheme));
    }
  }

  ThemeMode convertToThemeMode(String savedTheme) {
    switch (savedTheme) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light; // Default to light theme if invalid value
    }
  }
}
