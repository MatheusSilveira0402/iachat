

import 'package:ia_chat/repository/chat_repository.dart';

class ChatService {
  final ChatRepository _chatRepository;

  ChatService(this._chatRepository);

  Future<String> getChatResponse(List<Map<String, String>> messages) {
    return _chatRepository.fetchChatResponse(messages);
  }
}
