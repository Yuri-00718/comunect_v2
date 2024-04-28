import 'package:comunect_v2/common/helpers/timestamp.dart';
import 'package:comunect_v2/features/authentication/models/user.dart';

class Message extends Timestamp {
  String text;
  User sender;

  Message({
    super.id,
    required this.text,
    required this.sender,
    super.createdAt,
    super.updatedAt
  });
}