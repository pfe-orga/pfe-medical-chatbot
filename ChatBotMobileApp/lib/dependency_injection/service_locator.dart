
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pfemedicalchatbotapp/controllers/HomeController.dart';

import '../data/network/api/dio_client.dart';
import '../data/network/api/user/user_api.dart';
import '../data/network/api/user/weather_forcast_api.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  getIt.registerSingleton(UserApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(WfApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(UserRepository(userApi: getIt<UserApi>()));
  getIt.registerSingleton(HomeController(wfApi: getIt<WfApi>()));

}