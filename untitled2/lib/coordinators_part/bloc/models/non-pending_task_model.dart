// // To parse this JSON data, do
// //
// //     final data2 = data2FromJson(jsonString);

// import 'dart:convert';

// NonPendingTasksDataModel data2FromJson(String str) =>
//     NonPendingTasksDataModel.fromJson(json.decode(str));

// String data2ToJson(NonPendingTasksDataModel data) => json.encode(data.toJson());

// class NonPendingTasksDataModel {
//   bool status;
//   String message;
//   List<NonPendingData> data;

//   NonPendingTasksDataModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory NonPendingTasksDataModel.fromJson(Map<String, dynamic> json) =>
//       NonPendingTasksDataModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<NonPendingData>.from(
//           json["data"].map((x) => NonPendingData.fromJson(x)),
//         ),
//       );

//   Map<String, dynamic> toJson() => {"status": status, "message": message};
// }

// class NonPendingData {
//   int id;
//   int reservationId;
//   int serviceId;
//   int coordinatorId;
//   int assignedBy;
//   String status;
//   dynamic instructions;
//   dynamic completedAt;
//   dynamic createdAt;
//   DateTime updatedAt;
//   Service service;
//   Reservation reservation;

//   NonPendingData({
//     required this.id,
//     required this.reservationId,
//     required this.serviceId,
//     required this.coordinatorId,
//     required this.assignedBy,
//     required this.status,
//     required this.instructions,
//     required this.completedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.service,
//     required this.reservation,
//   });

//   factory NonPendingData.fromJson(Map<String, dynamic> json) => NonPendingData(
//     id: json["id"],
//     reservationId: json["reservation_id"],
//     serviceId: json["service_id"],
//     coordinatorId: json["coordinator_id"],
//     assignedBy: json["assigned_by"],
//     status: json["status"],
//     instructions: json["instructions"],
//     completedAt: json["completed_at"],
//     createdAt: json["created_at"],
//     updatedAt: DateTime.parse(json["updated_at"]),
//     service: Service.fromJson(json["service"]),
//     reservation: Reservation.fromJson(json["reservation"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "reservation_id": reservationId,
//     "service_id": serviceId,
//     "coordinator_id": coordinatorId,
//     "assigned_by": assignedBy,
//     "status": status,
//     "instructions": instructions,
//     "completed_at": completedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt.toIso8601String(),
//     "service": service.toJson(),
//     "reservation": reservation.toJson(),
//   };
// }

// class Reservation {
//   int id;
//   int userId;
//   int hallId;
//   int eventTypeId;
//   DateTime reservationDate;
//   dynamic startTime;
//   dynamic endTime;
//   dynamic homeAddress;
//   String status;
//   String totalPrice;
//   String discountAmount;
//   dynamic coordinatorId;
//   dynamic discountCodeId;
//   dynamic createdAt;
//   dynamic updatedAt;

//   Reservation({
//     required this.id,
//     required this.userId,
//     required this.hallId,
//     required this.eventTypeId,
//     required this.reservationDate,
//     required this.startTime,
//     required this.endTime,
//     required this.homeAddress,
//     required this.status,
//     required this.totalPrice,
//     required this.discountAmount,
//     required this.coordinatorId,
//     required this.discountCodeId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
//     id: json["id"],
//     userId: json["user_id"],
//     hallId: json["hall_id"],
//     eventTypeId: json["event_type_id"],
//     reservationDate: DateTime.parse(json["reservation_date"]),
//     startTime: json["start_time"],
//     endTime: json["end_time"],
//     homeAddress: json["home_address"],
//     status: json["status"],
//     totalPrice: json["total_price"],
//     discountAmount: json["discount_amount"],
//     coordinatorId: json["coordinator_id"],
//     discountCodeId: json["discount_code_id"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "hall_id": hallId,
//     "event_type_id": eventTypeId,
//     "reservation_date": reservationDate.toIso8601String(),
//     "start_time": startTime,
//     "end_time": endTime,
//     "home_address": homeAddress,
//     "status": status,
//     "total_price": totalPrice,
//     "discount_amount": discountAmount,
//     "coordinator_id": coordinatorId,
//     "discount_code_id": discountCodeId,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }

// class Service {
//   int id;
//   String nameAr;
//   String nameEn;
//   dynamic createdAt;
//   dynamic updatedAt;

//   Service({
//     required this.id,
//     required this.nameAr,
//     required this.nameEn,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//     id: json["id"],
//     nameAr: json["name_ar"],
//     nameEn: json["name_en"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name_ar": nameAr,
//     "name_en": nameEn,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }

import 'dart:convert';

NonPendingTasksDataModel data2FromJson(String str) =>
    NonPendingTasksDataModel.fromJson(json.decode(str));

String data2ToJson(NonPendingTasksDataModel data) => json.encode(data.toJson());

class NonPendingTasksDataModel {
  bool status;
  String message;
  List<NonPendingData> data;

  NonPendingTasksDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NonPendingTasksDataModel.fromJson(Map<String, dynamic> json) =>
      NonPendingTasksDataModel(
        status: json["status"],
        message: json["message"],
        data: List<NonPendingData>.from(
          json["data"].map((x) => NonPendingData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class NonPendingData {
  int assignmentId;
  String service; // الخدمة الآن نص بدل كائن
  String status;
  String description; // الوصف الذي يحتوي على بيانات الحفل

  NonPendingData({
    required this.assignmentId,
    required this.service,
    required this.status,
    required this.description,
  });

  factory NonPendingData.fromJson(Map<String, dynamic> json) => NonPendingData(
        assignmentId: json["assignment_id"],
        service: json["service"] ?? 'غير معروف',
        status: json["status"],
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "assignment_id": assignmentId,
        "service": service,
        "status": status,
        "description": description,
      };
}
