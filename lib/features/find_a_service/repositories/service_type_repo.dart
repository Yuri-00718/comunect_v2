import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comunect_v2/common/helpers/repository.dart';
import 'package:comunect_v2/features/find_a_service/models/service_type.dart';
import 'package:comunect_v2/features/find_a_service/utils/get_file_from_assests.dart';
import 'package:comunect_v2/features/find_a_service/utils/upload_file.dart';
import 'package:comunect_v2/utils/globals.dart';

class ServiceTypeRepository extends Repository{
  static const String fieldName = 'name';
  static const String fieldImage = 'imageUrl';

  @override
  CollectionReference get collection => db.collection(collectionName);
  static String get collectionName => 'service_types';

  Future<void> addInitialData() async {
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
      map['id'] = result[i].id;
      types.add(ServiceType.fromMap(map));
    }

    return types;
  }
}