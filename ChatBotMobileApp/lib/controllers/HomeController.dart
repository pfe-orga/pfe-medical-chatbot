import 'package:flutter/cupertino.dart';
import 'package:pfemedicalchatbotapp/data/network/api/user/weather_forcast_api.dart';

import '../data/models/ListModel.dart';
import '../data/models/LoginModel.dart';
import '../data/models/RegistrationModel.dart';
import '../data/models/UserModel.dart';
import '../data/models/WeatherModel.dart';
import '../data/network/api/user/user_api.dart';
import '../data/sharedprefs/shared_resources_service.dart';

class HomeController {
  final WfApi wfApi;
  final UserApi userApi;
  final SharedResourcesService sharedResourcesService;


  HomeController({required this.userApi, required this.wfApi,required this.sharedResourcesService
  });

  // --------------- Repository -------------
  // final userRepository = getIt.get<UserRepository>();

  // -------------- Textfield Controller ---------------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();
  final currentDateController = TextEditingController();
  final newDateController = TextEditingController();
  final roleController = TextEditingController();
  final idController = TextEditingController();

  // -------------- Local Variables ---------------
  final List<NewUser> newUsers = [];


  // -------------- Methods ---------------

  Future<List<UserModel>> getUsers() async {
    return await userApi.getUsers();
  }

  Future<UserModel> me(String token) async {
      var globalconnecteduser;
      var result = await userApi.me(token).then((value) {
        globalconnecteduser = value;
        sharedResourcesService.setUserProfile(userProfile: value);
        return value;
      });
      return result;

  }

  Future<List<WeatherModel>> getWfs() async {
    var wf =  await wfApi.getWF();
    return (wf.data as List)
        .map((e) => WeatherModel.fromJson(e))
        .toList();
  }
  //registration controller
  Future<bool> register() async {
    var register = RegistrationModel(Email:emailController.text, Name:nameController.text, Password: passwordController.text, Role: roleController.text);
    print('username : ${register.Name}');
    print('email : ${register.Email}');
    print('pwd: ${register.Password}');
    var token =  await userApi.register(register);
    sharedResourcesService.setUserToken(userToken: token);
    print('token: ${token}');
    return token != null ? true : false;
  }

  //login controller

  Future<String> login() async {
    var login = LoginModel(Email:emailController.text, Password: passwordController.text);
    print('email : ${login.Email}');
    print('pwd: ${login.Password}');
    var token =  await userApi.login(login);
    sharedResourcesService.setUserToken(userToken: token);
    print('token: ${token}');
    return token;
  }


  void init() {
    if(sharedResourcesService.getUserToken() != null){
      // redirection
    }
  }

  //List controller
  Future<List<ListModel>> getList() async {
    return await userApi.getList();
  }
  //Delete controller
  Future<void> deleteUser(int id) async {
    await userApi.deleteUser(id);
  }


  Future<void> updateUser({required ListModel listModel}) async{
      await userApi.updateUser(listModel);

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


