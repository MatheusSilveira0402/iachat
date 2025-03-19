import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatRepository {
  final String apiKey = 'AIzaSyC1ILQIGuBh5_i1K0VD4Am9JyACnU_AtJA'; // Substitua pela sua chave
  final String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<String> fetchChatResponse(List<Map<String, String>> messages) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": messages.map((msg) => {"text": msg["content"]}).toList()
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String reply = data['candidates'][0]['content']['parts'][0]['text'];
        return reply.trim();
      } else {
        throw Exception("Erro na API: ${response.body}");
      }
    } catch (e) {
      return "Erro ao buscar resposta da IA: $e";
    }
  }
}
