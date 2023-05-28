class ListModel {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;


  ListModel({this.id, this.email,this.password,this.name});

  ListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json ['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] =  name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
