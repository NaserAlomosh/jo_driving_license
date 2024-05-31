import 'package:flutter/services.dart';

Future<void> displayScreenRotation() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
