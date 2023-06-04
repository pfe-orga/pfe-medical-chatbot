class MedicineInfo {
  String medicineName;
  String price;
  String date;
  String fileImage;

  MedicineInfo({
    required this.medicineName,
    required this.price,
    required this.date,
    required this.fileImage,
  });

  factory MedicineInfo.fromJson(Map<String, dynamic> json) {
    return MedicineInfo(
      medicineName: json['medicine_name'],
      price: json['price'],
      date: json['date'],
      fileImage: json['file_image'],
    );
  }
}
class MedicineInfoResponse {
  List<MedicineInfo> matchingMedicines;
  String? error;

  MedicineInfoResponse({
    required this.matchingMedicines,
    this.error,
  });

  factory MedicineInfoResponse.fromJson(Map<String, dynamic> json) {
    return MedicineInfoResponse(
      matchingMedicines: List<MedicineInfo>.from(
        json['matching_medicines'].map(
              (item) => MedicineInfo.fromJson(item),
        ),
      ),
      error: json['error'],
    );
  }
}
