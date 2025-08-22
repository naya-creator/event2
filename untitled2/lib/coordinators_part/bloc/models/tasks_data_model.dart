// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PendingTasksDataModel welcomeFromJson(String str) =>
    PendingTasksDataModel.fromJson(json.decode(str));

String welcomeToJson(PendingTasksDataModel data) => json.encode(data.toJson());

class PendingTasksDataModel {
  bool status;
  String message;
  List<PendingData> data;

  PendingTasksDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PendingTasksDataModel.fromJson(Map<String, dynamic> json) =>
      PendingTasksDataModel(
        status: json["status"],
        message: json["message"],
        data: List<PendingData>.from(
          json["data"].map((x) => PendingData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PendingData {
  int assignmentId;
  String service;
  String status;
  String description;

  PendingData({
    required this.assignmentId,
    required this.service,
    required this.status,
    required this.description,
  });

  factory PendingData.fromJson(Map<String, dynamic> json) => PendingData(
    assignmentId: json["assignment_id"],
    service: json["service"],
    status: json["status"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "assignment_id": assignmentId,
    "service": service,
    "status": status,
    "description": description,
  };
}
