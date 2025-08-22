class DecorationTypeModel{

  final int TypeId;
  final String nameAr;
  final String nameEn;

  DecorationTypeModel(this.TypeId, this.nameAr, this.nameEn);

  factory DecorationTypeModel.fromJson(Map<String,dynamic>data){
    return DecorationTypeModel(data['id'], data['name_ar'], data['name_en']);
  }




}