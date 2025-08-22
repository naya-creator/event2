import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/foodtypeofcategories_model.dart';
import 'foodtype_state.dart';


class FoodType_Cubit extends Cubit<FoodType_status>{

  FoodType_Cubit(this.api):super(intial_FoodType_Status());

  static FoodType_Cubit get(context)=>BlocProvider.of(context);

  final ApiConsumer api;

  static List<FoodType_model> _allFoodTypes=[];

  List<FoodType_model> get allFoodTypes  => _allFoodTypes;
  Future<List<FoodType_model>?>  getAllFoodTypes(int idType)async{
    try {
      emit(start_FoodType_Status());
      final response = await api.get(
        Endpoint.get_FoodTypes(idType),
      );
      List <dynamic> data= await response['variants'];

      _allFoodTypes=data.map((item)=>FoodType_model.fromJson(item)).toList();

      emit(finish_FoodType_Status());
      return allFoodTypes;
    }on serverException catch(e){

      emit(error_FoodType_Status(e.errorModel.errorMessage));
      return null;
    }
  }




}