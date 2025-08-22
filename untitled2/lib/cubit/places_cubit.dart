import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/places_model.dart';
import 'places_state.dart';


class PlacesCubit extends Cubit<Places_Status>{
  PlacesCubit(this.api):super(initial_places());

  static PlacesCubit get(context)=>BlocProvider.of(context);

  final ApiConsumer api;

  static List<PlacesModel> _allPlaces=[];

  List<PlacesModel> get allPlaces => _allPlaces;
  Future<List<PlacesModel>?>  getAllPlaces()async{
    try {
      emit(start_places_class());
      final response = await api.get(
        Endpoint.get_all_places,
      );
      List <dynamic> data= await response['data'];

      _allPlaces=data.map((item)=>PlacesModel.fromJson(item)).toList();
      print(allPlaces[0]);
      emit(finish_places_class());
      return allPlaces;
    }on serverException catch(e){
      emit(error_places_class(e.errorModel.errorMessage));
      return null;
    }
  }


}
