import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/chat/data/datasource/use_case_impl.dart';
import 'package:letsgupshup/feature/chat/domain/model/message.dart';
import 'package:letsgupshup/feature/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImp extends ChatRepository {
  final ChatDataSourceImp source;
  ChatRepositoryImp({required this.source});
  late StreamController<List<Message>> _messages;
  @override
  Future<Either<Stream<List<Message>>, Failure>> getMessages(
      String peerId) async {
    _messages = StreamController();
    Stream<QuerySnapshot<Map<String, dynamic>>> messages =
        await source.getFirebaseMessages(peerId);

    //  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    messages.listen((event) {
      print(peerId);
      List<Message> messageList = [];
      event.docs.length;

      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> query =
          event.docs.iterator;

      while (query.moveNext()) {
        messageList.add(
          Message.fromJson(
            query.current.data(),
            query.current.data().hashCode,
          ),
        );
      }
      _messages.add(messageList);
      // _messages.add(Message());
    });

    return Left(_messages.stream);
  }

  @override
  Future<Either<bool, Failure>> createDocFireStore(String peerId) async {
    try {
      await source.createChatDocument(peerId);
      return Future.value(Left(true));
    } on Exception catch (ex) {
      return Future.value(Right(Errors(ex.toString())));
    } on Error catch (error) {
      return Future.value(Right(Errors(error.stackTrace.toString())));
    }
  }

  @override
  Future<Either<bool, Failure>> sendMessage(
      String type, String content, String groupChatId) async {
    try {
      await source.sendMessage(type, content, groupChatId);
      return Future.value(
        Left(true),
      );
    } on Exception catch (ex) {
      return Future.value(
        Right(
          Errors(
            ex.toString(),
          ),
        ),
      );
    } on Error catch (error) {
      return Future.value(
        Right(
          Errors(
            error.stackTrace.toString(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _messages.close();
  }
}
