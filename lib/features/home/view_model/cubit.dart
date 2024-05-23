import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jo_driving_license/core/firebase/auth_error_handler.dart';
import 'package:jo_driving_license/features/home/network/get_quizzes_name.dart';

import '../../../core/models/quiz_model.dart';

part 'states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<QuizModel?> quizzes = [];
  Future<void> getQuizzezNameCubit() async {
    try {
      emit(HomeLoading());
      quizzes = await getQuizzezName();

      quizzes.add(QuizModel(
        name: tr('finalExam'),
      ));
      emit(HomeSuccess());
    } on FirebaseException catch (e) {
      emit(HomeError(error: firebaseErrorHandler(e.code)));
    }
  }
}
