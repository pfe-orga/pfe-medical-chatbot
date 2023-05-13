import 'package:dio/dio.dart';
import 'package:pfemedicalchatbotapp/data/models/RegistrationModel.dart';
import '../../../models/AddModel.dart';
import '../../../models/ListModel.dart';
import '../../../models/LoginModel.dart';
import '../../../models/UserModel.dart';
import '../dio_client.dart';

class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dioClient.get(Endpoints.Users);
      final users = (response.data['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      return users;
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserModel> me() async {
    try {
      final response = await dioClient.get("${Endpoints.SecurityEndpoints}/me");
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  login(LoginModel loginModel) async {
    try {
      final response = await dioClient.post("${Endpoints.SecurityEndpoints}/Login",data: loginModel.toJson());
      return response.data;
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }
  register(RegistrationModel registrationModel) async {
    try {
      final response = await dioClient.post("${Endpoints.SecurityEndpoints}/Register",data: registrationModel.toJson());
      return response.data;
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<List<ListModel>> getList() async {
    try {
      final response = await dioClient.get("${Endpoints.SecurityEndpoints}/List");
      print(response.data);
      return (response.data as List).map((e) => ListModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<User> addUser(User user) async  {
    try {
      final response = await dioClient.post("${Endpoints.SecurityEndpoints}/Add",data: user.toJson());
      return User.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<void> deleteUser(int id) async {
    try {
      await dioClient.delete("${Endpoints.SecurityEndpoints}/Delete/"+ id.toString());
    } catch (e) {
      rethrow;
    }
  }
  Future<UserModel> updateUser(UserModel userModel) async {
    final response = await dioClient.put("${Endpoints.SecurityEndpoints}/Update", data: userModel.toJson());
    return UserModel.fromJson(response.data);
  }
}


//
  // Future<NewUser> addNewUser(String username, String email, String password) async {
  //   try {
  //     const newUser = {
  //
  //     };
  //     final response = await dioClient.post(Endpoints.Users, newUser);
  //     return NewUser.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
  //
  // Future<NewUser> updateUserRequested(int id, String username, String email, String password) async {
  //   try {
  //     final response = await userApi.updateUserApi(id, username, password, email);
  //     return NewUser.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print(e);
  //     rethrow;
  //
  //   }
  // }
  //
  // Future<void> deleteNewUserRequested(int id) async {
  //   try {
  //     await userApi.deleteUserApi(id);
  //   } on DioError catch (e) {
  //     print(e);
  //     rethrow;
  //
  //   }
  // }
