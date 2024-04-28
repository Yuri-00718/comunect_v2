// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:comunect_v2/common/helpers/timestamp.dart';

class User extends Timestamp {
  String email;
  String profileUrl;
  String username; 

  User({
    super.id,
    required this.email,
    this.profileUrl='',
    required this.username,
  });

  Map<String, dynamic> toMap({bool isSavedInDatabase=false}) {
    if (isSavedInDatabase) {
      return <String, dynamic>{
        'email': email,
        'profileUrl': profileUrl,
        'username': username,
      };
    }
    
    return <String, dynamic>{
      'id': id,
      'email': email,
      'profileUrl': profileUrl,
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      profileUrl: map['profileUrl'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
