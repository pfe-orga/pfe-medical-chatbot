
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pfemedicalchatbotapp/controllers/HomeController.dart';
import 'package:pfemedicalchatbotapp/controllers/RegistrationController.dart';

import '../controllers/LoginController.dart';
import '../data/network/api/dio_client.dart';
import '../data/network/api/interceptors.dart';
import '../data/network/api/user/user_api.dart';
import '../data/network/api/user/weather_forcast_api.dart';
import '../data/sharedprefs/shared_resources_service.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioInterceptor(sharedService: SharedResourcesService()));
  getIt.registerSingleton(DioClient(getIt<Dio>(), getIt<DioInterceptor>()));
  getIt.registerSingleton(UserApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(WfApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(HomeController(userApi: getIt<UserApi>(), wfApi: getIt<WfApi>()));
  getIt.registerSingleton<SharedResourcesService>(SharedResourcesService());
  getIt.registerSingleton(LoginController(userApi: getIt<UserApi>(), wfApi: getIt<WfApi>(), sharedResourcesService: getIt<SharedResourcesService>()));
  getIt.registerSingleton(RegistrationController(userApi: getIt<UserApi>(), wfApi: getIt<WfApi>(), sharedResourcesService: getIt<SharedResourcesService>()));


}