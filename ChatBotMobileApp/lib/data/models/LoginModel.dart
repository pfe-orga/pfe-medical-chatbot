class LoginModel {
  int? id;
  String? Username;
  String? Password;
  String? Provider;

  LoginModel({this.id, this.Username,this.Password,this.Provider});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Username = json['Username'];
    Password = json['Password'];
    Provider = json['Provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Username'] = Username;
    data['Password'] = Password;
    data['Provider'] = Provider;
    return data;
  }
}