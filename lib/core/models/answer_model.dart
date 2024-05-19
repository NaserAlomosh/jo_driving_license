class AnswerModel {
  String? answer;
  bool? correct;

  AnswerModel({this.answer, this.correct});

  factory AnswerModel.fromJson(Map<String?, dynamic> json) {
    return AnswerModel(
      answer: json['answer'],
      correct: json['correct'],
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      'answer': answer,
      'correct': correct,
    };
  }
}
