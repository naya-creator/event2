import 'dart:io';


import 'package:dio/dio.dart';

import 'api_consumer.dart';

import 'api_interceptors.dart';
import 'endpoint.dart';
import 'exception.dart';

class DioConsumer extends ApiConsumer {
  // بدل dio http
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = Endpoint.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: false,
        responseHeader: true,
        responseBody: true,
        error:
            true)); // ,frgf, hghadhx dgd f]d d'fugd dhihبيراقب الريكويست والرسبونس بالاضافة لانو بيطبع بالكونسول
  }
  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryparameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryparameters,
      );
      return response.data;
    } on DioException catch (e) {
      handelDioExceptions(e);
      rethrow; // للحفاظ على نفس النمط الموجود في دالة post
    }
  }

  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryparameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.delete(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryparameters);
      // throw UnimplementedError();
      return response.data;
    } on DioException catch (e) {
      handelDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryparameters}) async {
    try {
      final response =
          await dio.get(path, data: data, queryParameters: queryparameters);
      return response.data;
    } on DioException catch (e) {
      handelDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryparameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryparameters);
      return response.data;
    } on DioException catch (e) {
      handelDioExceptions(e);
    }
  }

 
 
@override
Future<dynamic> post(
  String path, {
  Object? data,
  Map<String, dynamic>? queryparameters,
  bool isFormData = false,
  Options? options,
}) async {
  try {
    final requestOptions = options ?? Options();
    requestOptions.contentType = isFormData ? 'multipart/form-data' : 'application/json';

    final response = await dio.post(
      path,
      data: data,
      queryParameters: queryparameters,
      options: requestOptions,
    );
    return response.data;
  } on DioException catch (e) {
    handelDioExceptions(e);
    rethrow;
  }
}
}
