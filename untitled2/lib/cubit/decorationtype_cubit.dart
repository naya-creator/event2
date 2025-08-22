import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/decoartiontype_model.dart';
import 'decorationtype_state.dart';


class DecorationType_cubit extends Cubit<DecorationType_status>{
  DecorationType_cubit(this.api) : super(intial_DecorationType_status());

  static DecorationType_cubit get(context)=>BlocProvider.of(context);

  final ApiConsumer api;

  //DecorationTypeModel


  static List<DecorationTypeModel> _allDecorationType=[];

  List<DecorationTypeModel> get allDecorationType  => _allDecorationType;
  Future<List<DecorationTypeModel>?>  getAllDecorationTypes(int Servceid)async{
    try {
      emit(start_DecorationType_status());
      final response = await api.get(
        Endpoint.get_decorationtypes(Servceid),
      );
      List <dynamic> data= await response['decoration_types'];

      _allDecorationType=data.map((item)=>DecorationTypeModel.fromJson(item)).toList();

      emit(finish_DecorationType_status());
      return allDecorationType;
    }on serverException catch(e){

      emit(error_DecorationType_status(e.errorModel.errorMessage));
      return null;
    }
  }







}