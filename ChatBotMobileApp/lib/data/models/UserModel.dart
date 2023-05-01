class UserModel {
  int? id;
  String? Name;
  String? Password;
  String? Email;

  UserModel({this.id, this.Name,this.Password,this.Email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Name = json['Name'];
    Password = json['Password'];
    Email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = Name;
    data['Password'] = Password;
    data['Email'] = Email;
    return data;
  }
}
class NewUser {
  int? id;
  String? Name;
  String? Password;
  String? Email;

  NewUser({this.Name, this.id, this.Password, this.Email});

  NewUser.fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    Password = json['Password'];
    id = json['id'];
    Email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = Name;
    data['Password'] = Password;
    data['id'] = id;
    data['Email'] = Email;
    return data;
  }
}
