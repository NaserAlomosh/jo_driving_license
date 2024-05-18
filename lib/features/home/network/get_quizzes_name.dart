import 'dart:convert';
import 'dart:developer';

import '../../../core/firebase_constants/firebase_constants.dart';
import '../../../core/models/quiz_model.dart';

Future<List<CategoryModel?>> getCategories() async {
  List<CategoryModel?> categories = [];
  await categoryFirestore.get().then((quiz) {
    for (var element in quiz.docs) {
      categories.add(CategoryModel.fromJson(element.data()));
    }
  });
  for (var element in categories) {
    log(jsonEncode(element?.toJson()));
  }
  return categories;
}
