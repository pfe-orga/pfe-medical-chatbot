import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../models/ChatbotModel.dart';
import '../../../models/MedicamentModel.dart';
import '../../../models/MedicationModel.dart';
import '../../../models/MedicineInfoModel.dart';
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

  Future<MedicationModel> GetMedicineInfoAsync(File image) async {
    String endpoint = "${Endpoints.SecurityEndpoints}/medicineinfo";
    String boundary = 'boundary';

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path, filename: 'image.png'),
    });

    Options options = Options(
      headers: {
        'Content-Type': 'multipart/form-data; boundary=$boundary',
      },
    );

    try {
      Response response = await dioClient.post(endpoint, data: formData, options: options);
      Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      return MedicationModel.fromJson(responseData);
    } catch (error) {
      throw Exception('Failed to get medicine info: $error');
    }
  }


  Future<MedicamentModel> GetMedicineResponse(String text) async {
    try {
      final response = await dioClient.post(
        "${Endpoints.SecurityEndpoints}/medicineinfotext",
        data: {"input": text},
      );
      final responseData = response.data;
      return MedicamentModel.fromJson(responseData);
    } catch (error) {
      print("Error in GetMedicineResponse: $error");
      throw error;
    }
  }

  Future<MedicineInfoResponse> getMedicineInfo(File image) async {
    String endpoint = "${Endpoints.SecurityEndpoints}/medicineinfo";
    String boundary = 'boundary';

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path, filename: 'image.png'),
    });

    Options options = Options(
      headers: {
        'Content-Type': 'multipart/form-data; boundary=$boundary',
      },
    );

    try {
      Response response = await dioClient.post(endpoint, data: formData, options: options);
      Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      return MedicineInfoResponse.fromJson(responseData);
    } catch (error) {
      throw Exception('Failed to get medicine info: $error');
    }
  }
}
