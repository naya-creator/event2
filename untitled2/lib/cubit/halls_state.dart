



import '../models/halls_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}


class GetHallsLoading extends UserState {}

class GetHallsSuccess extends UserState {
  final List<HallsModel> halls;
  GetHallsSuccess({required this.halls});
}

class GetHallsFaliure extends UserState {
  final String message;
  GetHallsFaliure({required this.message});
}
