import 'package:letsgupshup/feature/chat/domain/model/message.dart';

abstract class ChatState {
  Stream<List<Message>>? messages;
  ChatState({this.messages});
}

class LoadingChat extends ChatState {}

class ChatLoaded extends ChatState {
  ChatLoaded({required Stream<List<Message>>? message})
      : super(messages: message);
}

class ErrorChatState extends ChatState {
  String? errorMessage;
  ErrorChatState({required this.errorMessage});
}
