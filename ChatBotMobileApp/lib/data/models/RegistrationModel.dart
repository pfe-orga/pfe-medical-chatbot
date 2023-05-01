class RegistrationModel {
  int? id;
  String? Email;
  String? Password;
  String? Provider;
  String? Name;


  RegistrationModel({this.id, this.Email,this.Password,this.Name,this.Provider});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Name = json ['Name'];
    Email = json['Email'];
    Password = json['Password'];
    Provider = json['Provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] =  Name;
    data['Email'] = Email;
    data['Password'] = Password;
    data['Provider'] = Provider;
    return data;
  }
}