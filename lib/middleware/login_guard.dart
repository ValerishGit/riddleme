import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddle_me/controllers/auth_controller.dart';

class LoginGuard extends GetMiddleware {
  final authService = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    return FirebaseAuth.instance.currentUser == null
        ? null
        : const RouteSettings(name: '/');
  }
}

class AuthGuard extends GetMiddleware {
  final authService = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    return FirebaseAuth.instance.currentUser != null
        ? null
        : const RouteSettings(name: '/login');
  }
}
