import 'package:dio/dio.dart';

import '../../../models/GeoModel.dart';
import '../dio_client.dart';

class GeoApi{
  final DioClient dioClient;
  GeoApi({required this.dioClient});
  Future<List<GeoModel>> getDoctorsList() async {
    try {
      final response = await dioClient.get("${Endpoints.SecurityEndpoints}/DoctorsList");
      print(response.data);
      return (response.data as List).map((e) => GeoModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }
}