// import 'dart:convert';
// import 'package:bloc/bloc.dart';
// import 'package:event/repositries/profile_repository.dart';
// import 'package:meta/meta.dart';
// import 'dart:io';
// import '../cache/cache_helper.dart';
// import '../models/userProfile_model.dart';

// part 'profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   final ProfileRepository repository;

//   ProfileCubit(this.repository) : super(ProfileInitial());

//   UserProfileModel? user;
//   void loadCachedProfile() {
//     /// تحميل البيانات من الكاش

//     final cachedData = CacheHelper.getData(key: 'user_profile');

//     if (cachedData != null) {
//       final decoded = jsonDecode(cachedData);
//       user = UserProfileModel.fromJson(decoded);
//       emit(ProfileLoaded(user!));
//     }
//   }

//   Future<void> fetchProfile() async {
//     emit(ProfileLoading());
//     final result = await repository.getUserProfile();
//     result.fold(
//       (error) => emit(ProfileError(error)),
//       (data) {
//         user = data;
//         // حفظ في الكاش
//         CacheHelper.saveData(
//           key: 'user_profile',
//           value: jsonEncode(data.toJson()),
//         );
//         emit(ProfileLoaded(data));
//       },
//     );
//   }

//   Future<void> updateUserProfile({
//     required String name,
//     required String email,
//     String? phone,
//     File? image_url,
//     String? oldPassword,
//     String? newPassword,
//   }) async {
//     emit(ProfileUpdating());
//     final result = await repository.updateProfile(
//       name: name,
//       email: email,
//       phone: phone,
//       image: image_url,
//       oldPassword: oldPassword, // أضف هذا
//       newPassword: newPassword,
//     );

//     result.fold(
//       (error) => emit(ProfileError(error)),
//       (data) async {
//         user = data.user;
//         emit(ProfileLoaded(user!)); // إرسال الحالة الجديدة
//         emit(ProfileUpdatedSuccessfully(data.message));
//         // انتظر قليلاً لإتاحة الوقت للسيرفر لتحديث البيانات
//         await Future.delayed(Duration(milliseconds: 500));
//         await fetchProfile();
//         // إعادة تحميل البيانات بعد التحديث
//         await fetchProfile();
//       },
//     );
//   }

//   Future<void> uploadProfileImage(File image) async {
//     emit(ProfileUpdating());
//     final result = await repository.uploadImage(image);
//     result.fold(
//       (error) => emit(ProfileError(error)),
//       (imageUrl) {
//         user!.imageUrl = imageUrl;
//         emit(ProfileImageUpdated(imageUrl));
//       },
//     );
//   }
// }

import 'dart:convert';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:untitled2/repositries/profile_repository.dart';
import 'dart:io';
import '../cache/cache_helper.dart';
import '../models/userProfile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  UserProfileModel? user;

  /// تحميل الملف من الكاش أو التحقق من التوثيق
  void loadCachedProfileOrRedirect() async {
    final token = CacheHelper.getData(key: 'token');
    final role = CacheHelper.getData(key: 'role');
    final cachedData = CacheHelper.getData(key: 'user_profile');

    if (token == null || token.isEmpty || role == null) {
      emit(ProfileNotAuthenticated());
      return;
    }

    // تحميل البيانات من الكاش إن وُجدت
    if (cachedData != null) {
      try {
        final decoded = jsonDecode(cachedData);
        user = UserProfileModel.fromJson(decoded);
        emit(ProfileLoaded(user!));
        return;
      } catch (e) {
        // إذا فشل التحميل من الكاش، نعيد التوجيه
      }
    }

    // إذا لم تكن البيانات في الكاش، نحاول جلبها من السيرفر
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final result = await repository.getUserProfile();
    result.fold(
      (error) {
        // إذا فشل جلب الملف، اعتبره غير مصادق
        emit(ProfileNotAuthenticated());
      },
      (data) {
        user = data;
        CacheHelper.saveData(
          key: 'user_profile',
          value: jsonEncode(data.toJson()),
        );
        emit(ProfileLoaded(data));
      },
    );
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    String? phone,
    File? image,
    String? oldPassword,
    String? newPassword,
  }) async {
    emit(ProfileUpdating());
    final result = await repository.updateProfile(
      name: name,
      email: email,
      phone: phone,
      image: image,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    result.fold(
      (error) => emit(ProfileError(error)),
      (data) async {
        user = data.user;
        emit(ProfileLoaded(user!));
        emit(ProfileUpdatedSuccessfully(data.message));
        await Future.delayed(const Duration(milliseconds: 500));
        await fetchProfile();
      },
    );
  }

  Future<void> uploadProfileImage(File image) async {
    emit(ProfileUpdating());
    final result = await repository.uploadImage(image);
    result.fold(
      (error) => emit(ProfileError(error)),
      (imageUrl) {
        user!.imageUrl = imageUrl;
        emit(ProfileImageUpdated(imageUrl));
      },
    );
  }
}