import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase_constants/firebase_constants.dart';
import '../../../core/models/question_model.dart';

Future<List<QuestionModel?>> getQuestions(String quizId) async {
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
