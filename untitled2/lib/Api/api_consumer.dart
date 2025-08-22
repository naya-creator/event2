

import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryparameters,
    bool isFormData = false,
  });

  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryparameters,
  });
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryparameters,
    bool isFormData = false,
    Options? options,
  });
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryparameters,
    bool isFormData = false, //طريقة ثانية لارسال الداتا على شكل فورم
  });
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryparameters,
    bool isFormData = false,
  });
}
