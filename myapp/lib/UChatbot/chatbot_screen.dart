import 'package:flutter/material.dart';
import 'openai.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _conversation = [];
  bool _showInitialMessage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _conversation.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_conversation[index]),
                    );
                  },
                ),
              ),
              _buildInputField(),
            ],
          ),
          _showInitialMessage ? _buildInitialMessage() : SizedBox(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Chatbot'),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialMessage() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        color: Color(0xFFFFE7C4),
        child: Text(
          'Hello! How can I help you today?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  void _sendMessage() async {
    setState(() async {
      String message = _textEditingController.text;
      _conversation.add('User: $message');

      if (_showInitialMessage) {
        _showInitialMessage = false;
      }

      try {
        String botResponse = await OpenAI.getCompletion(message);
        _conversation.add('Chatbot: $botResponse');
      } catch (e) {
        print('Error: $e');
        _conversation.add('Chatbot: Error occurred while fetching response');
      }

      _textEditingController.clear();
    });
  }
}
