import 'answer_model.dart';

class QuestionModel {
  String? id;
  String? name;
  String? image;
  String? question;
  List<AnswerModel> answers = [];
  QuestionModel({
    this.id,
    this.name,
    this.image,
    this.question,
    this.answers = const [],
  });

  factory QuestionModel.fromJson(Map<String?, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      question: json['question'],
      answers: json['answers'] != null
          ? List<AnswerModel>.from(
              json['answers'].map((x) => AnswerModel.fromJson(x)))
          : [],
    );
  }
  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['question'] = question;
    data['answers'] = answers.map((v) => v.toJson()).toList();
    return data;
  }
}
