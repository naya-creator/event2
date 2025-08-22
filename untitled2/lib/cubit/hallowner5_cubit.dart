import 'package:flutter_bloc/flutter_bloc.dart';

import 'hallowner5_state.dart';

class Hallowner5_cubit extends Cubit<Hallowner5_status> {
  Hallowner5_cubit() : super(initil_hallowner5());

  static Hallowner5_cubit get(context)=> BlocProvider.of(context);
   List<String>nameofIcons= [
     'Working on',
     'Done'
   ];
  List<bool> iscolor=[
    true,
    false,
  ];

  changeListAndColor(int index){
    for( int i=0 ;i<iscolor.length;i++ ){
      iscolor[i]=false;
    }
    iscolor[index]=true;
    emit(change_happened());

  }


}