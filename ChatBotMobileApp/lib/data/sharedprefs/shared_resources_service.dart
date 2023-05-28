import 'package:localstorage/localstorage.dart';
import 'package:pfemedicalchatbotapp/data/models/AddModel.dart';
import 'package:pfemedicalchatbotapp/data/models/UserModel.dart';

class SharedResourcesService {
  static const String token = "TOKEN";
  final LocalStorage storage = LocalStorage('authorization');
  static const String profile = "PROFILE";

  Future<void> setUserToken({required String userToken}) async {
    await storage.setItem(token, userToken);
  }

  String? getUserToken() {
    return storage.getItem(token);
  }
  Future<void> setUserProfile({required UserModel userProfile}) async {
    print('userProfile: ${userProfile}');
    await storage.setItem(profile, userProfile);
  }
  UserModel? getUserProfile() {
    return storage.getItem(profile);
  }
}
