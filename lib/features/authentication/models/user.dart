// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:comunect_v2/common/helpers/timestamp.dart';


class User extends Timestamp {
  String username;
  String password;
  String email;

  User({
    super.id,
    required this.username,
    required this.email,
    required this.password,
    super.createdAt,
    super.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt']
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => 
    User.fromMap(json.decode(source) as Map<String, dynamic>);
}
