import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comunect_v2/common/helpers/repository.dart';
import 'package:comunect_v2/features/authentication/models/user.dart';
import 'package:comunect_v2/utils/globals.dart';

class UserRepository extends Repository {
  @override
  CollectionReference get collection => firestoreDb.collection(collectionName);
  static String get collectionName => 'users';
  static final userRepo = UserRepository();

  Future<List<User>> getObjectList(Map<String, dynamic> filters) async {
    var result = await getList(filters: filters);
    List<User> users = [];

    for (int i = 0; i < result.length; ++i) {
      Map<String, dynamic> map = result[i].data() as Map<String, dynamic>;
      map['id'] = result[i].id;
      users.add(User.fromMap(map));
    }

    return users;
  }
}