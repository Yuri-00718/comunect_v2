// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:comunect_v2/common/helpers/timestamp.dart';
import 'package:flutter/material.dart';

class ServiceType extends Timestamp {
  String name;
  File? image;
  String? imageUrl;

  ServiceType({
    super.id,
    required this.name,
    this.image,
    this.imageUrl,
  });

  Map<String, dynamic> toMap({bool isSavedInDatabase=false}) {
    if (isSavedInDatabase) {
      return {
        'name': name,
        'image': imageUrl,
      };
    }
    return {
      'id': id,
      'name': name,
      'image': image,
      'imageUrl': imageUrl,
    };
  }

  factory ServiceType.fromMap(Map<String, dynamic> map) {
    return ServiceType(
      name: map['name'] as String,
      image: map['image'] as File,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceType.fromJson(String source) => 
    ServiceType.fromMap(json.decode(source) as Map<String, dynamic>);
}
