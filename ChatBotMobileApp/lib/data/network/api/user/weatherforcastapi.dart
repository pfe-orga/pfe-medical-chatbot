import '../dio_client.dart';
import 'package:dio/dio.dart';
import '../../../models/weatherModel.dart';
class WfApi {
  final DioClient dioClient;

  WfApi({required this.dioClient});

  Future<Response> getWF() async {
    try {
      return await dioClient.get(Endpoints.weatherForecast);
    } catch (e) {
      rethrow;
    }
  }
}
