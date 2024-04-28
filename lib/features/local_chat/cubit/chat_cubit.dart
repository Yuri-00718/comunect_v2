import 'package:comunect_v2/features/authentication/models/user.dart';
import 'package:comunect_v2/features/authentication/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comunect_v2/features/local_chat/models/message.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatLoading());

  Future<void> loadChat(Map<Object?, Object?> data) async {
    List<Map<String, dynamic>> dataInList = _convertToList(data);
    List<Message> messages = [];

    for (int index = 0; index < dataInList.length; ++index) {
      var map = dataInList[index];
      var message = Message(
        text: map['message'],
        sender: await _getUser(map['email']),
      );
      messages.add(message);
    }

    emit(ChatLoaded(messages: messages));
  }

  List<Map<String, dynamic>> _convertToList(data) {
    var dataInList = data.entries.toList();
    final List<Map<String, dynamic>> messages = [];

    dataInList.forEach((entry) {
      messages.add({
        'email': entry.value['sender'],
        'message': entry.value['message'],
        'timestamp': entry.value['timestamp'],
      });
    });

    messages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

    return messages;
  }

  static final userRepo = UserRepository();

  Future<User> _getUser(String email) async {
    List<User> result = await userRepo.getObjectList({
      'email': email
    });

    if (result.isEmpty) {
      throw 'User not found';
    }

    return result[0];
  } 
}
