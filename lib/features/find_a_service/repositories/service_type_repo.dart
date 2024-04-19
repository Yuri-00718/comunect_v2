import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comunect_v2/features/find_a_service/models/service_type.dart';
import 'package:comunect_v2/features/find_a_service/utils/get_file_from_assests.dart';
import 'package:comunect_v2/features/find_a_service/utils/upload_file.dart';
import 'package:comunect_v2/utils/globals.dart';

class ServiceTypeRepository {
  static const String fieldName = 'name';
  static const String fieldImage = 'image';

  static final collection = db.collection(collectionName);

  static Future<void> addInitialData() async {
    final List<ServiceType> initialServiceType = [
      ServiceType(
        name: 'Fix', 
        image: await getImageFileFromAsset('assets/Home-list-image/serviceman_with_beard.png'),
      )
    ];

    for (int i = 0; i < initialServiceType.length; ++i) {
      ServiceType type = initialServiceType[i];
      type.imageUrl = await uploadFile(type.image as File);
      await collection.add(type.toMap(isSavedInDatabase: true));
    } 
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getList({
    required Map<String, dynamic> filters,
    int? limit
  }) async {
    var query = collection;
    
    filters.forEach((field, value) { 
      query.where(field, isEqualTo: value);
    });

    if (limit != null) {
      query.limit(limit);
    }

    QuerySnapshot snapshot = await query.get();
    return snapshot.docs;
  } 

  Future<List<ServiceType>> getObjectList({
    required Map<String, dynamic> filters,
    int? limit
  }) async {
    List<QueryDocumentSnapshot<Object?>> result = await getList(
      filters: filters,
      limit: limit
    );
    List<ServiceType> types = [];

    for (int i = 0; i < result.length; ++i) {
      Map<String, dynamic> map = result[i].data() as Map<String, dynamic>;
      types.add(ServiceType(
        id: result[i].id,
        name: map[fieldName], 
        imageUrl: map[fieldImage]
      ));
    }

    return types;
  }

  static String get collectionName => 'service_types';
}