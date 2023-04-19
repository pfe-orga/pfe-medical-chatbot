import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pfemedicalchatbotapp/data/network/api/user/weather_forcast_api.dart';
import '../data/models/LoginModel.dart';
import '../data/models/UserModel.dart';
import '../data/network/api/user/user_api.dart';
import '../data/sharedprefs/shared_resources_service.dart';

class LoginController {
  final WfApi wfApi;
  final UserApi userApi;
  final SharedResourcesService sharedResourcesService;


  LoginController({required this.userApi, required this.wfApi, required this.sharedResourcesService});

  // --------------- Repository -------------
  // final userRepository = getIt.get<UserRepository>();

  // -------------- Textfield Controller ---------------
  final usernameController = TextEditingController();
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

  Future<bool> login() async {
    var login = LoginModel(Email:emailController.text, Password: passwordController.text );
    print('email : ${login.Email}');
    print('pwd: ${login.Password}');
    var token =  await userApi.login(login);
    sharedResourcesService.setUserToken(userToken: token);
    print('token: ${token}');
    return token != null ? true : false;
  }

  void init() {
    if(sharedResourcesService.getUserToken() != null){
      // redirection
    }
  }

  // Future<NewUser> addNewUser() async {
  //   final newlyAddedUser = await userRepository.addNewUserRequested(
  //     usernameController.text,
  //     emailController.text,
  //     passwordController.text,
  //   );
  //   newUsers.add(newlyAddedUser);
  //   return newlyAddedUser;
  // }
  //
  // Future<NewUser> updateUser(int id, String username,String email, String password) async {
  //   final updatedUser = await userRepository.updateUserRequested(
  //     id,
  //     username,
  //     email,
  //     password
  //   );
  //   newUsers[id] = updatedUser;
  //   return updatedUser;
  // }
  //
  // Future<void> deleteNewUser(int id) async {
  //   await userRepository.deleteNewUserRequested(id);
  //   newUsers.removeAt(id);
  // }

}


