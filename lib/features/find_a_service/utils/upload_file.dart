import 'dart:io';

import 'package:comunect_v2/utils/globals.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

Future<String> uploadFile(File file) async {
  String name = DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name
  String fileType = extension(file.path);
  String filename = '$name$fileType';
  Reference ref = storage.ref().child('uploads/$filename');
  File localFile = file.absolute;
  await ref.putFile(localFile);
  String downloadURL = await ref.getDownloadURL();
  return downloadURL;
}