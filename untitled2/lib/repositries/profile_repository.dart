
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/UpdateProfileResponse_model.dart';
import '../models/userProfile_model.dart';
import 'dart:io';

class ProfileRepository {
  final ApiConsumer api;

  ProfileRepository({required this.api});

  Future<Either<String, UserProfileModel>> getUserProfile() async {
    try {
      final response = await api.get(Endpoint.profile);
      final user = UserProfileModel.fromJson(response['user']);
      return Right(user);
    } on serverException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UpdateProfileResponse>> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? bio,
    File? image,
    String? oldPassword,
    String? newPassword,
  }) async {
    try {
      // final formData = FormData.fromMap({
      //   // 'name': name,
      //   // 'email': email,
      //   // if (phone != null) 'phone': phone,

      //   // if (image != null) 'image': await MultipartFile.fromFile(image.path),
      //   // if (oldPassword != null) 'old_password': oldPassword,
      //   // if (newPassword != null) 'new_password': newPassword
      // });

      print('Sending update request...'); // Debug log
      final response = await api.put(Endpoint.updateProfile, data: {
        "name": name,
        "email": email,
        "bio": "وصف عني أنا المستخدم",
        "password": oldPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPassword
      });

      print('Response: ${response.toString()}'); // Debug log

      final updatedProfile = UpdateProfileResponse.fromJson(response);
      return Right(updatedProfile);
    } on serverException catch (e) {
      print('Error: ${e.errorModel.errorMessage}'); // Debug log
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, String>> uploadImage(File image) async {
    try {
      // التحقق من نوع الملف أولاً
      final extension = image.path.split('.').last.toLowerCase();
      if (!['jpeg', 'png', 'jpg'].contains(extension)) {
        return Left('يجب أن تكون الصورة من نوع jpeg, png, أو jpg');
      }

      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename:
              'profile_${DateTime.now().millisecondsSinceEpoch}.$extension',
        ),
      });

      final response = await api.post(
        Endpoint.uploadImage,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );

      return Right(response['image_url']);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'فشل رفع الصورة');
    }
  }
}
