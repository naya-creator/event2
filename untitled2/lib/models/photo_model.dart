class PhotoModel {
  final int id;
  final int userId;
  final String? description;
  final bool isActive;
  final String? createdAt;
  final String? updatedAt;
  final UserModel user;

  PhotoModel({
    required this.id,
    required this.userId,
    this.description,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.user,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      userId: json['user_id'],
      description: json['description'],
      isActive: json['is_active'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: UserModel.fromJson(json['user']),
    );
  }

  static List<PhotoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => PhotoModel.fromJson(e)).toList();
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
