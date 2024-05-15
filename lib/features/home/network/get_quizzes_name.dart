import 'dart:convert';
import 'dart:developer';

import '../../../core/firebase_constants/firebase_constants.dart';
import '../../../core/models/quiz_model.dart';

Future<List<QuizModel?>> getQuizzezName() async {
  List<QuizModel?> quizzes = [];
  await quizzesFirestore.get().then((quiz) {
    for (var element in quiz.docs) {
      quizzes.add(QuizModel.fromJson(element.data()));
    }
  });
  for (var element in quizzes) {
    log(jsonEncode(element?.toJson()));
  }
  return quizzes;
}
