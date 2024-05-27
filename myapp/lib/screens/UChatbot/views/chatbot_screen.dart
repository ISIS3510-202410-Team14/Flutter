import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../openai.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List<Map<String, String>> _conversation = [];
  bool _showInitialMessage = true;
  late ScrollController _scrollController;
  bool _isConnected = true; // Inicialmente se asume que hay conexión

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _checkInternetConnectivity(); // Verificar la conexión al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _conversation.length,
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(_conversation[index]);
                  },
                ),
              ),
              _buildInputField(),
            ],
          ),
          _buildInitialMessage(),
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

  Widget _buildMessageBubble(Map<String, String> message) {
    final isUserMessage = message['sender'] == 'User';
    final color = isUserMessage ? Colors.white : Color(0xFFFFE7C4);
    final alignment = isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: isUserMessage
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ]
                  : [],
            ),
            padding: const EdgeInsets.all(12.0),
            margin: isUserMessage ? EdgeInsets.only(left: 100.0) : EdgeInsets.only(right: 100.0),
            child: Text(message['content']!),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialMessage() {
    return _showInitialMessage ? Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        color: Color(0xFFFFE7C4),
        child: Text(
          _isConnected ? 'Hello! How can I help you today?' : 'No internet connection. Please check your connection and try again.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    ) : SizedBox();
  }

  void _sendMessage() async {
    setState(() async {
      String message = _textEditingController.text;
      _conversation.add({'sender': 'User', 'content': message});

      if (_showInitialMessage) {
        _showInitialMessage = false;
      }

      if (_isConnected) {
        try {
          String botResponse = await OpenAI.getCompletion(message);
          _conversation.add({'sender': 'Chatbot', 'content': botResponse});
        } catch (e) {
          print('Error: $e');
          _conversation.add({'sender': 'Chatbot', 'content': 'Error fetching response, try again later'});
        }
      } else {
        _conversation.add({'sender': 'Chatbot', 'content': 'No internet connection'});
      }

      _textEditingController.clear();
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = (connectivityResult != ConnectivityResult.none);
    });
  }
}
