class FoodCategories {

 final int idCategoriesFood;
 final String nameAr;
 final String nameEn;
 final String image;

  FoodCategories(this.idCategoriesFood, this.nameAr, this.nameEn, this.image);


  factory FoodCategories.fromJson(Map<String,dynamic>data){
    return FoodCategories(data['id'], data['name_ar'], data['name_en'],data['image_1']);

  }






}