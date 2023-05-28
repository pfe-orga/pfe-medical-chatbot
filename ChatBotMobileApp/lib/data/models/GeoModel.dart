class GeoModel {
  int? id;
  String? names;
  String? place;
  String? numero;


  GeoModel({this.id, this.names,this.place,this.numero});

  GeoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    names = json ['names'];
    place = json['place'];
    numero = json['numero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['names'] =  names;
    data['place'] = place;
    data['numero'] = numero;
    return data;
  }
}
