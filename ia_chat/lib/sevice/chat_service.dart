import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = ""; // 🔥 Substitua pela sua chave 
  final String apiUrl = "";

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "Você é um assistente de IA útil."},
            {"role": "user", "content": message}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"].toString();
      } else {
        return "Erro na API: ${response.statusCode}";
      }
    } catch (e) {
      return "Erro ao conectar com a API: $e";
    }
  }
}
