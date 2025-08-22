class FoodType_model{

 final int foodvariants;
 final String nameAr;
 final String nameEn;
 final String image;

  FoodType_model(this.foodvariants, this.nameAr, this.nameEn, this.image);


  factory FoodType_model.fromJson(Map<String,dynamic>data){
    return FoodType_model(data['id'], data['name_ar'], data['name_en'],data['image_url']);
  }



}