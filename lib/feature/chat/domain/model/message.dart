import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Message extends Equatable {
  final String id;
  final String message;
  final String sender;
  final String? messageType;
  final String recipient;
  final int createdTimestamp;
  late int? updatedTimestamp;
  final bool isDeleted;

  Message({
    required this.id,
    required this.message,
    required this.sender,
    required this.recipient,
    required this.createdTimestamp,
    this.messageType,
    this.updatedTimestamp,
    this.isDeleted = false,
  });
  @override
  List<Object?> get props => [id, message, sender, recipient, createdTimestamp];

  static Message fromJson(Map<String, dynamic> data, int id) {
    return Message(
      id: id.toString(),
      message: data["content"],
      sender: data["idFrom"],
      recipient: data["idTo"],
      messageType: data["type"].toString(),
      createdTimestamp: int.parse(data["timestamp"].toString()),
    );
  }
}
