class AnswerModel {
  String? answer;
  bool? corect;

  AnswerModel({this.answer, this.corect});

  factory AnswerModel.fromJson(Map<String?, dynamic> json) {
    return AnswerModel(
      answer: json['answer'] ?? '',
      corect: json['corect'] ?? false,
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      'answer': answer,
      'corect': corect,
    };
  }
}
