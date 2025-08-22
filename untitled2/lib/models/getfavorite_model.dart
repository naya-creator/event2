class GetFavoritModel{

final int Id;
final String Type;
final String NameAr;
final String NameEn;
final String LocationAr;
final String LocationEn;
final int Capacity;
final String Price;
final String Imageurl;

  GetFavoritModel(this.Id, this.Type, this.NameAr, this.NameEn, this.LocationAr, this.LocationEn, this.Capacity, this.Price, this.Imageurl);



factory GetFavoritModel.fromJson(Map<String,dynamic>data ){

  return GetFavoritModel(data['id'], data['type'], data['details']['name_ar'], data['details']['name_en'], data['details']['location_ar'], data['details']['location_en'], data['details']['capacity'], data['details']['price'], data['details']['image_url']['image_1']);


}












}