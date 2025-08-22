import 'dart:convert';
import 'package:flutter/material.dart'; // تمت إضافة هذه المكتبة للوصول إلى TimeOfDay و DateTime
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../cache/cache_helper.dart';
import '../models/gettimes_model.dart';
import '../models/halldetails_model.dart';
import 'halldetails_state.dart';


class HalldetailsCubit extends Cubit<HalldetailsStatus>{
  HalldetailsCubit(this.api):super(inital_Halldetails()){
    _loadFavoriteStatus();
  }

  static HalldetailsCubit get(context)=>BlocProvider.of(context);

  final ApiConsumer api;

  String? selectedTime;
  List<String> availableTimes = [];

  // --- بداية التغييرات الجديدة ---
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void selectDate(DateTime newDate) {
    selectedDate = newDate;
    emit(date_selected_success());
  }

  void selectStartTime(TimeOfDay newTime) {
    startTime = newTime;
    emit(date_selected_success());
  }

  void selectEndTime(TimeOfDay newTime) {
    endTime = newTime;
    emit(time_selected_success());
  }
  // --- نهاية التغييرات الجديدة ---


  void selectTime(String time) {
    selectedTime = time;
    emit(time_selected_success());
  }

  List<bool> stars = List.generate(5, (index) => false);
  int stars_count =0;

  void addStars(int index){
    stars_count=0;
    for(int i =0;i<stars.length;i++) {

      if (i <= index) {
        stars[i] = true;
        stars_count++;
      }
      else {
        stars[i] = false;
      }
    }
    print(stars_count);
    emit(Add_Star());
  }

  static HalldetailsModel ? _hallDetails;

  HalldetailsModel? get hallDetails => _hallDetails;

  Future<HalldetailsModel?>  getHallDetails(int hallId)async{
    try {
      emit(start_HallDetails_class());
      final response = await api.get(
        Endpoint.get_HallDetails(hallId),
      );
      Map<String,dynamic> data= await response['hall']  ;

      _hallDetails=HalldetailsModel.fromJson(data) ;
      print(hallDetails);

      emit(finish_HallDetails_class());
      return hallDetails;
    }on serverException catch(e){

      emit(error_HallDetails_class(e.errorModel.errorMessage));
      return null;
    }
  }

  static List<HalldetailsServices> _allservices=[];

  List<HalldetailsServices> get allservices  => _allservices;
  Future<List<HalldetailsServices>?>  getAllServices(int id)async{
    try {
      emit(start_HallDetailsServices_class());
      final response = await api.get(
        Endpoint.get_HallServices(id),
      );
      List <dynamic> data= await response['services'];

      _allservices=data.map((item)=>HalldetailsServices.fromJson(item)).toList();


      emit(finish_HallDetailsServices_class());
      return allservices;
    }on serverException catch(e){

      emit(error_HallDetailsServices_class(e.errorModel.errorMessage));
      return null;
    }
  }

///// add to favorite
  Map<int, bool> _favoriteStatus = {};

  bool isFavorite(int hallId) => _favoriteStatus[hallId] ?? false;

  Future<void> _loadFavoriteStatus() async {
    try {
      final String? favsJson = CacheHelper.getData(key: 'favoriteHall');
      if (favsJson != null) {
        final Map<String, dynamic> decodedMap = json.decode(favsJson);
        _favoriteStatus = decodedMap.map((key, value) => MapEntry(int.parse(key), value as bool));
      }
    } catch (e) {
      print('Error loading favorite status: $e');
    }
  }

  // دالة لحفظ حالة المفضلة في التخزين المحلي
  Future<void> _saveFavoriteStatus() async {
    try {
      // تحويل Map<int, bool> إلى Map<String, bool> للحفظ في SharedPreferences
      final Map<String, bool> stringKeyMap = _favoriteStatus.map((key, value) => MapEntry(key.toString(), value));
      final String favsJson = json.encode(stringKeyMap);
      await CacheHelper().put(key: 'favoriteHall', value: favsJson);
    } catch (e) {
      print('Error saving favorite status: $e');
    }
  }

  Future<bool>  PostAddFav(String name, int id)async{
    try {
      emit(start_AddFavorit_Status());
      final response = await api.post(
          Endpoint.post_addfav,
          data:    {
            'favoritable_type':name,
            'favoritable_id':id
          }
      );
      _favoriteStatus[id] = true; //
      await _saveFavoriteStatus();
      CacheHelper.putBool(key: 'addfav$id', value: true);
      print(response);
      emit(finish_AddFavorit_Status());
      return true;
    }on serverException catch(e){

      emit(error_AddFavorit_Status(e.errorModel.errorMessage));
      return false;
    }
  }


  Future<bool>  PostDeleteFav(String name, int id)async{
    try {
      emit(start_DeleteFavorit_Status());
      final response = await api.delete(
          Endpoint.post_deletefav,
          data:    {
            'favoritable_type':name,
            'favoritable_id':id
          }
      );
      _favoriteStatus[id] = false; //
      await _saveFavoriteStatus();
      CacheHelper.putBool(key: 'addfav', value: false);
      print(response);
      emit(finish_DeleteFavorit_Status());
      return true;
    }on serverException catch(e){

      emit(error_DeleteFavorit_Status(e.errorModel.errorMessage));
      return false;
    }
  }

  static List<GetTimesModel> _allTimes=[];

  List<GetTimesModel> get allTimes  => _allTimes;

  Future<bool>  getavailabletimes( int id)async{
    try {
      emit(start_gettimes_Status());
      final response = await api.get(
        Endpoint.get_availabletimes(id),
      );
      List <dynamic> data= await response['data'];

      _allTimes = data.map((item) => GetTimesModel.fromJson(item)).toList();
      // هنا نقوم بتحويل البيانات إلى تنسيق مناسب للعرض
      availableTimes = _allTimes.map((time) {
        String startTime = time.StratTime.substring(0, 5) ?? 'N/A';
        String endTime = time.EndTime.substring(0, 5) ?? 'N/A';
        return '${time.Day ?? 'N/A'}: $startTime - $endTime';
      }).toList();

      emit(finish_gettimes_Status());
      return true;
    }on serverException catch(e){

      emit(error_gettimes_Status(e.errorModel.errorMessage));
      return false;
    }
  }
   Map<String,dynamic> ?data2;
  static ResrveHall_Model?  _reserv;
   static String erroermassege ='m';
   String get  ErrorMassege=>erroermassege;
  ResrveHall_Model ? get reserv  => _reserv;
  Future<bool> PostReserveHall(int Hallid, String ResevDate, String StartTime, String EndTime,String homeadrees)async{
    try {
      emit(start_ReserveHallStatus());
      final response = await api.post(
          Endpoint.post_reservehall,
          data: {
            'hall_id': "$Hallid",
            'reservation_date': ResevDate,
            'start_time': StartTime,
            'end_time': EndTime,
            'home_address':homeadrees ,

          }
      );
      Map<String,dynamic> data= await response;

      _reserv=ResrveHall_Model.fromJson(data);

      emit(finish_ReserveHallStatus());
      return true;
    }on serverException catch(e){
          erroermassege=e.errorModel.errorMessage;

          emit(error_ReserveHallStatus(e.errorModel.errorMessage));
      return false;
    }
  }
}

