import 'package:flutter/material.dart';

bool checkDeviceIsTaplet(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  const double thresholdWidth = 600.0;
  bool isTablet = screenSize.width > thresholdWidth;
  return isTablet;
}
