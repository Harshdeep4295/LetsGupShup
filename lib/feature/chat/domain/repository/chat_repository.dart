import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/chat/domain/model/message.dart';

abstract class ChatRepository {
  Future<Either<Stream<List<Message>>, Failure>> getMessages(String peerId);
  Future<Either<bool, Failure>> sendMessage(
    String type,
    String content,
    String peerId,
  );
  Future<Either<bool, Failure>> createDocFireStore(String peerId);

  void dispose();
}
