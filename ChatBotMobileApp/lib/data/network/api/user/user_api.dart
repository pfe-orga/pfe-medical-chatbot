import 'package:dio/dio.dart';

import '../../../models/UserModel.dart';
import '../dio_client.dart';

class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

  Future<Response> getUsersApi() async {
    try {
      return await dioClient.get(Endpoints.Users);
    } catch (e) {
      rethrow;
    }
  }

}
class UserRepository {
  final UserApi userApi;

  UserRepository({required this.userApi});

  Future<List<UserModel>> getUsersRequested() async {
    try {
      final response = await userApi.getUsersApi();
      final users = (response.data['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      return users;
    } on DioError catch (e) {
      print(e);
      rethrow;

    }
  }

  Future<NewUser> addNewUserRequested(String Username, String Email, String Password) async {
    try {
      final response = await userApi.addUserApi(Username, Email,Password);
      return NewUser.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<NewUser> updateUserRequested(String Username, String Email, String Password) async {
    try {
      final response = await userApi.updateUserApi(id, username, password, email);
      return NewUser.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      rethrow;

    }
  }

  Future<void> deleteNewUserRequested(int id) async {
    try {
      await userApi.deleteUserApi(id);
    } on DioError catch (e) {
      print(e);
      rethrow;

    }
  }
}
