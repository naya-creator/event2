import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/cache/cache_helper.dart';
import 'package:untitled2/repositries/user_ropository.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.userrepository) : super(RegisterInitial());
  //final ApiConsumer api;
  final UserRepository userrepository;

  //sign in from key
  // GlobalKey<FormState> loginFromKey = GlobalKey();
  // في الـ Cubit
//GlobalKey<FormState> get loginFromKey => GlobalKey(); // إنشاء جديد في كل استدعاء
  final GlobalKey<FormState> loginFromKey = GlobalKey<FormState>();
  //sign in email
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  //sinup form key
  GlobalKey<FormState> signupFromKey = GlobalKey();

  TextEditingController signUpName = TextEditingController();
  TextEditingController signupPhonNumber = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  LoginModel? user;
  loginUser() async {
    emit(Loginloading());
    final response = await userrepository.login(
        email: loginEmail.text, password: loginPassword.text);

    response.fold(
      (errorMessage) {
        // هنا لو في خطأ
        print('Login failed: $errorMessage');
      },
      (loginModel) {
        CacheHelper.saveData(key: 'token', value: loginModel.token);
        CacheHelper.saveData(key: 'role', value: loginModel.role);
      },
    );

    response.fold((errMessage) => emit(Loginfailure(errMessage: errMessage)),
        (LoginModel) => emit(Loginsuccess(role: LoginModel.role)));
  }

 signup() async {
  emit(Signuploading());

  final response = await userrepository.signup(
    name: signUpName.text,
    email: signupEmail.text,
    password: signupPassword.text,
    password_confirmation: confirmPassword.text,
    phone: signupPhonNumber.text,
  );

  response.fold(
    (errorMessage) {
      print('Signup failed: $errorMessage');
      emit(Signupfailure(errMessage: errorMessage)); 
    },
    (signupModel) async {
      // خزّن التوكن
      await CacheHelper.saveData(
        key: 'token',
        value: signupModel.token,
      );

      emit(Signupsuccess(signupModel)); 
    },
  );
}
Future<void> logoutUser(BuildContext context) async {
  emit(Logoutloading());
  final result = await userrepository.logout();
  result.fold(
    (error) {
      emit(Logoutfailure(errMessage: error));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    },
    (message) async {
      // حذف التوكن
      await CacheHelper.removeData(key: 'token');

      emit(Logoutsuccess());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      // الانتقال لواجهة signup وإزالة كل الـ routes السابقة
      Navigator.of(context).pushNamedAndRemoveUntil('/signup', (route) => false);
    },
  );
}

}
