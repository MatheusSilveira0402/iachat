import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

Widget buildChatMessage(String message, bool isUserMessage) {
  return Align(
    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isUserMessage ? const Color(0xFF10A37F) : const Color(0xFF343541),
        borderRadius: BorderRadius.circular(12),
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      child: MarkdownBody(
        data: message,
        styleSheet: MarkdownStyleSheet(
          p: TextStyle(
            fontSize: 16,
            color: isUserMessage ? Colors.white : Colors.white70,
          ),
          strong: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          blockquoteDecoration: BoxDecoration(
            border: Border(left: BorderSide(color: Colors.greenAccent, width: 4)),
            color: Colors.white10,
          ),
          code: TextStyle(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
            fontFamily: 'monospace',
            color: Colors.greenAccent,
          ),
          listBullet: TextStyle(color: Colors.greenAccent),
        ),
      ),
    ),
  );
}
