import 'dart:io';

import 'package:comunect_v2/features/find_a_service/models/job.dart';
import 'package:comunect_v2/features/find_a_service/utils/upload_file.dart';
import 'package:comunect_v2/utils/globals.dart';

class JobRepository {
  static const fieldDescription = 'description';
  static const fieldLocation = 'location';
  static const fieldUrl = 'photosUrl';
  static const fieldPostedBy = 'postedBy';
  static const fieldPhotos = 'photos';
  static const fieldServiceType = 'serviceType';

  static final collection = db.collection(collectionName);

  Future<void> addNewJob(Map<String, dynamic> values) async {
    Job newJob = Job.fromMap(values);
    newJob.photosUrl = await _savePhotos(newJob.photos);
    await collection.add(newJob.toMap(isSavedInDatabase: true));
  }

  Future<List<String>> _savePhotos(List<File> photos) async {
    List<Future<String>> uploadFutures = photos.map((photo) => uploadFile(photo)).toList();
    return await Future.wait(uploadFutures);
  }

  static String get collectionName => 'jobs';
}