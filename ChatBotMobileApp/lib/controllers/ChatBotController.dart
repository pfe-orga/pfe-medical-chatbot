import 'package:flutter/cupertino.dart';
import '../data/models/ChatbotModel.dart';
import '../data/models/MedicationModel.dart';
import '../data/network/api/chatbot/chatbot_api.dart';
import '../data/sharedprefs/shared_resources_service.dart';
import 'dart:io';

class ChatbotController {
  final ChatbotApi chatbotApi ;
  final SharedResourcesService sharedResourcesService;
  ChatbotController({required this.chatbotApi, required this.sharedResourcesService});


  // --------------  Controller ---------------

  final  inputTextController = TextEditingController();
  final  responseController = TextEditingController();
  final List<String> history = [];
  final medicine_nameController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final errorController = TextEditingController();
  final imageController = TextEditingController();

  // -------------- Methods -------------------

  Future<ChatModel> getChatResponse(String inputText ) async {
     return await chatbotApi.getChatResponse(inputText);
  }
  Future<MedicationModel> GetMedicineInfoAsync(File  image) async {
    return await chatbotApi.GetMedicineInfoAsync(image);
  }



  Future<MedicationModel> GetMedicineResponse(String text) async {
    return await chatbotApi.GetMedicineResponse(text);
  }

}
