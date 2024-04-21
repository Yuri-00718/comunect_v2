// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:comunect_v2/common/helpers/timestamp.dart';

class Job extends Timestamp {
  String description;
  List<File> photos;
  String location;
  List<String> photosUrl;
  String postedBy;
  String serviceType;

  Job({
    super.id,
    required this.description,
    this.photos=const [],
    required this.location,
    required this.postedBy,
    required this.serviceType,
    this.photosUrl=const [],
  });

  Map<String, dynamic> toMap({bool isSavedInDatabase=false}) {
    if (isSavedInDatabase) {
      return <String, dynamic>{
        'description': description,
        'location': location,
        'photosUrl': jsonEncode(photosUrl),
        'postedBy': postedBy,
        'serviceType': serviceType
      };
    }
    
    return <String, dynamic>{
      'id': id,
      'description': description,
      'photos': photos.map((e) => e.path),
      'location': location,
      'photosUrl': jsonEncode(photosUrl),
      'postedBy': postedBy,
      'serviceType': serviceType
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    List<dynamic> list = jsonDecode(map['photosUrl'] ?? '[]');
    List<String> conList  = list.map((e) => e.toString(),).toList();
    return Job(
      id: map['id'],
      serviceType: map['serviceType'] as String,
      description: map['description'] as String,
      photos: map['photos'] ?? [],
      location: map['location'] as String,
      photosUrl: conList,
      postedBy: map['postedBy']
    );
  }

  factory Job.fromJson(String source) => Job.fromMap(json.decode(source) as Map<String, dynamic>);
}
