class GetTimesModel{

  final int Id;
  final int HallId;
  final String Day;
  final String StratTime;
  final String EndTime;
  final int Isavailable;

  GetTimesModel(this.Id, this.HallId, this.Day, this.StratTime, this.EndTime, this.Isavailable);

factory GetTimesModel.fromJson(Map<String,dynamic>data){
  return GetTimesModel(data['id'], data['hall_id'], data['day_of_week'], data['start_time'], data['end_time'], data['is_available']);
}






}