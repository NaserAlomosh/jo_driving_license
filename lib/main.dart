import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jo_driving_license/core/models/answer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/firebase_constants/firebase_constants.dart';
import 'driving_license.dart';
import 'firebase_options.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await addQuestion("mfL8FkT1SSwvHm8dR0qj");
  prefs = await SharedPreferences.getInstance();
  runApp(const DrivingLicenseApp());
}

addQuestion(String catigoryId) async {
  String questionId;
  List<Map> quizzes = [
    AnswerModel(
      answer: "ممنوع الانعطاف إلى اليمين",
      correct: true,
    ).toJson(),
    AnswerModel(
      answer: "ممنوع الانعطاف إلى اليسار.",
      correct: false,
    ).toJson(),
    AnswerModel(
      answer: "مسموح الانعطاف الى اليمين.",
      correct: false,
    ).toJson(),
  ];
  // get the id
  await quizzesFirestore
      .doc(catigoryId)
      .collection('questions')
      .add({}).then((DocumentReference doc) async {
    questionId = doc.id;
    // add the question
    await quizzesFirestore
        .doc(catigoryId)
        .collection('questions')
        .doc(questionId)
        .set({
      "id": questionId,
      "question": 'هذه الشاخصة تعني',
      "image":
          "https://trainingdriving.com/wp-content/uploads/2023/07/%D8%A7%D9%8A%D8%A7%D8%AF-%D8%A7%D9%84%D9%84%D8%AD%D8%A7%D9%85-1.jpg",
      "answers": quizzes
    });
  });
}
