class UserModel {
  int? id;
  String? Username;
  String? Password;
  String? Email;

  UserModel({this.id, this.Username,this.Password,this.Email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Username = json['Username'];
    Password = json['Password'];
    Email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Username'] = Username;
    data['Password'] = Password;
    data['Email'] = Email;
    return data;
  }
}
class NewUser {
  int? id;
  String? Username;
  String? Password;
  String? Email;

  NewUser({this.Username, this.id, this.Password, this.Email});

  NewUser.fromJson(Map<String, dynamic> json) {
    Username = json['Username'];
    Password = json['Password'];
    id = json['id'];
    Email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Username'] = Username;
    data['Password'] = Password;
    data['id'] = id;
    data['Email'] = Email;
    return data;
  }
}