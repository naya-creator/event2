



import '../models/dj_model.dart';
import '../models/halls_model.dart';
import '../models/music_model.dart';
import '../models/photo_model.dart';

abstract class UserState2 {}

class UserInitial1 extends UserState2 {}

class SignInLoading extends UserState2 {}

class UploadProfilePic extends UserState2 {}

class SignInSuccess extends UserState2 {}

class SignInFailure extends UserState2 {
  final String errMessage;
  SignInFailure({required this.errMessage});
}

class SignUpLoading extends UserState2 {}

class SignUpSuccess extends UserState2 {
  final String message;
  SignUpSuccess({required this.message});
}

class SignUpFailure extends UserState2 {
  final String errMessage;
  SignUpFailure({required this.errMessage});
}

// class GetUserLoading extends UserState {}

// class GetUserSuccess extends UserState {
//   final UserModel user;
//   GetUserSuccess({required this.user});
// }

// class GetUserFaliure extends UserState {
//   final String errMessage;
//   GetUserFaliure({required this.errMessage});
// }

class GetHallsLoading extends UserState2 {}

class GetHallsSuccess extends UserState2 {
  final List<HallsModel> halls;
  GetHallsSuccess({required this.halls});
}

class GetHallsFaliure extends UserState2 {
  final String message;
  GetHallsFaliure({required this.message});
}

class GetMusicLoading extends UserState2 {}

class GetMusicSuccess extends UserState2 {
  final List<MusicModel> arabicSongs;
  final List<MusicModel> englishSongs;
  final List<DjModel> dj;

  GetMusicSuccess({
    required this.arabicSongs,
    required this.englishSongs,
    required this.dj,
  });
}

class GetMusicFailure extends UserState2 {
  final String message;

  GetMusicFailure({required this.message});
}

class GetPhotoLoading extends UserState2 {}

class GetPhotoSuccess extends UserState2 {
  final List<PhotoModel> photos;
  GetPhotoSuccess({required this.photos});
}

class GetPhotoFaliure extends UserState2 {
  final String message;
  GetPhotoFaliure({required this.message});
}

class PostTaskLoading extends UserState2 {}

class PostTaskSuccess extends UserState2 {}

class PostTaskFailure extends UserState2 {
  final String errMessage;
  PostTaskFailure({required this.errMessage});
}

class ReservPhotographerLoading extends UserState2 {}

class ReservPhotographerSuccess extends UserState2 {
  final String messagge;
  ReservPhotographerSuccess({required this.messagge});
}

class ReservPhotographerFailure extends UserState2 {
  final String message;
  ReservPhotographerFailure({required this.message});
}

class ReservSongerLoading extends UserState2 {}

class ReservSongerSuccess extends UserState2 {
  final String messagge;
  ReservSongerSuccess({required this.messagge});
}

class ReservSongerFailure extends UserState2 {
  final String message;
  ReservSongerFailure({required this.message});
}

class addSongLoading extends UserState2 {}

class addSongSuccess extends UserState2 {
  final String messagge;
  addSongSuccess({required this.messagge});
}

class addSongFailure extends UserState2 {
  final String message;
  addSongFailure({required this.message});
}
