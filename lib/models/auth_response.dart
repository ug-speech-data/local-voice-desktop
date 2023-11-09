// To parse this JSON data, do
//
//  final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:local_voice_desktop/models/user.dart';

AuthResponse authResponseFromJson(String str) {
  return AuthResponse.fromJson(json.decode(str));
}

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    this.errorMessage,
    this.user,
    this.token,
  });

  String? errorMessage;
  User? user;
  String? token;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    User? user;
    if (json["user"] != null) {
      user = User.fromJson(json["user"]);
    }
    return AuthResponse(
      errorMessage: json["error_message"],
      user: user,
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "error_message": errorMessage,
        "user": user?.toJson(),
        "token": token,
      };
}
