import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'AIService/AIService.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final TextEditingController _promptController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  File? _image;
  final picker = ImagePicker();
  final AIService _aiService = AIService();
  final FocusNode _focusNode = FocusNode();

  Future<void> _getImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.request();
      if (!status.isGranted) {
        print('Camera permission denied.');
        return;
      }
    }

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _sendMessage() async {
    if (_image == null || _promptController.text.isEmpty) return;

    String base64Image = base64Encode(_image!.readAsBytesSync());
    String prompt = _promptController.text;

    setState(() {
      _messages.add({"sender": "user", "prompt": prompt, "image": _image});
      _image = null;
      _promptController.clear();
      _focusNode.unfocus();
    });

    try {
      String aiResponse = await _aiService.analyzeImage(prompt, base64Image);
      setState(() {
        _messages.add({"sender": "assistant", "text": aiResponse});

        print( aiResponse);
      });
    } catch (e) {
      setState(() {
        _messages.add({"sender": "assistant", "text": "Error: $e"});
      });
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
            message['prompt'] ?? '',
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
  void dispose() {
    _promptController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with GPT-4 Vision"),
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
                    controller: _promptController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: "Enter your prompt",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
