class ReserveHallModel {
  final String ReservationStatus;
  final String ReservationMsssege;
  final String ReservationError;





   factory ReserveHallModel.fromJson(Map<String, dynamic>data){

    return ReserveHallModel(data['status'], data['message'],data['errors']['end_time']);

  }

  ReserveHallModel(this.ReservationStatus, this.ReservationMsssege, this.ReservationError);








}