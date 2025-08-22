import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/detailsofdecorationtype_model.dart';
import 'detailsofdecorationtype_state.dart';


class DetailsOfDecorationType_cubit extends Cubit<DetailsOfDecorationType_status>{

  DetailsOfDecorationType_cubit (this.api):super(intial_DetailsOfDecorationType_status());
static DetailsOfDecorationType_cubit get(context)=>BlocProvider.of(context);
  final ApiConsumer api;


  static List<DecorationTypeOfType_model> _alldetailsofdecoartion=[];

  List<DecorationTypeOfType_model> get alldetailsofdecoartion  => _alldetailsofdecoartion;
  Future<List<DecorationTypeOfType_model>?>  getAllDetailsofdecorationtypes(int id)async{
    try {
      emit(start_DetailsOfDecorationType_status());
      final response = await api.get(
       Endpoint.get_detailsofdecorationtypes(id),
      );
      List <dynamic> data= await response['flowers'];

      _alldetailsofdecoartion=data.map((item)=>DecorationTypeOfType_model.fromJson(item)).toList();

      emit(finish_DetailsOfDecorationType_status());
      return alldetailsofdecoartion;
    }on serverException catch(e){

      emit(error_DetailsOfDecorationType_status(e.errorModel.errorMessage));
      return null;
    }
  }

     static String _errormessage="";
     String get errormessage =>_errormessage;

  static addDecoreToReseve  ?_message;
  addDecoreToReseve ? get message =>_message;

  Future<bool>  AddDecoretoReseve(int resid,int decoreId,String location,String Color,int quantity,double price )async{
    try {
      emit(start_adddecoretoReserve_status());
      final response = await api.post(
        Endpoint.adddecorereservation,
        data: {
          "reservation_id": resid,
          "flower_id": decoreId,
          "location": location,
          "color": Color,
          "quantity": quantity,
          "unit_price": price
        }
      );

       Map<String,dynamic> data=await response;
      _message=addDecoreToReseve.fromJson(data);

      emit(finish_adddecoretoReserve_status());
      return true;
    }on serverException catch(e){
      _errormessage=e.errorModel.errorMessage;
      emit(error_adddecoretoReserve_status(e.errorModel.errorMessage));
      return false;
    }
  }







}