import 'dart:developer';
import 'dart:io';

import '../../../../core/firebase/set_image_firestorege.dart';
import '../../../core/firebase_constants/firebase_constants.dart';
import '../../../core/models/user_model.dart';

Future<void> addUserDataToFirestore({
  required String email,
  required String id,
  required String username,
  required File? image,
}) async {
  String? imagePath;
  if (image != null) {
    imagePath = await setImageToFireStrorgeAndGetPath(image);
  }
  UserModel user = UserModel(
    id: id,
    username: username,
    email: email,
    image: imagePath,
  );
  await usersFirestore.doc(user.id).set(user.toMap());
  log('User added to Firestore successfully!');
  log('data saved to firestore : ${user.toMap()}');
}
