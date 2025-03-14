import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ia_chat/provider/chat_provider.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('iaChat')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: provider.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: provider.messages.map((msg) {
                    return Align(
                      alignment: msg['role'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: msg['role'] == 'user' ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MarkdownBody(
                          data: msg['content']!,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          _buildTextInput(provider),
        ],
      ),
    );
  }

  Widget _buildTextInput(ChatProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provider.textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite sua mensagem...',
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: provider.sendMessage,
          ),
        ],
      ),
    );
  }
}