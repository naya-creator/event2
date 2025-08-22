import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/foodcategories_model.dart';
import 'foodcategories_state.dart';


class FoodCategories_cubit extends Cubit<FoodCategories_status>{

static FoodCategories_cubit get(context)=>BlocProvider.of(context);

 FoodCategories_cubit(this.api):super(Initial_FoodCateoeries()) ;

 final ApiConsumer api;

 static List<FoodCategories> _foodCategories=[];

 List<FoodCategories> get foodCategories  => _foodCategories;
 Future<List<FoodCategories>?>  getFoodCategories(int id)async{
   try {
     emit(start_FoodCateoeries());
     final response = await api.get(
       Endpoint.get_FoodCategories(id),
     );
     List <dynamic> data= await response['categories'];

     _foodCategories=data.map((item)=>FoodCategories.fromJson(item)).toList();


     emit(finish_FoodCateoeries());
     return foodCategories;
   }on serverException catch(e){

     emit(error_FoodCateoeries(e.errorModel.errorMessage));
     return null;
   }
 }



}