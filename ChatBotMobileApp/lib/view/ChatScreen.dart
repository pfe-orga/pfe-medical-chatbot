import 'package:flutter/material.dart';
import '../controllers/ChatBotController.dart';
import '../dependency_injection/service_locator.dart';

class ChatScreenn extends StatefulWidget {
  @override
  State<ChatScreenn> createState() => _ChatScreennState();
}

class _ChatScreennState extends State<ChatScreenn> {
  ScrollController _scrollController = ScrollController();
  final chatbotController = getIt<ChatbotController>();
  List<String> _data = [];
  List<String> _resp = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _data.length + _resp.length, // Replace with the actual number of chat messages
              itemBuilder: (context, index) {
                if (index < _data.length){
                  // User message
                  return ListTile(
                    title: Text(_data[index]),
                  );
                }else {
                  // Bot message
                  final botIndex = index - _data.length;
                  final response = _resp[botIndex];
                  // final botMessage = response is String ? response : (response['text']?? '').toString();
                  final botMessage = response.toString();
                  return ListTile(
                      title: Text(botMessage),
                  );
                }
              },
            ),
          ),
          Padding(
            padding:const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                   controller: chatbotController.inputTextController,
                    onSubmitted: (_) => sendUserMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendUserMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void sendUserMessage() async {
    final inputText = chatbotController.inputTextController.text;
    chatbotController.inputTextController.clear();
    final userMessage = 'User: $inputText';
    setState(() {
      _data.add(userMessage);

    });

    final botResponse = await chatbotController.getChatResponse(inputText);
    // final botMessage = 'Bot: ${botResponse.response}';
    final botMessage = 'Bot: ${botResponse.response?.response ?? ''}'; // Access the 'response' property
    print(botResponse.response);
    setState(() {
      // _resp[_resp.length - 1] = botMessage;
      _data.add(botMessage);
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      chatbotController.responseController.text = botResponse.response?.response?.toString() ?? '';
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

}
