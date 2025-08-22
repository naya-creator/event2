// part of 'profile_cubit.dart';

// @immutable
// abstract class ProfileState {}

// class ProfileInitial extends ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileLoaded extends ProfileState {
//   final UserProfileModel user;

//   ProfileLoaded(this.user);
// }

// class ProfileError extends ProfileState {
//   final String error;

//   ProfileError(this.error);
// }

// class ProfileUpdatedSuccessfully extends ProfileState {
//   final String message;

//   ProfileUpdatedSuccessfully(this.message);
// }

// class ProfileUpdating extends ProfileState {}

// class ProfileImageUpdated extends ProfileState {
//   final String imageUrl;

//   ProfileImageUpdated(this.imageUrl);
// }

part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileModel user;

  ProfileLoaded(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileLoaded &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

class ProfileUpdatedSuccessfully extends ProfileState {
  final String message;

  ProfileUpdatedSuccessfully(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileUpdatedSuccessfully &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class ProfileUpdating extends ProfileState {}

class ProfileImageUpdated extends ProfileState {
  final String imageUrl;

  ProfileImageUpdated(this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileImageUpdated &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => imageUrl.hashCode;
}

// ✅ الحالة المهمة الجديدة: المستخدم غير موثق
class ProfileNotAuthenticated extends ProfileState {}