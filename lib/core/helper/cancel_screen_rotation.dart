import 'package:flutter/services.dart';

Future<void> cancelScreenRotation() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
