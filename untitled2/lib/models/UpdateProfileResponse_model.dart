
import 'userProfile_model.dart';

class UpdateProfileResponse {
  final String message;
  final UserProfileModel user;

  UpdateProfileResponse({
    required this.message,
    required this.user,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      message: json['message'],
      user: UserProfileModel.fromJson(json['user']),
    );
  }
}