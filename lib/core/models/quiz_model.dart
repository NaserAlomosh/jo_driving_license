class CategoryModel {
  String? name;
  String? id;

  CategoryModel({this.name, this.id});

  factory CategoryModel.fromJson(Map<String?, dynamic>? json) {
    return CategoryModel(
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
