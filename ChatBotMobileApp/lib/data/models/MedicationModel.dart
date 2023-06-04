import 'dart:io';
class MedicationModel {

  String? medicine_name;
  String? price;
  String? date;
  String? error;
  File? image;



  MedicationModel({this.medicine_name, this.price, this.date, this.error, this.image});
  MedicationModel.fromJson(Map<String, dynamic> json){
    medicine_name = json['medicine_name'];
    price = json['price'];
    date = json['date'];
    error = json['error'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicine_name'] = medicine_name;
    data['price'] = price;
    data['date'] = date;
    data['error'] = error;
    data['image'] = image;
    return data;
  }
}