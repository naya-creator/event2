
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/Api/api_consumer.dart';
import 'package:untitled2/Api/endpoint.dart';
import 'package:untitled2/Api/exception.dart';
import 'package:untitled2/cubit/halls_state.dart';
import 'package:untitled2/models/halls_model.dart';

class UserCubit2 extends Cubit<UserState> {
  UserCubit2(this.api) : super(UserInitial());
  final ApiConsumer api;
  TextEditingController logInemail = TextEditingController();
  TextEditingController logInPassword = TextEditingController();
  XFile? profilePic;
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController CongirmPassword = TextEditingController();

  static UserCubit2 get(context)=>BlocProvider.of(context);
  getHalls(int i) async {
    try {
      emit(GetHallsLoading());

      final response = await api.get(
        Endpoint.getHallsDataEndPoint(i),
      );

      // تأكد أن response['halls'] هي قائمة
      final List<HallsModel> hallsList =
      HallsModel.fromJsonList(response['halls']);
      print(hallsList[1].imageUrl1);
      emit(GetHallsSuccess(halls: hallsList));
    } on serverException catch (e) {
      emit(GetHallsFaliure(message: e.errorModel.errorMessage));
    }
  }



}
