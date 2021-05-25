abstract class ChatDataSource {
  getFirebaseMessages(String peerId);

  void createChatDocument(String peerId);

  void sendMessage(String type, String content, String groupChatId);
}
