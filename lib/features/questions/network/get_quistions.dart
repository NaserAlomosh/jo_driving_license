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
    int questionsPerCategory) async {
  final random = Random();
  List<QuestionModel?> randomQuestions = [];
  List<QuestionModel?> questions = await _getAllQuestionsFromAllCategories();

  // Group questions by category
  Map<String, List<QuestionModel?>> categorizedQuestions = {};
  for (var question in questions) {
    if (question != null) {
      if (!categorizedQuestions.containsKey(question.categoryId ?? '')) {
        categorizedQuestions[question.categoryId ?? ''] = [];
      }
      categorizedQuestions[question.categoryId ?? '']!.add(question);
    }
  }

  // Select 6 random questions from each category
  categorizedQuestions.forEach((category, questionsInCategory) {
    if (questionsInCategory.length <= questionsPerCategory) {
      randomQuestions.addAll(questionsInCategory);
    } else {
      Set<int> selectedIndexes = {};
      while (selectedIndexes.length < questionsPerCategory) {
        selectedIndexes.add(random.nextInt(questionsInCategory.length));
      }
      selectedIndexes.forEach((index) {
        randomQuestions.add(questionsInCategory[index]);
      });
    }
  });

  return randomQuestions;
}
