class WeatherModel {
  int? id;
  DateTime? date;
  DateTime? currentDate;
  DateTime? newDate;

  WeatherModel({this.id, this.date,this.currentDate,this.newDate});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['CurrentDate'];
    newDate = json['NewDate'];
    currentDate = json['CurrentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['CurrentDate'] = currentDate;
    data['NewDate'] = newDate;
    data['Date'] = date;

    return data;
  }
}

