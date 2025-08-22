import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cache/cache_helper.dart';
import '../cubit/register_cubit.dart';
import '../models/login_model.dart';
import 'bottomnavigation_bar.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  Login({super.key});
  //static const String name = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool iscansee1 = false;

  @override
  Widget build(BuildContext context) {
    // احصل على أبعاد الشاشة
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is Loginsuccess) { 
           await CacheHelper.saveData(key: "access_token", value: state);

          await CacheHelper.saveData(key: "role", value: state.role);

          if (CacheHelper.getData(key: "role") == "coordinator") {
            Navigator.pushReplacementNamed(context, '/pending');
          }
          //  else if (CacheHelper.getData(key: "role") == "admin"){
          //   Navigator.pushReplacementNamed(context, '/main');
          // }
          else {
            Navigator.pushReplacementNamed(context, '/main');
          }
        } else if (state is Loginfailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            shadowColor: Colors.indigo[900],
            titleSpacing: screenWidth * 0.07, // 7% من عرض الشاشة
            backgroundColor: Colors.deepOrange,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // 4% من عرض الشاشة
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '\nLOGIN',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.08), // 8% من ارتفاع الشاشة
                  Center(
                    child: Form(
                      key: context.read<RegisterCubit>().loginFromKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller:
                                context.read<RegisterCubit>().loginEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email Address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              labelStyle: TextStyle(
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.04,
                              ),
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: _buildInputBorder(),
                              errorBorder: _buildInputBorder(isError: true),
                              focusedErrorBorder: _buildInputBorder(),
                              enabledBorder: _buildInputBorder(),
                              focusedBorder: _buildInputBorder(isFocused: true),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          TextFormField(
                            controller:
                                context.read<RegisterCubit>().loginPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: const Icon(Icons.password_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  iscansee1
                                      ? Icons.visibility_off_sharp
                                      : Icons.visibility_sharp,
                                  size: screenWidth * 0.06, // 6% من عرض الشاشة
                                ),
                                onPressed: () {
                                  setState(() {
                                    iscansee1 = !iscansee1;
                                  });
                                },
                              ),
                              suffixIconColor: Colors.indigo[800],
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.04,
                              ),
                              border: _buildInputBorder(),
                              errorBorder: _buildInputBorder(isError: true),
                              focusedErrorBorder: _buildInputBorder(),
                              enabledBorder: _buildInputBorder(),
                              focusedBorder: _buildInputBorder(isFocused: true),
                            ),
                            obscureText: !iscansee1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'If you don\'t have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: screenWidth * 0.04, // 4% من عرض الشاشة
                          color: Colors.indigo[900],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      TextButton(
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: screenWidth * 0.04,
                            color: Colors.deepOrange,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Center(
                    child: SizedBox(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.35,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (context
                              .read<RegisterCubit>()
                              .loginFromKey
                              .currentState!
                              .validate()) {
                            context.read<RegisterCubit>().loginUser();
                          }
                        },
                        backgroundColor: Colors.deepOrange,
                        shape: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: state is Loginloading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.indigo[800],
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // دالة مساعدة لإنشاء حدود حقل الإدخال
  OutlineInputBorder _buildInputBorder(
      {bool isError = false, bool isFocused = false}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: isError
            ? Colors.red
            : isFocused
                ? Colors.deepOrange
                : Colors.black,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
