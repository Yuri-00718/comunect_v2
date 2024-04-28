import 'dart:async';

import 'package:comunect_v2/features/authentication/repositories/user_repo.dart';
import 'package:comunect_v2/utils/globals.dart';
const String tempLocation = 'naga';

class ChatRepository {
  final chatRoomRef = realtimeDb.ref().child('chat_rooms');
  static String colTimestamp = 'timestamp';
  static String colMessage = 'message';

  Future<void> sendChat({
    required String message,
    required String sender,
    String location=tempLocation
  })  async {
    await chatRoomRef
      .child(location)
      .push()
      .set({
        'message': message,
        'sender': sender,
        'timestamp': DateTime.now().millisecondsSinceEpoch
      })
      .then((value) {
        print('message sent');
      })
      .catchError((error) {
        print(error.toString());
      });
  }
}