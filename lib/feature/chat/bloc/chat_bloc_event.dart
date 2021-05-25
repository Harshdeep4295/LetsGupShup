abstract class ChatEvent {
  String peerId;
  ChatEvent(this.peerId);
}

class LoadChatEvent extends ChatEvent {
  LoadChatEvent(String peerId) : super(peerId);
}

class GetMessagesEvent extends ChatEvent {
  GetMessagesEvent(String peerId) : super(peerId);
}

class SendMessageEvenet extends ChatEvent {
  SendMessageEvenet(String peerId) : super(peerId);
}

class CreateDocumentChatEvent extends ChatEvent {
  String peerId;

  CreateDocumentChatEvent({required this.peerId}) : super(peerId);
}

class SendMessageChatEvent extends ChatEvent {
  String peerId;
  String content;
  String messageType;

  SendMessageChatEvent({
    required this.peerId,
    required this.content,
    required this.messageType,
  }) : super(peerId);
}
