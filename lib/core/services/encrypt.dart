import 'package:encrypt/encrypt.dart';

class EncryptData {
  final String _keyString = 'NaserAlomosh33**';

  String decrypt(String text) {
    final key = Key.fromUtf8(_keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(_keyString.substring(0, 16));
    return encrypter.decrypt16(text, iv: initVector);
  }

  String encrypt(String plainText) {
    final key = Key.fromUtf8(_keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(_keyString.substring(0, 16));
    Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
    return encryptedData.base16;
  }
}
