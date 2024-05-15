import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? username;
  String? email;
  String? image;
  UserModel({
    this.id,
    this.email,
    this.username,
    this.image,
  });
  UserModel.fromJson(Map<String, dynamic>? json) {
    id = json?["id"];
    email = json?["email"];
    username = json?["username"];
    image = json?["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'username': username,
      'email': email,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
