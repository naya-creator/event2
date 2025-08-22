

class HallsModel {
  final int HallId;
  final String namear;
  final String nameEn;
  final String locationAr;
  final String locationEn;
  final int capacity;
  final String price;
  final String? imageUrl1;



  factory HallsModel.fromJson(Map<String, dynamic> jsonData) {
    return HallsModel(jsonData['id'],jsonData['name_ar'], jsonData['name_en'], jsonData['location_ar'], jsonData['location_en'], jsonData['capacity'], jsonData['price'], jsonData['image_url']['image_1']);
  }

  HallsModel(this.HallId,this.namear, this.nameEn, this.locationAr, this.locationEn, this.capacity, this.price, this.imageUrl1);

  /// لتحويل قائمة من البيانات
  static List<HallsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HallsModel.fromJson(json)).toList();
  }
}
