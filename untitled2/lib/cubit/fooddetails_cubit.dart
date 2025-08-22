import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/fooddetails_model.dart';
import 'fooddetails_state.dart';


class FoodDetails_Cubit extends Cubit<FoodDetails_Status>{

 FoodDetails_Cubit(this.api):super(intial_FoodDetails_Status());

 static FoodDetails_Cubit get(context)=>BlocProvider.of(context);

 final ApiConsumer api;

 static List<FoodDetailsModel> _allFoodDetails=[];

 List<FoodDetailsModel> get allFoodDetails => _allFoodDetails;
 Future<List<FoodDetailsModel>?>  getAllFoodDetails(int foodId)async{
  try {
   emit(start_FoodDetails_Status());
   final response = await api.get(
    Endpoint.get_Fooddetails(foodId),
   );
   List <dynamic> data= await response['types'];

   _allFoodDetails=data.map((item)=>FoodDetailsModel.fromJson(item)).toList();

   emit(finish_FoodDetails_Status());
   return allFoodDetails;
  }on serverException catch(e){

   emit(error_FoodDetails_Status(e.errorModel.errorMessage));
   return null;
  }
 }

 static String _errormessage="";
 String get errormessage =>_errormessage;

 static addFoodToReseve  ?_message;
 addFoodToReseve ? get message =>_message;

 Future<bool>  AddFoodtoReseve(int resid,int serviceId,int quantity )async{
  try {
   emit(start_AddtoResve_Status());
   final response = await api.post(
       Endpoint.addfoodreservation,
       data: {
        "reservation_id": resid,
        'items':[ {
         'service_type_id':serviceId,
         'quantity': quantity,

        } ],
       }
   );

   Map<String,dynamic> data=await response;
   _message=addFoodToReseve.fromJson(data);

   emit(finish_AddtoResve_Status());
   return true;
  }on serverException catch(e){
   _errormessage=e.errorModel.errorMessage;
   emit(error_AddtoResve_Status(e.errorModel.errorMessage));
   return false;
  }
 }







}