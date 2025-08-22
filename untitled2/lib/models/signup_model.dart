class SignupModel {
  final int id;
  final String name;
  final String email;
  final String token;
 
  // final String password;
  // final String confirmpassword;

  SignupModel(
      {required this.id,
      required this.name,
      required this.email,
     
      required this.token
      // required this.password,
      // required this.confirmpassword,
      });
  factory SignupModel.fromJson(Map<String, dynamic> jsondata) {
    final user = jsondata["user"]; // الوصول داخل المفتاح
    return SignupModel(
      id: user["id"],
      name: user['name'],
      email: user['email'],
     
      token: jsondata['access_token'],
      //  password: user['password'],
      //confirmpassword:user["password_confirmation"]
    );
  }
}
