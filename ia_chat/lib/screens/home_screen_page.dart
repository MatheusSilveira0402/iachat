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
      backgroundColor: const Color(0xFF161B22),
      appBar: AppBar(
        title: const Text('iaChat'),
        backgroundColor: const Color(0xFF0D1117),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () => _showClearChatDialog(context, provider),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                controller: provider.scrollController,
                itemCount: provider.messages.length,
                itemBuilder: (context, index) {
                  return _buildChatBubble(provider.messages[index]);
                },
              ),
            ),
          ),
          _buildTextInput(provider),
        ],
      ),
    );
  }

  /// Mostra um alerta antes de limpar o chat
  void _showClearChatDialog(BuildContext context, ChatProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Limpar chat'),
          content: const Text('Tem certeza que deseja apagar todas as mensagens?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                provider.clearChat();
                Navigator.pop(context);
              },
              child: const Text('Limpar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /// Widget para exibir as mensagens do chat
  Widget _buildChatBubble(Map<String, String> msg) {
    bool isUser = msg['role'] == 'user';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Card(
              color: Colors.transparent,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              elevation: 2.0,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isUser ? Colors.blueGrey : const Color(0xFF0D1117),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MarkdownBody(
                  data: msg['content']!,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontSize: 16,
                      color: isUser ? Colors.white : Colors.white70,
                    ),
                    blockquote: TextStyle(
                      color: Colors.greenAccent[200],
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                    code: TextStyle(
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.2),
                      fontFamily: 'monospace',
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget de entrada de texto
  Widget _buildTextInput(ChatProvider provider) {
    return Container(
      color: const Color(0xFF0D1117),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provider.textController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF161B22),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Digite sua mensagem...',
                hintStyle: const TextStyle(color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.grey),
            onPressed: provider.sendMessage,
          ),
        ],
      ),
    );
  }
}
