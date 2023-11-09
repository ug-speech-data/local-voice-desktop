// To parse this JSON data, do
//
// final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str)["user"]);

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    this.photo,
    this.createdAt,
    this.phone,
    this.emailAddress,
  });

  int id;
  String? photo;
  DateTime? createdAt;
  String? phone;
  String? emailAddress;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        phone: json["phone"],
        emailAddress: json["email_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "created_at": createdAt?.toIso8601String(),
        "phone": phone,
        "email_address": emailAddress,
      };
}
