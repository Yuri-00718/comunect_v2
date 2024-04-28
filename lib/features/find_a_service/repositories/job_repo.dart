import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comunect_v2/common/helpers/repository.dart';
import 'package:comunect_v2/features/find_a_service/models/job.dart';
import 'package:comunect_v2/features/find_a_service/utils/upload_file.dart';
import 'package:comunect_v2/utils/globals.dart';

class JobRepository extends Repository {
  static const fieldDescription = 'description';
  static const fieldLocation = 'location';
  static const fieldPhotosUrl = 'photosUrl';
  static const fieldPostedBy = 'postedBy';
  static const fieldPhotos = 'photos';
  static const fieldServiceType = 'serviceType';

  @override
  CollectionReference get collection => firestoreDb.collection(collectionName);

  Future<void> addNewJob(Map<String, dynamic> values) async {
    Job newJob = Job.fromMap(values);
    newJob.photosUrl = await _savePhotos(newJob.photos);
    await collection.add(newJob.toMap(isSavedInDatabase: true));
  }

  Future<List<Job>> getObjectList({
    required Map<String, dynamic> filters,
    int? limit
  }) async {
    List<QueryDocumentSnapshot<Object?>> result = await getList(
      filters: filters,
      limit: limit
    );
    List<Job> jobs = [];
    
    for (int i = 0; i < result.length; ++i) {
      Map<String, dynamic> map = result[i].data() as Map<String, dynamic>;
      map['id'] = result[i].id;
      jobs.add(Job.fromMap(map));
    }

    return jobs;
  }

  Future<List<String>> _savePhotos(List<File> photos) async {
    List<Future<String>> uploadFutures = photos.map((photo) => uploadFile(photo)).toList();
    return await Future.wait(uploadFutures);
  }

  static String get collectionName => 'jobs';
}