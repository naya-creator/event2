abstract class GetallreservationStatus{}

class intial_GetallreservationStatus extends GetallreservationStatus{}

class start_GetallreservationStatus extends GetallreservationStatus{}

class finish_GetallreservationStatus extends GetallreservationStatus{}

class error_GetallreservationStatus extends GetallreservationStatus{
  final String error;
  error_GetallreservationStatus(this.error);

}

class start_DeletereservationStatus extends GetallreservationStatus{}

class finish_DeletereservationStatus extends GetallreservationStatus{}

class error_DeletereservationStatus extends GetallreservationStatus{
  final String error;
  error_DeletereservationStatus(this.error);

}
