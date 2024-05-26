import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase_constants/firebase_constants.dart';
import '../../../core/models/question_model.dart';

Future<List<QuestionModel?>> getQuestions(
  String? quizId,
  int? countRandomQuestions,
) async {
  List<QuestionModel?> questions = [];
  if (countRandomQuestions == null) {
    if (quizId != null) {
      questions = await _getQuestionsByCategoryId(quizId);
    } else {
      questions = await _getAllQuestionsFromAllCategories();
    }
  } else {
    questions = await _getRandomQuestions(countRandomQuestions);
  }

  return questions;
}

Future<List<QuestionModel?>> _getQuestionsByCategoryId(String quizId) async {
  List<QuestionModel?> questionModel = [];
  await quizzesFirestore
      .doc(quizId)
      .collection('questions')
      .get()
      .then((value) {
    for (var element in value.docs) {
      Map<String, dynamic> data = element.data();
      data.forEach((key, value) {
        if (value is Timestamp) {
          // Convert Timestamp to DateTime
          data[key] = value.toDate();
        }
      });
      questionModel.add(QuestionModel.fromJson(data));
    }
  });
  return questionModel;
}

Future<List<QuestionModel>> _getAllQuestionsFromAllCategories() async {
  List<QuestionModel> questions = [];
  // get questions from category id
  await quizzesFirestore.get().then((value) async {
    for (var element in value.docs) {
      await quizzesFirestore
          .doc(element.id)
          .collection('questions')
          .get()
          .then((value) {
        for (var element in value.docs) {
          questions.add(QuestionModel.fromJson(element.data()));
        }
      });
    }
  });
  return questions;
}

Future<List<QuestionModel?>> _getRandomQuestions(
  int countRandomQuestions,
) async {
  final random = Random();
  List<QuestionModel?> randomQuestions = [];
  Set<int> selectedIndexes = {};
  List<QuestionModel?> questions = await _getAllQuestionsFromAllCategories();
  while (selectedIndexes.length < countRandomQuestions &&
      selectedIndexes.length < questions.length) {
    int randomIndex = random.nextInt(questions.length);
    selectedIndexes.add(randomIndex);
  }

  for (int index in selectedIndexes) {
    randomQuestions.add(questions[index]);
  }

  return randomQuestions;
}
