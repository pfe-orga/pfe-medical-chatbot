import 'package:flutter/cupertino.dart';
import 'package:pfemedicalchatbotapp/data/network/api/user/weatherforcastapi.dart';

import '../data/models/UserModel.dart';
import '../data/models/weatherModel.dart';
import '../data/network/api/user/user_api.dart';
import '../di/service_locator.dart';

class HomeController {
  final WfApi wfApi;

  HomeController(this.wfApi);

  // --------------- Repository -------------
  final userRepository = getIt.get<UserRepository>();

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
    final users = await userRepository.getUsersRequested();
    return users;
  }

  Future<List<WeatherModel>> getWfs() async {
    var wf =  await wfApi.getWF();
    return (wf.data as List)
        .map((e) => WeatherModel.fromJson(e))
        .toList();
  }

  Future<NewUser> addNewUser() async {
    final newlyAddedUser = await userRepository.addNewUserRequested(
      usernameController.text,
      emailController.text,
      passwordController.text,
    );
    newUsers.add(newlyAddedUser);
    return newlyAddedUser;
  }

  Future<NewUser> updateUser(int id, String username,String email, String password) async {
    final updatedUser = await userRepository.updateUserRequested(
      id,
      username,
      email,
      password
    );
    newUsers[id] = updatedUser;
    return updatedUser;
  }

  Future<void> deleteNewUser(int id) async {
    await userRepository.deleteNewUserRequested(id);
    newUsers.removeAt(id);
  }

}


