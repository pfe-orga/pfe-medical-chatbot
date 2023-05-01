import 'package:flutter/cupertino.dart';
import 'package:pfemedicalchatbotapp/data/models/RegistrationModel.dart';
import '../data/models/UserModel.dart';
import '../data/network/api/user/user_api.dart';
import '../data/network/api/user/weather_forcast_api.dart';
import '../data/sharedprefs/shared_resources_service.dart';

class RegistrationController {
  final WfApi wfApi;
  final UserApi userApi;
  final SharedResourcesService sharedResourcesService;


  RegistrationController({required this.userApi, required this.wfApi, required this.sharedResourcesService});

  // --------------- Repository -------------
  // final userRepository = getIt.get<UserRepository>();

  // -------------- Textfield Controller ---------------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();
  final currentDateController = TextEditingController();
  final newDateController = TextEditingController();





  // -------------- Local Variables ---------------
  final List<NewUser> newUsers = [];

  // -------------- Methods ---------------

  Future<List<UserModel>> getUsers() async {
    return await userApi.getUsers();
  }

  Future<UserModel> me() async {
    return await userApi.me();
  }

  Future<bool> register() async {
    var register = RegistrationModel(Email:emailController.text, Name:nameController.text, Password: passwordController.text );
    print('username : ${register.Name}');
    print('email : ${register.Email}');
    print('pwd: ${register.Password}');
    var token =  await userApi.register(register);
    sharedResourcesService.setUserToken(userToken: token);
    print('token: ${token}');
    return token != null ? true : false;
  }
}

