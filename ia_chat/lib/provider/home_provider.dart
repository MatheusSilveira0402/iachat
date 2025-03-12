import 'package:flutter/material.dart';
import 'package:ia_chat/sevice/chat_service.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final ChatService _chatService = ChatService();
  String responseMessage = "";
  Future<void> sendMessage() async {
    if (textController.text.isEmpty) return;

    final userMessage = textController.text;
    textController.clear();
    notifyListeners();

    responseMessage = await _chatService.sendMessage(userMessage);
    notifyListeners();
  }
}
