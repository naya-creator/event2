class FoodDetailsModel{

final int foodDetailsId;
final String nameAR;
final String nameEn;
final String Price;

  FoodDetailsModel(this.foodDetailsId, this.nameAR, this.nameEn, this.Price);



factory FoodDetailsModel.fromJson(Map<String,dynamic>data){
  return FoodDetailsModel(data['id'], data['name_ar'], data['name_en'], data['price']);
}


}



class addFoodToReseve{

  final String message;

  addFoodToReseve(this.message);

  factory addFoodToReseve.fromJson(Map<String,dynamic>data){
    return addFoodToReseve(data['message']);
  }


}