
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Api/exception.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../models/getfavorite_model.dart';
import 'favorite_state.dart';


class favorite_cubit extends  Cubit<Favorite_Status>{
  favorite_cubit (this.api):super (intial_getfav());

  static favorite_cubit get(context)=>BlocProvider.of(context);

  final ApiConsumer api;



  static List<GetFavoritModel> _allFav=[];

  List<GetFavoritModel> get allFav  => _allFav;
  Future<List<GetFavoritModel>?>  getAllFavorites()async{
    try {
      emit(start_getfav());
      final response = await api.get(
        Endpoint.post_deletefav,
      );
      List <dynamic> data= await response['favorites'];

      _allFav=data.map((item)=>GetFavoritModel.fromJson(item)).toList();

      emit(finish_getfav());
      return allFav;
    }on serverException catch(e){

      emit(error_getfav(e.errorModel.errorMessage));
      return null;
    }
  }




}