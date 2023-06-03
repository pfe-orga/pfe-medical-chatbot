import 'dart:convert';

class RegistrationModel {
  String? Email;
  String? Password;
  String? Name;
  String? Role;

  RegistrationModel({this.Email, this.Password, this.Name, this.Role});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    Name = json ['Name'];
    Email = json['Email'];
    Password = json['Password'];
    Role = json['Role'];
  }

    String toJson() {
    final Map<String, String> data = <String, String>{};
    data['Name'] =  Name!;
    data['Email'] = Email!;
    data['Password'] = Password!;
    data['Role'] = Role!;
    final String jsonData = jsonEncode(data);
    return jsonData;
  }
}