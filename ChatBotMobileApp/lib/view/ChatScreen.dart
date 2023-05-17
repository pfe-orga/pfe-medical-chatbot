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
  final TextEditingController _textEditingController = TextEditingController();
  bool _isTextFieldFocused = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isTextFieldFocused = true;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/chatbotbackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _data.length + _resp.length,
                  itemBuilder: (context, index) {
                    if (index % 2 == 0) {
                      // User message
                      final userIndex = index ~/ 2;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF51f8e6),
                                      Color(0xFF5eeaa2)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Text(
                                    _data[userIndex],
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Bot message
                      final botIndex = (index - 1) ~/ 2;
                      final response = _resp[botIndex];
                      final botMessage = response.toString();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF51f8e6),
                                      Color(0xFF5eeaa2)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Text(
                                    botMessage,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8.0),
                margin: EdgeInsets.only(
                  bottom: _isTextFieldFocused
                      ? MediaQuery.of(context).viewInsets.bottom
                      : 0.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: FocusNode(),
                        controller: _textEditingController,
                        onTap: () {
                          setState(() {
                            _isTextFieldFocused = true;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            // Handle TextField value changes
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter a message',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendUserMessage();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendUserMessage() async {
    final inputText = _textEditingController.text;
    _textEditingController.clear();
    final userMessage = 'User: $inputText';
    setState(() {
      _data.add(userMessage);
    });

    final botResponse = await chatbotController.getChatResponse(inputText);
    final botMessage = 'Bot: ${botResponse.response?.response ?? ''}';

    setState(() {
      _resp.add(botMessage);
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
}
