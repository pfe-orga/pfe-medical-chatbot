class UserModel {
  int? id;
  String? Name;
  String? Password;
  String? Email;
  String? Role;
  String? UserName;

  UserModel({this.id, this.Name,this.Password,this.Email, this.Role, this.UserName});

  @override
  String toString() {
    return 'UserModel{id: $id, Name: $Name, Password: $Password, Email: $Email, Role: $Role, UserName: $UserName}';
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Name = json['name'];
    Password = json['password'];
    Email = json['email'];
    Role = json['role'];
    UserName = json['userName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = Name;
    data['Password'] = Password;
    data['Email'] = Email;
    data['Role'] = Role;
    data['UserName'] = UserName;



    return data;
  }
}
class NewUser {
  int? id;
  String? Name;
  String? Password;
  String? Email;
  String? Role;
  String? UserName;

  NewUser({this.Name, this.id, this.Password, this.Email, this.Role, this.UserName});

  NewUser.fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    Password = json['Password'];
    id = json['id'];
    Email = json['Email'];
    Role = json['Role'];
    UserName = json['UserName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = Name;
    data['Password'] = Password;
    data['id'] = id;
    data['Email'] = Email;
    data['Role'] = Role;
    data['UserName'] = UserName;


    return data;
  }
}
