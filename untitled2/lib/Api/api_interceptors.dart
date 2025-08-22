

import 'package:dio/dio.dart';
import 'package:untitled2/cache/cache_helper.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept'] = 'application/json';

    final token = CacheHelper.getData(key: 'token');
    print("🟢 Token in Interceptor: $token");
  if (token != null) {
    options.headers['Authorization'] = 'Bearer $token';
  }
    //options.headers['Accept_language']='en';
    super.onRequest(options, handler);
  }
} //للتحكم في الريكويست والرسبونس
