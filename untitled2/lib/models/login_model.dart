class LoginModel {
  final String message;
  final String token;
  final int id;
  final String role;

  LoginModel({
    required this.message,
    required this.token,
    required this.id,
    required this.role
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    final user = jsonData["user"];
    return LoginModel(
      message: jsonData["message"], // تأكد من الاسم الصحيح في الـ JSON
      token: jsonData["access_token"],
      id: user["id"],
      role: user['role']
    );
  }
}
