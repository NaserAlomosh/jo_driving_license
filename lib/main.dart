import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'driving_license.dart';
import 'firebase_options.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  prefs = await SharedPreferences.getInstance();

  runApp(
    EasyLocalization(
      path: 'assets/languages',
      supportedLocales: const [
        Locale('ar'),
      ],
      fallbackLocale: const Locale('ar'),
      child: const DrivingLicenseApp(),
    ),
  );
}
