import '../../../models/ChatbotModel.dart';
import '../../../models/MedicationModel.dart';
import '../dio_client.dart';
import 'dart:io';

class ChatbotApi{
  final DioClient dioClient;
  ChatbotApi({required this.dioClient});
  Future<ChatModel> getChatResponse(String inputText) async {
    final response = await dioClient.get("${Endpoints.SecurityEndpoints}/chatbot/$inputText");
    final responseData = response.data as Map<String, dynamic>;
    return ChatModel.fromJson(responseData);
  }
  Future<MedicationModel> GetMedicineInfoAsync(File  image) async {
    final response = await dioClient.post("${Endpoints.SecurityEndpoints}/medicineinfo");
    final responseData = response.data as Map<String, dynamic>;
    return MedicationModel.fromJson(responseData);
  }
}
