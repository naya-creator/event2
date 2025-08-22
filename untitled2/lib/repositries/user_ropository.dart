
//import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:dartz/dartz.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';

import '../cache/cache_helper.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';

class UserRepository {
  //لااشياء المكررة دوما
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<String, LoginModel>> login(
      {required String email, required String password}) async {
    try {
      final response = await api.post(
        Endpoint.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      print(response);
      final user = LoginModel.fromJson(response);

      // فك تشفير التوكن
      //final decodedToken = JwtDecoder.decode(user.token);
      // print(decodedToken['id']);

      // حفظ البيانات في الكا

      // await CacheHelper.saveUserData(user);

      return Right(user);
      //print(response);
    } on serverException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignupModel>> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String password_confirmation,
  }) async {
    try {
      final response = await api.post(
        Endpoint.signup,
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "password_confirmation": password_confirmation,
        },
      );

      final user = SignupModel.fromJson(response);
      return Right(user);
    } on serverException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
  
  
  Future<Either<String, String>> logout() async {
  try {
    final response = await api.post('logout'); 
    if (response['status'] == true) {
      // حذف التوكين والبيانات من الكاش
      await CacheHelper.removeData(key: 'token');
      await CacheHelper.removeData(key: 'role');
      return Right(response['message']);
    } else {
      return Left(response['message'] ?? 'Logout failed');
    }
  } on serverException catch (e) {
    return Left(e.errorModel.errorMessage);
  } catch (e) {
    return Left(e.toString());
  }
}

}
