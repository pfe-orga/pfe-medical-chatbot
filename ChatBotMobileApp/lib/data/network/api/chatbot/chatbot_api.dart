import '../../../models/ChatbotModel.dart';
import '../dio_client.dart';

class ChatbotApi{
  final DioClient dioClient;
  ChatbotApi({required this.dioClient});
  Future<ChatModel> getChatResponse(String inputText) async {
    final response = await dioClient.get("${Endpoints.SecurityEndpoints}/chatbot/$inputText");
    final responseData = response.data as Map<String, dynamic>;
    return ChatModel.fromJson(responseData);
  }
}