class UserProfileModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final bool isAdmin;
  //String? image; // تغيير من final إلى قابل للتعديل
  

  String? imageUrl; // تغيير من final إلى قابل للتعديل
  // إضافة حقول كلمة المرور والتأكيد (لن يتم تخزينها عادةً في هذا النموذج للقراءة فقط)
  final String? password;
  final String? passwordConfirmation;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.isAdmin,
    //this.image,
    
   
    this.imageUrl,
    this.password,
    this.passwordConfirmation,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isAdmin: json['is_admin'] == 1,
      //image: json['image'],
    
     
      imageUrl: json['image_url'],
      // لن يتم تضمين كلمة المرور وتأكيدها عادةً في بيانات المستخدم القادمة من الخادم
      // قم بتضمينها هنا فقط إذا كانت جزءًا من هيكل البيانات الذي تتعامل معه
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }

  // يمكنك إضافة دالة toJson إذا كنت بحاجة لتحويل هذا النموذج إلى JSON لإرساله إلى الخادم
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'is_admin': isAdmin ? 1 : 0,
      //'image': image,

      'image_url': imageUrl,
      // قم بتضمين كلمة المرور وتأكيدها هنا فقط إذا كنت سترسلهما إلى الخادم
      // 'password': password,
      // 'password_confirmation': passwordConfirmation,
    };
  }
}