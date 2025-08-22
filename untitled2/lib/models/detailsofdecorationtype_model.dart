class DecorationTypeOfType_model{

  final int iddecoationtype;
  final String nameAr;
  final String nameEn;
  final String color;
  final String price;
  final String Image;

  DecorationTypeOfType_model(this.iddecoationtype, this.nameAr, this.nameEn, this.color, this.price, this.Image);


  factory DecorationTypeOfType_model.fromJson(Map<String,dynamic>data){
    return DecorationTypeOfType_model(data['id'], data['name_ar'], data['name_en'], data['color'], data['price'],data['image']);
  }





}

class addDecoreToReseve{
  
  final String message;

  addDecoreToReseve(this.message);
  
  factory addDecoreToReseve.fromJson(Map<String,dynamic>data){
    return addDecoreToReseve(data['message']);
  }
  
  
}