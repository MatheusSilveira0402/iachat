import 'package:flutter/material.dart';
import 'package:ia_chat/sevice/chat_service.dart';

class ChatProvider with ChangeNotifier {
  final ChatService _chatService;
  ChatProvider(this._chatService);

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<Map<String, String>> messages = [];

  Future<void> sendMessage() async {
    if (textController.text.trim().isEmpty) return;

    String text = textController.text.trim();
    textController.clear();
    messages.add({"role": "user", "content": text});
    notifyListeners();
    _scrollToBottom();

    final response = await _chatService.getChatResponse(messages);
    messages.add({"role": "assistant", "content": response});
    notifyListeners();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void clearChat() {
    messages.clear();
    notifyListeners();
  }
}
