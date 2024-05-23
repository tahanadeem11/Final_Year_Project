import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ImageChatScreen extends StatefulWidget {
  const ImageChatScreen({super.key});

  @override
  State<ImageChatScreen> createState() => _ImageChatScreenState();
}

class _ImageChatScreenState extends State<ImageChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  void callAPI(String message) async {
    setState(() {
      _messages.add("You: $message");
      _messages.add("Bot: Typing..."); // Add typing indicator
    });

    // Prepare the messages for the API request
    List<Map<String, dynamic>> messages = [
      {"role": "user", "content": message}
    ];

    // Encode the request body to JSON
    String requestBodyJson = json.encode({
      "model": "dall-e-3",
      "prompt": message,
      "size": "1024x1024",
      "quality": "standard",
      "n": 1,
    });

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generate'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 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',
        },
        body: requestBodyJson,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> responseBody = json.decode(response.body);
        String imageUrl = responseBody['data'][0]['url'].toString();
        // Handle the response (e.g., update UI)
        addImageResponse(imageUrl);
      } else {
        // Handle errors
        addResponse("Failed to generate image due to ${response.body}");
      }
    } catch (e) {
      // Handle exceptions
      addResponse("Error: $e");
    }
  }

  // Example method to handle text responses
  void addResponse(String response) {
    setState(() {
      _messages.add("Bot: $response");
    });
  }

  // Example method to handle image responses
  void addImageResponse(String imageUrl) {
    setState(() {
      _messages.add("Bot: Image generated");
      _messages.add(imageUrl); // Display image URL as text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT Integration'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    // User message
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _messages[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    // Bot message
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _messages[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onSubmitted: (message) {
                      callAPI(message);
                      _controller.clear();
                    },
                  ),
                ),
                SizedBox(width: 8),
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      String message = _controller.text.trim();
                      if (message.isNotEmpty) {
                        _controller.clear();
                        callAPI(message);
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
