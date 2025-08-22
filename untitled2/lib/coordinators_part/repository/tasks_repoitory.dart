


import 'package:dio/dio.dart';

import '../../Api/api_interceptors.dart';
import '../../Api/endpoint.dart';
import '../../cache/cache_helper.dart';
import '../bloc/models/non-pending_task_model.dart';
import '../bloc/models/tasks_data_model.dart';


class TasksRepository {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: Endpoint.baseUrl),
  )..interceptors.add(ApiInterceptors());

  /// Get Pending Tasks
  static Future<List<PendingData>> getPendingTasks() async {
    try {  final token = await CacheHelper.getData(key: "token");
      final response = await _dio.get(
        "coordinator/assignments/pending",
      );

      final data =
          PendingTasksDataModel.fromJson(response.data);
      return data.data;
    } catch (e) {
      print("Error in getPendingTasks: $e");
      throw Exception('Failed to load tasks');
    }
  }

  /// Get Non-Pending Tasks
  static Future<List<NonPendingData>> getNonPendingTasks() async {
    try {
      final response = await _dio.get(
        "coordinator/assignments/non-pending",
      );

      final data = NonPendingTasksDataModel.fromJson(response.data);
      return data.data;
    } catch (e) {
      print("Error in getNonPendingTasks: $e");
      throw Exception('Failed to load tasks');
    }
  }

  /// Change Task Status (Accept or Reject)
  static Future<bool> changeStatusTask(int assignmentId, bool accept) async {
    try {
      final endpoint = accept
          ? "coordinator/assignments/$assignmentId/accept"
          : "coordinator/assignments/$assignmentId/reject";

      final response = await _dio.post(endpoint);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error in changeStatusTask: $e");
      throw Exception('Failed to change task status');
    }
  }
}
