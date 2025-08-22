import 'package:flutter_bloc/flutter_bloc.dart';

import 'hallowner2_state.dart';


class Hallowner2_cubit extends Cubit<Hallowner2_status>{
  Hallowner2_cubit( ): super(initial_status());

  static Hallowner2_cubit get(context)=>BlocProvider.of(context);

  List<String> decor=
  [
    'Ahmad ahmad',
    'Naya amin',
    'Hassan hassan',
    'Retag munjed'
  ];
  List<String> food=
  [
    'Sami ahmad',
    'Karim amin',
    'jude hassan',
    ' fadi mohamad'
  ];
  List<String> camera=
  [
    'lama ahmad',
    'Nay amin',
    'Masa hassan',
    'Rand hidar'
  ];
  List<String> music=
  [
    'karam ahmad',
    'may amin',
    'Malk hassan',
    'tala hidar'
  ];
List<String>test=[];
  List<bool> iscolor=[
    true,
    false,
    false,
    false
  ];

    changeListAndColor(int index){
       for( int i=0 ;i<iscolor.length;i++ ){
         iscolor[i]=false;
       }
    if(index==0)   {
      iscolor[index]=true;
      emit(changeis_Done());
      test=decor;
      return test;
      }
   else if(index==1){
      iscolor[index]=true;
      emit(changeis_Done());
      test=food;
      return test;
    }
   else if (index==2){
      iscolor[index]=true;
      emit(changeis_Done());
       test=camera;
      return test;
    }
    else if (index==3){
      iscolor[index]=true;
      emit(changeis_Done());
       test=music;
      return test;
    }
  }
}