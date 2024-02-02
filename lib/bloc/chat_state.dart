part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<ChatMessageModel> messages;
  ChatSuccessState({
    required this.messages,
  });
}
