class PlacesModel {
  final int idPlaces;
  final String nameAr;
  final String nameEn;

  PlacesModel(this.idPlaces, this.nameAr, this.nameEn);


  factory PlacesModel.fromJson(Map<String,dynamic>data){
    return PlacesModel( data['id'], data['name_ar'], data['name_en']);
  }

}

