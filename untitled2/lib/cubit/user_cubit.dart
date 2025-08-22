
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../cache/cache_helper.dart';
import '../models/addsong_model.dart';
import '../models/dj_model.dart';
import '../models/music_model.dart';
import '../models/photo_model.dart';
import '../models/task_model.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState2> {
  UserCubit(this.api) : super(UserInitial1());
  final ApiConsumer api;
  TextEditingController logInemail = TextEditingController();
  TextEditingController logInPassword = TextEditingController();
  XFile? profilePic;
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController CongirmPassword = TextEditingController();
  TextEditingController song = TextEditingController();
  TextEditingController singer = TextEditingController();

  // uploadProfilePic(XFile image) {
  //   profilePic = image;
  //   emit(UploadProfilePic());
  // }

  // signUp() async {
  //   try {
  //     emit(SignUpLoading());
  //     final response = await api.post(
  //         EndPoint.signUp
  //         //حطينا فروم داتا لانو بالبوست مان محطوط المعلومات بالجدول مو {} جوا القوسين ك body مكتوب بالجيسون
  //         ,
  //         isFromData: true,
  //         data: {
  //           ApiKey.name = signUpName.text,
  //           ApiKey.email = signUpEmail.text,
  //           ApiKey.password = signUpPassword.text,
  //           ApiKey.password_confirmation = CongirmPassword.text,
  //           ApiKey.phone = signUpPhoneNumber.text
  //           //هي كرمال ارفع صورة من ال API
  //           //Apikey.profilrPic:await uploadImageToApi(profilrPic!);
  //         });
  //     final registerModel = RegisterModel.fromJson(response);
  //     emit(SignUpSuccess(message: registerModel.message));
  //   } on ServerException catch (e) {
  //     emit(SignUpFailure(errMessage: e.erroeModel.message));
  //   }
  // }

  // getUserProfile() async {
  //   try {
  //     emit(GetUserLoading());
  //     final response = await api.get(
  //         EndPoint.getUserDataEndPoint(CachHelper().getData(key: ApiKey.id)));
  //     emit(GetUserSuccess(user: UserModel.fromJson(response)));
  //   } on ServerException catch (e) {
  //     emit(GetUserFaliure(errMessage: e.erroeModel.errorMessage));
  //   }
  // }


  getMusic() async {
    try {
      emit(GetMusicLoading());

      final response = await api.get(
        Endpoint.getMusicDataEndPoint(
          CacheHelper.getData(key: ApiKey.id),
        ),
      );

      print("Response: $response");

      final arabicSongsList =
      MusicModel.fromJsonList(response['songs_ar'] ?? []);
      final englishSongsList =
      MusicModel.fromJsonList(response['songs_en'] ?? []);
      final djList = DjModel.fromJsonList(response['djs'] ?? []);

      emit(GetMusicSuccess(
        arabicSongs: arabicSongsList,
        englishSongs: englishSongsList,
        dj: djList,
      ));
    } on serverException catch (e) {
      emit(GetMusicFailure(message: e.errorModel.errorMessage));
    }
  }

  getPhotographer() async {
    try {
      emit(GetPhotoLoading());
      final response = await api.get(
          Endpoint.getPhotoDataEndPoint(CacheHelper.getData(key: ApiKey.id)));
      print("Response: $response");
      final List<PhotoModel> photoList =
      PhotoModel.fromJsonList(response['photographers']);
      emit(GetPhotoSuccess(photos: photoList));
    } on serverException catch (e) {
      emit(GetPhotoFaliure(message: e.errorModel.errorMessage));
    }
  }

  List<TaskModel> assignedTasks = [];
  Future<void> assignTasksToCoordinators(int hallId) async {
    emit(PostTaskLoading());

    try {
      final response = await api.post(Endpoint.postTaskToCoordinator(hallId));

      if (response['status'] == true) {
        assignedTasks = TaskModel.fromJsonList(response['assignments']);
        emit(PostTaskSuccess());
      } else {
        emit(PostTaskFailure(errMessage: response['message'] ?? 'فشل التوزيع'));
      }
    } catch (e) {
      emit(PostTaskFailure(errMessage: e.toString()));
    }
  }

  reservationPhotographer({
    required int reservationId,
    required int coordinatorId,
    required int serviceId,
    required int unitPrice,
  }) async {
    try {
      emit(ReservPhotographerLoading());
      // ignore: unused_local_variable
      final response = await api.post(
        Endpoint.reservPhotohrapher,
        data: {
          "reservation_id": reservationId,
          "coordinator_id": coordinatorId,
          "service_id": serviceId,
          "unit_price": unitPrice,
        },
      );
      emit(ReservPhotographerSuccess(messagge: "message"));
    } on serverException catch (e) {
      emit(ReservPhotographerFailure(message: e.errorModel.errorMessage));
    }
  }

  reservationSonger({
    required int reservationId,
    required int coordinatorId,
    required int serviceId,
    required int unitPrice,
    required List<int> songIds,
    required List<Map<String, dynamic>> customSongs,
  }) async {
    try {
      emit(ReservSongerLoading());

      // ignore: unused_local_variable
      final response = await api.post(
        Endpoint.reservSinger, // تأكد إنك ضابط الـ endpoint
        data: {
          "reservation_id": reservationId,
          "coordinator_id": coordinatorId,
          "service_id": serviceId,
          "unit_price": unitPrice,
          "song_ids": songIds,
          "custom_songs": customSongs,
        },
      );

      emit(ReservSongerSuccess(messagge: "تم الحجز بنجاح"));
    } on serverException catch (e) {
      emit(ReservPhotographerFailure(message: e.errorModel.errorMessage));
    }
  }

  addSong() async {
    try {
      emit(addSongLoading());

      final response = await api.post(
        Endpoint.addsongg,
        data: {
          ApiKey.title: song.text,
          ApiKey.artist: singer.text,
          ApiKey.reservation_id: "10",
        },
      );

      final addsongModel = AddsongModel.fromJson(response.data['song_request']);
      emit(addSongSuccess(messagge: "تم الحجز بنجاح"));
    } on serverException catch (e) {
      emit(addSongFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      emit(addSongFailure(message: "حدث خطأ غير متوقع"));
    }
  }
}
