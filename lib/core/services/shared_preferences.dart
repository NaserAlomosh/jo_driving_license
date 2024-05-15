import 'dart:developer';

import '../../main.dart';
import 'encrypt.dart';

setSharedPreferences(String key, String? value) async {
  if (value != '') {
    String text = EncryptData().encrypt(value!);
    bool? saveData = await prefs.setString(key, text);
    log('Set Data In SharedPreferences $key : $saveData');
  } else {
    bool? saveData = await prefs.setString(key, '');
    log('Set Data In SharedPreferences $key : $saveData');
  }
}

String getSharedPreferences(String key) {
  String? data = prefs.getString(key);
  if (data != '') {
    String text = EncryptData().decrypt(data!);
    log('Get Data From SharedPreferences $key = $text');
    return text;
  } else {
    log('Get Data From SharedPreferences $key = $data');
    return data!;
  }
}

Future<bool> clearSharedPreferences() async {
  bool clean = await prefs.clear();
  log('Clear Shared Preferences : $clean');
  return clean;
}
