import 'dart:convert';

class MedicamentModel {

  String? medicine_name;
  String? price;
  String? date;
  String? error;


  MedicamentModel({this.medicine_name, this.price, this.date, this.error});
  MedicamentModel.fromJson(Map<String, dynamic> json){
    medicine_name = json['medicine_name'];
    price = json['price'];
    date = json['date'];
    error = json['error'];
  }
  String toJson() {
    final Map<String, String> data = <String, String>{};
    data['medicine_name'] = medicine_name!;
    data['price'] = price!;
    data['date'] = date!;
    data['error'] = error!;
    final String jsonData = jsonEncode(data);
    return jsonData;
  }
}