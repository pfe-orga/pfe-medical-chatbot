class MedicationModel {

  String? medicine_name;
  String? price;
  String? date;
  String? error;



  MedicationModel({this.medicine_name, this.price, this.date, this.error});
  MedicationModel.fromJson(Map<String, dynamic> json){
    medicine_name = json['medicine_name'];
    price = json['price'];
    date = json['date'];
    error = json['error'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicine_name'] = medicine_name;
    data['price'] = price;
    data['date'] = date;
    data['error'] = error;
    return data;
  }
}