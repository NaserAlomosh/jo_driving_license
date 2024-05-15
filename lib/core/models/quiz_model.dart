class QuizModel {
  String? name;
  String? id;

  QuizModel({this.name, this.id});

  factory QuizModel.fromJson(Map<String?, dynamic>? json) {
    return QuizModel(
      name: json?['name'] ?? '',
      id: json?['id'] ?? '',
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
