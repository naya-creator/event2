



import '../Api/endpoint.dart';

class TaskModel {
  final String assignment_id;
  final String service;
  final String coordinator;
  final String statuss;

  TaskModel(
      {required this.assignment_id,
        required this.service,
        required this.coordinator,
        required this.statuss});
  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      assignment_id: jsonData[ApiKey.assignment_id].toString(),
      service: jsonData[ApiKey.service] ?? '',
      coordinator: jsonData[ApiKey.coordinator] ?? '',
      statuss: jsonData[ApiKey.statuss] ?? '',
    );
  }

  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskModel.fromJson(json)).toList();
  }
}
