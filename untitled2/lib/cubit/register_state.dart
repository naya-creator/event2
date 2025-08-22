part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class LoginInitial extends RegisterState {}

class Loginsuccess extends RegisterState { final String role;
  Loginsuccess({required this.role});}

class Loginloading extends RegisterState {}

class Loginfailure extends RegisterState {
  final String errMessage;

  Loginfailure({required this.errMessage});
}

class SignupInitial extends RegisterState {}

class Signupsuccess extends RegisterState {
 final SignupModel signupModel;   // ← خزّنا الموديل هنا
  Signupsuccess(this.signupModel);

}

class Signuploading extends RegisterState {}

class Signupfailure extends RegisterState {
  final String errMessage;

  Signupfailure({required this.errMessage});



}class LogoutInitial extends RegisterState {}

class Logoutsuccess extends RegisterState {
 }

class Logoutloading extends RegisterState {}

class Logoutfailure extends RegisterState {
  final String errMessage;

  Logoutfailure({required this.errMessage});
}

