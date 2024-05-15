import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> setImageToFireStrorgeAndGetPath(File image) async {
  Reference refStoreg = FirebaseStorage.instance.ref("images/$image");
  await refStoreg.putFile(image);
  return await refStoreg.getDownloadURL();
}
