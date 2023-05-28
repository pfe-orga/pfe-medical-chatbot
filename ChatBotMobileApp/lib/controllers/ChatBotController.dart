import 'package:flutter/cupertino.dart';
import '../data/models/ChatbotModel.dart';
import '../data/network/api/chatbot/chatbot_api.dart';
import '../data/sharedprefs/shared_resources_service.dart';

class ChatbotController {
  final ChatbotApi chatbotApi ;
  final SharedResourcesService sharedResourcesService;
  ChatbotController({required this.chatbotApi, required this.sharedResourcesService});


  // --------------  Controller ---------------

  final  inputTextController = TextEditingController();
  final  responseController = TextEditingController();
  final List<String> history = [];

  // -------------- Methods -------------------

  Future<ChatModel> getChatResponse(String inputText ) async {
     return await chatbotApi.getChatResponse(inputText);

  }
}
