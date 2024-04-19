import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<File> getImageFileFromAsset(String imagePath) async {
  String type = extension(imagePath);
  ByteData byteData = await rootBundle.load(imagePath);
  final Uint8List imageData = byteData.buffer.asUint8List();
  final String tempDir = (await getTemporaryDirectory()).path;
  final String tempFilePath = '$tempDir/${DateTime.now().millisecondsSinceEpoch}$type';
  final File tempFile = File(tempFilePath);
  await tempFile.writeAsBytes(imageData);
  return tempFile;
}