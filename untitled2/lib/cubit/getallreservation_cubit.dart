import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/getallreservation_model.dart';
import 'getallreservation_state.dart';


class GetallreservationCubit extends Cubit<GetallreservationStatus> {
  GetallreservationCubit(this.api) : super(intial_GetallreservationStatus());

  static GetallreservationCubit get(context) => BlocProvider.of(context);

  final ApiConsumer api;

  static List<GetallreservationModel> _allReservations = [];

  List<GetallreservationModel> get allReservation => _allReservations;

  Future<bool> getAllReservation() async {
    try {
      emit(start_GetallreservationStatus());
      final response = await api.get(
        Endpoint.getall_reservation,
      );
      List<dynamic> data = await response['reservations'];

      _allReservations = data.map((item) => GetallreservationModel.fromJson(item)).toList();

      emit(finish_GetallreservationStatus());
      return true;
    } on serverException catch (e) {
      emit(error_GetallreservationStatus(e.errorModel.errorMessage));
      return false;
    }
  }

  static String _massege = '';
  String get massege => _massege;

  Future<bool> deleteReservation(int id) async {
    try {
      emit(start_DeletereservationStatus());

      // Call the API to delete the reservation
      await api.delete(
        Endpoint.DeleteandputReservation(id),
      );

      // Remove the deleted reservation from the local list
      _allReservations.removeWhere((res) => res.reservId == id);


      emit(finish_DeletereservationStatus());

      // Re-emit the finished state for the reservations list

      emit(finish_GetallreservationStatus());

      return true;
    } on serverException catch (e) {
      _massege = e.errorModel.errorMessage;
      emit(error_DeletereservationStatus(e.errorModel.errorMessage));
      return false;
    }
  }

  Future<bool> updateReservation(int id) async {
    try {
      emit(start_DeletereservationStatus());
      final response = await api.put(
          Endpoint.DeleteandputReservation(id),
          data: {
            'services': ''
          }
      );

      emit(finish_DeletereservationStatus());
      return true;
    } on serverException catch (e) {
      _massege = e.errorModel.errorMessage;
      emit(error_DeletereservationStatus(e.errorModel.errorMessage));
      return false;
    }
  }
}