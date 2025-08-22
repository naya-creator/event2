

import 'package:dio/dio.dart';

import '../models/error_model.dart';

class serverException implements Exception {
  final ErrorModel errorModel;

  serverException({required this.errorModel});
}

void handelDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw serverException(errorModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw serverException(errorModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw serverException(errorModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw serverException(errorModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.badResponse: //وصل للداتا بيز بس انا باعتة شي غلط
      switch (e.response?.statusCode) {
        case 400: //bad request
          throw serverException(
              errorModel: ErrorModel.fromjson(e.response!.data));

        case 401: //unauthorized
          throw serverException(
              errorModel: ErrorModel.fromjson(e.response!.data));
        case 403: //forbidden
          throw serverException(
              errorModel: ErrorModel.fromjson(e.response!.data));
        case 404: //ont found
          throw serverException(
              errorModel: ErrorModel.fromjson(e.response!.data));
        case 409: //cofficient
          throw serverException(
              errorModel: ErrorModel.fromjson(e.response!.data));
        case 422: //unprocessable entity
          throw serverException(
              errorModel: ErrorModel.fromjson(e.response!.data));
        case 504: //server exception
          throw serverException(
              errorModel: ErrorModel.fromjson(e.response!.data));
      }
    case DioExceptionType.cancel:
      throw serverException(errorModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.connectionError:
      throw serverException(errorModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.unknown:
      throw serverException(errorModel: ErrorModel.fromjson(e.response!.data));
  }
}
