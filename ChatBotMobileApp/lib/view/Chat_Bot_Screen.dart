import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import '../controllers/ChatBotController.dart';
import '../data/models/ChatbotModel.dart';
import '../dependency_injection/service_locator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatbotController = getIt<ChatbotController>();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Chatbot"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          AnimatedList(
            key: _listKey,
            initialItemCount: _data.length,
            itemBuilder: (BuildContext context, int index, Animation<double> animation) {
              return buildItem(_data[index], animation, index);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              colorFilter: const ColorFilter.linearToSrgbGamma(),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: chatbotController.inputTextController,
                        onSubmitted: (_) => sendUserMessage(),
                      ),
                      TextField(
                        controller: chatbotController.responseController,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ),
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
    final botMessage = 'Bot: ${botResponse.response}';
    setState(() {
      _data.add(botMessage);
      chatbotController.responseController.text = botResponse.response!.toString();
    });
  }


  Widget buildItem(String item, Animation<double> animation, int index) {
    bool mine = item.endsWith("<bot>");
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          alignment: mine ? Alignment.topLeft : Alignment.topRight,
          child: Bubble(
            child: Text(
              item.replaceAll("<bot>", ""),
              style: TextStyle(color: mine ? Colors.white : Colors.black),
            ),
            color: mine ? Colors.blue : Colors.white,
            padding: BubbleEdges.all(10),
          ),
        ),
      ),
    );
  }
}

