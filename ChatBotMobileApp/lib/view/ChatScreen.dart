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
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF51f8e6), Color(0xFF5eeaa2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text(
          'Sanitas Bot',
          style: TextStyle(
            fontFamily: 'coolvetica',
            fontSize: 40,
            fontWeight: FontWeight.w300,
            foreground: Paint()
              ..color = Colors.white
              ..strokeWidth = 1
              ..style = PaintingStyle.fill,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isTextFieldFocused = true;
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 10,
                child: Container(
                  width: 100,
                  height: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF93aece),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _data.length + _resp.length,
                      padding: const EdgeInsets.only(top: 20),
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          // User message
                          final userIndex = index ~/ 2;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF51f8e6),
                                            Color(0xFF5eeaa2),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13),
                                        child: Text(
                                          _data[userIndex],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Bot message
                          final botIndex = (index - 1) ~/ 2;
                          final response = _resp[botIndex];
                          final botMessage = response.toString();
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'lib/assets/sanitaslogo.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFE4E5E8),
                                            Color(0xFFE4E5E8),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13),
                                        child: Text(
                                          botMessage,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(
                      bottom: _isTextFieldFocused
                          ? MediaQuery.of(context).viewInsets.bottom
                          : 0.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldContainer(
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
                              decoration: const InputDecoration(
                                border: InputBorder.none, // Remove underline
                                hintText: 'Enter a message',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF93aece),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            sendUserMessage();
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              'lib/assets/image__4_-removebg-preview.png',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
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
    final userMessage = '$inputText';
    setState(() {
      _data.add(userMessage);
    });

    final botResponse = await chatbotController.getChatResponse(inputText);
    final botMessage = ' ${botResponse.response?.response ?? ''}';

    setState(() {
      _resp.add(botMessage);
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      shadowColor: const Color(0xFF979797),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFffffff),
          borderRadius: BorderRadius.circular(30),
        ),
        child: child,
      ),
    );
  }
}
