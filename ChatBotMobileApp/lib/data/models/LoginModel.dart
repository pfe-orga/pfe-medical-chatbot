class LoginModel {
  int? id;
  String? Email;
  String? Password;
  String? Provider;

  LoginModel({this.id, this.Email,this.Password,this.Provider});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Email = json['Email'];
    Password = json['Password'];
    Provider = json['Provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Email'] = Email;
    data['Password'] = Password;
    data['Provider'] = Provider;
    return data;
  }
}