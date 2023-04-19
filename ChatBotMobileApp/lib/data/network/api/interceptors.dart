import 'package:dio/dio.dart';

import '../../../dependency_injection/service_locator.dart';
import '../../sharedprefs/shared_resources_service.dart';
import 'dio_client.dart';

// class DioInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions requestOptions,RequestInterceptorHandler handler){
//     final DioClient dioClient;
//
//     if (!requestOptions.path.contains("open")){
//       requestOptions.queryParameters["id"] = "xxx";
//     }
//     requestOptions.headers["token"] = "xxx";
//     if (requestOptions.headers['refreshToken'] == null) {
//       dioClient.dio.lock();
//       Dio _tokenDio = Dio();
//       _tokenDio.get('/token').then((d) {
//         requestOptions.headers['refreshToken'] = d.data['data'] ['token'];
//         handler.next(requestOptions);
//
//       }).catchError((error, stackTrace) {
//         handler.reject(error, true);
//       }).whenComplete(() {
//         DioClient.dio.unlock();
//     });
//     }
//     return super.onRequest(requestOptions, handler);
//   }
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if (response.statusCode == 200){
//     } else {}
//     if (response.requestOptions.baseUrl.contains("secret")){}
//     return super.onResponse(response, handler);
//   }
//   @override
//   void onError(DioError error, ErrorInterceptorHandler handler){
//     switch (error.type){
//       case DioErrorType.connectTimeout:
//         {}
//         break;
//       case DioErrorType.receiveTimeout:
//         {}
//         break;
//       case DioErrorType.sendTimeout:
//         {}
//         break;
//       case DioErrorType.cancel:
//         {}
//         break;
//       case DioErrorType.response:
//         {}
//         break;
//       case DioErrorType.other:
//         {}
//         break;
//     }
//     super.onError(error, handler);
//   }
//
// }


class DioInterceptor extends Interceptor {
  final SharedResourcesService sharedService;
  DioInterceptor({required this.sharedService });
  
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('authorization header added to request');
    if(options.path.contains("token")) {
      options.headers['Authorization'] =
      'Bearer ${sharedService.getUserToken()}';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
