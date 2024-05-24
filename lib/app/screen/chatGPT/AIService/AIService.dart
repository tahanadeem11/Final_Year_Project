import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  String get apiKey => dotenv.env['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'] ?? 'No API Key';

  AIService();

  Future<String> analyzeImage(String prompt, String imageBase64) async {
    try {
      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': 'gpt-4-vision-preview',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant, capable of identifying ANYTHING in images.'},
            {'role': 'user', 'content': [
              {
                "type": "text",
                "text": prompt
              },
              {
                "type": "image_url",
                "image_url": 'data:image/jpeg;base64,$imageBase64'
              }
            ]},
          ],
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var aiResponse = jsonData['choices']?.first['message']['content'] ?? '';
        return aiResponse;
      } else {
        return 'Error: ${response.statusCode} ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
