import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cache/cache_helper.dart';
import '../cubit/register_cubit.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  //static const String name = '/signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool iscansee = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state)async {
        if (state is Signupsuccess) {
           await CacheHelper.saveData(
    key: "access_token",
    value: state.signupModel.token, // ← هنا التوكن فقط
  );
           // await CacheHelper.saveData(key: "access_token", value: state);
      Navigator.pushReplacementNamed(context, '/main');
    
        } else if (state is Signupfailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: screenWidth * 0.07, // 7% من عرض الشاشة
            elevation: 5,
            shadowColor: Colors.indigo[900],
            backgroundColor: Colors.deepOrange,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined,
                  size: screenWidth * 0.06, // 6% من عرض الشاشة
                  color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // 4% من عرض الشاشة
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\nREGISTER',
                    style: TextStyle(
                      fontSize: screenWidth * 0.1, // 10% من عرض الشاشة
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05), // 5% من ارتفاع الشاشة
                  Center(
                    child: Form(
                      key: cubit.signupFromKey,
                      child: Column(
                        children: [
                          _buildField(
                            context: context,
                            label: "Full Name",
                            icon: Icons.person,
                            controller: cubit.signUpName,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please enter your name';
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          _buildField(
                            context: context,
                            label: "Phone Number",
                            icon: Icons.phone,
                            controller: cubit.signupPhonNumber,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please enter your phone number';
                              if (!value.startsWith('09')) {
                                return 'Phone number must start with 09';
                              }
                              if (value.length != 10) {
                                return 'Phone number must be exactly 10 digits';
                              }
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Phone number must contain only digits';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          _buildField(
                            context: context,
                            label: "Email Address",
                            icon: Icons.email,
                            controller: cubit.signupEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please enter your email';
                              if (value.contains(' ')) {
                                return 'Spaces are not allowed';
                              }
                              if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address "@" ';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          _buildField(
                            context: context,
                            label: "Password",
                            icon: Icons.password,
                            controller: cubit.signupPassword,
                            obscureText: !iscansee,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          _buildField(
                            context: context,
                            label: "Confirm Password",
                            icon: Icons.password_outlined,
                            controller: cubit.confirmPassword,
                            obscureText: !iscansee,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != cubit.signupPassword.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ... (الكود السابق يبقى كما هو حتى قبل زر Register)

                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'If you already have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: screenWidth * 0.035,
                          color: Colors.indigo[900],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: screenWidth * 0.035,
                            color: Colors.deepOrange,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
// ... (يتبع كود زر Register كما هو)
                  Center(
                    child: SizedBox(
                      height: screenHeight * 0.07, // 7% من ارتفاع الشاشة
                      width: screenWidth * 0.35, // 35% من عرض الشاشة
                      child: FloatingActionButton(
                        onPressed: () {
                          if (cubit.signupFromKey.currentState!.validate()) {
                            cubit.signup();
                          }
                        },
                        backgroundColor: Colors.deepOrange,
                        shape: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: state is Signuploading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'Register',
                                style: TextStyle(
                                  fontSize:
                                      screenWidth * 0.045, // 4.5% من العرض
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.indigo[800],
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool isPassword = false,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.indigo[900],
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.04, // 4% من عرض الشاشة
        ),
        prefixIcon: Icon(icon, size: screenWidth * 0.06),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  iscansee
                      ? Icons.visibility_off_sharp
                      : Icons.visibility_sharp,
                  size: screenWidth * 0.06,
                ),
                onPressed: () {
                  setState(() {
                    iscansee = !iscansee;
                  });
                },
              )
            : null,
        suffixIconColor: Colors.indigo[800],
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.04,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
      ),
    );
  }
}
