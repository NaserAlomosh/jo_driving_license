import 'package:cloud_firestore/cloud_firestore.dart';

final usersFirestore = FirebaseFirestore.instance.collection('users');
final quizzesFirestore = FirebaseFirestore.instance.collection('quizzes');
const quizzesCollection = 'quizzes';
const favoriteCollection = 'favorite';
const historySearchCollection = 'history_search';
const widgetTybesCollection = 'widget_types';
