import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> signUpFirebase({
  required String email,
  required String password,
}) async {
  UserCredential user =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.trim().toLowerCase(),
    password: password.trim(),
  );
  return user;
}
