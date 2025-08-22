import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'stars_state.dart';

class Stars_Cubit extends Cubit<Stars_Status>{
  Stars_Cubit():super(init_Stars());

  static Stars_Cubit get(context)=>BlocProvider.of(context);

  List<bool> stars=[
    false,
    false,
    false,
    false,
    false
  ];
  int stars_count =0;

  void increaseCount (){
    stars_count++;
  }

  void addStars(int index){
    for(int i =0;i<=index;i++){
   stars[i]=!stars[i];
    }
   emit(Add_Star());
  }

}