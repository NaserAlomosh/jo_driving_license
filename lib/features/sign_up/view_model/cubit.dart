import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/firebase/auth_error_handler.dart';
import '../../../core/firebase/get_user_data.dart';
import '../../../core/functions/get_image_picker.dart';
import '../firebase/save_user_data_to_firestore.dart';
import '../firebase/sign_up.dart';
import 'states.dart';

class SignUpCubit extends Cubit<SignUpState> {
  bool confirmPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  File? image;
  final formKey = GlobalKey<FormState>();

  SignUpCubit() : super(SignUpInitial());
  void signUpCubit() async {
    if (formKey.currentState!.validate()) {
      emit(SignUpLoadingState());
      try {
        UserCredential data = await signUpFirebase(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        await addUserDataToFirestore(
          email: data.user!.email!,
          id: data.user!.uid,
          username: _capitalizeFirstLetter(),
          image: image,
        );
        await getUserData(
          id: data.user!.uid,
          password: passwordController.text.trim(),
        );
      } on FirebaseException catch (e) {
        emit(SignUpErrorState(firebaseErrorHandler(e.code)));
      }
    }
  }

  String _capitalizeFirstLetter() {
    return usernameController.text[0].toUpperCase() +
        usernameController.text.substring(
          1,
          usernameController.text.length,
        );
  }

  Future<void> selectImage() async {
    image = await getImagePicker();
    emit(SignUpSelectImageState());
  }
}
