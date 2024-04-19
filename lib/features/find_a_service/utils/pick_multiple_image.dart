import 'dart:io';

import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

Future<List<File>?> pickMultipleImages() async {
  List<XFile> pickedFiles = await picker.pickMultiImage();

  if (pickedFiles.isEmpty) { return null; }

  List<File> files = [];

  for (int i = 0; i < pickedFiles.length; ++i) {
    files.add(File(pickedFiles[i].path));
  }

  return files;
}