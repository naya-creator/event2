class HalldetailsModel {

  final int idHall;
  final String nameAr;
  final String nameEn;
  final String locationAr;
  final String locationEn;
  final int capacity;
  final  String price;
  final String imageurl1;
  final String imageurl2;
  final String imageurl3;
  final String imageurl4;
  final String imageurl5;
  final String imageurl6;

  HalldetailsModel(this.idHall, this.nameAr, this.nameEn, this.locationAr, this.locationEn, this.capacity, this.price, this.imageurl1, this.imageurl2, this.imageurl3, this.imageurl4, this.imageurl5, this.imageurl6);

factory HalldetailsModel.fromJson(Map<String,dynamic> data){

  return HalldetailsModel(data['id'], data['name_ar'], data['name_en'], data['location_ar'], data['location_en'], data['capacity'], data['price'], data['image_url']['image_1'], data['image_url']['image_2'], data['image_url']['image_3'],data['image_4'],data['image_5'],data['image_6']);
}



}


class HalldetailsServices {
  final int serviceId;
  final String nameAr;
  final String nameEn;

  HalldetailsServices(this.serviceId, this.nameAr, this.nameEn);

  factory HalldetailsServices.fromJson(Map<String,dynamic>data){
    return HalldetailsServices(data['id'], data['name_ar'], data['name_en']);
  }


}
class ResrveHall_Model{
  final String message;
  final int reservationId;

  ResrveHall_Model(this.message, this.reservationId);

  factory ResrveHall_Model.fromJson(Map <String,dynamic>data){
    return ResrveHall_Model(data['message'], data['reservation_id']);
  }






}