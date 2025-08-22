



import '../Api/endpoint.dart';

class UserModel {
  final String profilePic;
  final String email;
  final String phone;
  final String name;
  final Map<String, dynamic> address;
  UserModel(
      {required this.profilePic,
        required this.email,
        required this.name,
        required this.address,
        required this.phone});
  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        profilePic: jsonData['user'][ApiKey.profilePic],
        email: jsonData['user'][ApiKey.email],
        name: jsonData['user'][ApiKey.name],
        address: jsonData['user'][ApiKey.location],
        phone: jsonData['user'][ApiKey.phone]);
  }
}
