import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jo_driving_license/features/questions/network/get_quistions.dart';

import '../../../core/firebase/auth_error_handler.dart';
import '../../../core/models/question_model.dart';

part 'state.dart';

class QuistionsCubit extends Cubit<QuistionsState> {
  QuistionsCubit() : super(QuistionsInitial());
  List<QuestionModel?> questions = [];
  getQuistionsCubit(
    String? quizId,
    int? countRandomQuestions,
  ) async {
    try {
      emit(QuistionsLoading());
      questions = await getQuestions(quizId, countRandomQuestions);
      emit(QuistionsSuccess());
    } on FirebaseException catch (e) {
      emit(QuistionsError(error: firebaseErrorHandler(e.code)));
    }
  }
}
