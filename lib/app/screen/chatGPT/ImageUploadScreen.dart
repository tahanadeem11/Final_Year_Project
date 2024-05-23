import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';



class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  File? _image;
  final picker = ImagePicker();
  final String apiKey = "''''";

  Future<void> _getImage(ImageSource source) async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await picker.getImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _sendImageMessage();
      }
    } else {
      // Handle permission denied
    }
  }

  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.add({"sender": "user", "text": text});
      _messageController.clear();
    });

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };

    var payload = jsonEncode({
      "model": "gpt-4o",
      "messages": [
        {
          "role": "user",
          "content": [
            {"type": "text", "text": text},
          ]
        }
      ],
      "max_tokens": 300
    });

    var response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: headers,
      body: payload,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var aiResponse = jsonResponse['choices'][0]['message']['content'];
      setState(() {
        _messages.add({"sender": "assistant", "text": aiResponse});
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _sendImageMessage() async {
    if (_image == null) return;

    String base64Image = base64Encode(_image!.readAsBytesSync());

    setState(() {
      _messages.add({
        "sender": "user",
        "image": _image,
      });
      _image = null;
    });

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };

    var payload = jsonEncode({
      "model": "gpt-4o",
      "messages": [
        {
          "role": "user",
          "content": [
            {"type": "image_url", "image_url": {"url": "data:image/jpeg;base64,$base64Image"}},
          ]
        }
      ],
      "max_tokens": 300
    });

    var response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: headers,
      body: payload,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var aiResponse = jsonResponse['choices'][0]['message']['content'];
      setState(() {
        _messages.add({"sender": "assistant", "text": aiResponse});
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    if (message.containsKey('image')) {
      return Column(
        crossAxisAlignment: message['sender'] == 'user'
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Image.file(message['image']),
          Text(
            message['text'] ?? '',
            style: TextStyle(color: message['sender'] == 'user' ? Colors.blue : Colors.green),
          ),
        ],
      );
    } else {
      return Text(
        message['text'] ?? '',
        style: TextStyle(color: message['sender'] == 'user' ? Colors.blue : Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with GPT-4"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () => _getImage(ImageSource.camera),
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () => _getImage(ImageSource.gallery),
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Enter your message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
