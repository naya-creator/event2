import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/getreservation_model.dart';
import 'getreservation_state.dart';



class GetReservationCubit extends Cubit<GetReservationSatuts> {
  GetReservationCubit(this.api) : super(intial_GetReservationSatuts());

  static GetReservationCubit get(context) => BlocProvider.of(context);

  static GetReservationModel? _getreserv;

  final ApiConsumer api;

  GetReservationModel? get getreserv => _getreserv;

  Future<bool> getReserv() async {
    try {
      emit(start_GetReservationSatuts());
      final response = await api.get(Endpoint.get_current_reservation);
      Map<String, dynamic> data = await response['summary'];

      _getreserv = GetReservationModel.fromJson(data);

      emit(finish_GetReservationSatuts());
      return true;
    } on serverException catch (e) {
      emit(error_GetReservationSatuts(e.errorModel.errorMessage));
      // Log the error message to help with debugging
      print('API Error: ${e.errorModel.errorMessage}');
      _getreserv = null; // Ensure the local model is reset on error
      return false;
    }
  }
  static String erroermassege ='m';
  String get  ErrorMassege=>erroermassege;
  Future<bool> confirmReserv(int id) async {
    try {
      emit(start_GetReservationSatuts());
      final response = await api.post(
        Endpoint.confirm_reservation,
        data: {'reservation_id': '$id'},
      );

      // Reset the local model after successful confirmation
      _getreserv = null;

      emit(finish_GetReservationSatuts());
      return true;
    } on serverException catch (e) {
      emit(error_GetReservationSatuts(e.errorModel.errorMessage));
      erroermassege=e.errorModel.errorMessage;
      print('API Error: ${e.errorModel.errorMessage}');
      return false;
    }
  }
}
