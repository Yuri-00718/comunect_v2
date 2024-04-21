import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Repository {
  CollectionReference get collection => throw UnimplementedError();
  static String get collectionName => throw UnimplementedError();

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
}