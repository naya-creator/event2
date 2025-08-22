

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled2/Api/dio_consumer.dart';
import 'package:untitled2/cache/cache_helper.dart';
import 'package:untitled2/coordinators_part/bloc/tasks_bloc.dart';
import 'package:untitled2/coordinators_part/widgets/pendingTasks.dart';
import 'package:untitled2/cubit/profile_cubit.dart';
import 'package:untitled2/cubit/register_cubit.dart';
import 'package:untitled2/repositries/profile_repository.dart';
import 'package:untitled2/repositries/user_ropository.dart';
import 'package:untitled2/widget/bottomnavigation_bar.dart';
import 'package:untitled2/widget/signup.dart';

import 'widget/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  final dio = Dio();
  final dioConsumer = DioConsumer(dio: dio);

  // قراءة الدور والتوكن المخزن
  String? role = CacheHelper.getData(key: "role");
  String? token = CacheHelper.getData(key: "token");

  runApp(MyApp(
    userRepository: UserRepository(api: dioConsumer),
    profileRepository: ProfileRepository(api: dioConsumer),
    initialRole: role,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final ProfileRepository profileRepository;
  final String? initialRole;
  final String? token;

  const MyApp({
    Key? key,
    required this.userRepository,
    required this.profileRepository,
    required this.initialRole,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(userRepository),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepository),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("ar"),
          Locale("en"),
        ],

        // تحديد الواجهة الأولية حسب وجود التوكن والدور
        home: _getInitialScreen(),

        routes: {
          '/signup': (context) => const Signup(),
          '/login': (context) => Login(),
          '/main': (context) => MainScreen(),
          '/pending': (context) => const Pendingtasks(),
        },
      ),
    );
  }

  Widget _getInitialScreen() {
    // إذا التوكن موجود → يذهب مباشرة للواجهة الرئيسية حسب الدور
    if (token != null) {
      if (initialRole == "coordinator") {
        return const Pendingtasks();
      } else {
        // يمكن تعديل هنا لو في أدوار أخرى
        return const Pendingtasks();
      }
    }
    // إذا التوكن غير موجود → يظهر شاشة تسجيل الدخول
    return Login();
  }
}
