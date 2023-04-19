import 'package:localstorage/localstorage.dart';

class SharedResourcesService {
  static const String token = "TOKEN";
  final LocalStorage storage = LocalStorage('authorization');

  Future<void> setUserToken({required String userToken}) async {
    await storage.setItem(token, userToken);
  }

  String? getUserToken() {
    return storage.getItem(token);
  }
}