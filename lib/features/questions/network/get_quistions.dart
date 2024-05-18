import 'dart:convert';
import 'dart:developer';

import 'package:jo_driving_license/core/firebase_constants/firebase_constants.dart';
import 'package:jo_driving_license/core/models/question_model.dart';

Future<List<QuestionModel?>> getQuistions(String quizId) async {
  List<QuestionModel?> questionModel = [];
  await categoryFirestore
      .doc(quizId)
      .collection('questions')
      .get()
      .then((value) {
    for (var element in value.docs) {
      log(jsonEncode(element.data()));
      questionModel.add(QuestionModel.fromJson(element.data()));
    }
  });

  return questionModel;
}
