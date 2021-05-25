import 'package:letsgupshup/core/utils/firebase_configure.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/feature/chat/domain/usecase/chat_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDataSourceImp extends ChatDataSource {
  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getFirebaseMessages(
      String peerId) async {
    String id = await getSharedPrefernce().id as String;
    String? groupChatId;
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    return FireBaseConfig().getMessages(groupChatId);
  }

  @override
  Future<void> createChatDocument(String peerId) async {
    String id = await getSharedPrefernce().id as String;
    String? groupChatId;
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }
    await FireBaseConfig().update(
      'chats',
      groupChatId,
      {'chattingWith': peerId},
    );
  }

  @override
  Future<void> sendMessage(String type, String content, String peerId) async {
    String id = await getSharedPrefernce().id as String;
    String? groupChatId;
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    FireBaseConfig().sendMessage(
      type,
      content,
      peerId,
      id,
      groupChatId,
    );
  }
}
