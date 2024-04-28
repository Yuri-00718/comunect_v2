part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<Message> messages;

  ChatLoaded({
    required this.messages,
  });
}