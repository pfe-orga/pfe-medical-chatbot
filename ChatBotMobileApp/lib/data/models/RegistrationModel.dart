class RegistrationModel {
  int? id;
  String? Email;
  String? Password;
  String? Provider;
  String? Name;
  String? Role;

  RegistrationModel({this.id, this.Email, this.Password, this.Name, this.Provider, this.Role});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Name = json ['Name'];
    Email = json['Email'];
    Password = json['Password'];
    Provider = json['Provider'];
    Role = json['Role'];
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] =  Name;
    data['Email'] = Email;
    data['Password'] = Password;
    data['Provider'] = Provider;
    data['Role'] = Role;

    return data;
  }
}