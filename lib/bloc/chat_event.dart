part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatGenerateNewMessageEvent extends ChatEvent {
  final String inputMessage;
  ChatGenerateNewMessageEvent({
    required this.inputMessage,
  });
}
