import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riddle_me/controllers/auth_controller.dart';
import 'package:riddle_me/middleware/login_guard.dart';
import 'package:riddle_me/services/firebase_options.dart';
import 'package:riddle_me/utils/const_values.dart';
import 'package:riddle_me/view/auth/login_screen.dart';
import 'package:riddle_me/view/auth/register_screen.dart';
import 'package:riddle_me/view/daily_riddle_screen.dart';
import 'package:riddle_me/view/main_page.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  AuthController authController = Get.put(AuthController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: "/", page: () => const MainPage(), middlewares: [
          AuthGuard()
        ], children: [
          GetPage(
            name: "/daily-riddle",
            page: () => DailyRiddle(),
          ),
        ]),
        GetPage(
            name: "/login",
            page: () => LoginScreen(),
            middlewares: [LoginGuard()]),
        GetPage(
            name: "/register",
            page: () => RegisterScreen(),
            middlewares: [LoginGuard()]),
      ],
      title: 'Flutter Demo',
      theme: Globals.themeData,
      debugShowCheckedModeBanner: false,
      //Some Widget will use accentColor first and use primarySwatch like insure
    );
  }
}
