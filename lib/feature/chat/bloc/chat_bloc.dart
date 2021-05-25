import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsgupshup/feature/chat/bloc/chat_bloc_event.dart';
import 'package:letsgupshup/feature/chat/bloc/chat_bloc_state.dart';
import 'package:letsgupshup/feature/chat/domain/repository/chat_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  ChatBloc({
    required this.repository,
  }) : super(LoadingChat());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is CreateDocumentChatEvent) {
      var response = await repository.createDocFireStore(event.peerId);

      yield response.fold(
        (value) => LoadingChat(),
        (fail) => ErrorChatState(errorMessage: fail.message),
      );
      add(GetMessagesEvent(event.peerId));
    } else if (event is SendMessageChatEvent) {
      var response = await repository.sendMessage(
          event.messageType, event.content, event.peerId);

      yield response.fold(
        (messageSent) => ChatLoaded(message: this.state.messages),
        (fail) => ErrorChatState(errorMessage: fail.message),
      );
    } else if (event is GetMessagesEvent) {
      var response = await repository.getMessages(event.peerId);

      yield response.fold(
        (steamMessage) => ChatLoaded(message: steamMessage),
        (fail) => ErrorChatState(errorMessage: fail.message),
      );
    }
  }
}
