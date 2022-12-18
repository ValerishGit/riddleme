import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:riddle_me/view/main_page.dart';

import '../modals/user_modal.dart';
import '../view/auth/login_screen.dart';
import '../services/firebase_service.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errText = "".obs;
  late Rx<UserClass> activeUser =
      UserClass(null, null, null, null, null, null, null).obs;

  AuthController() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        activeUser(await FirebaseService.getUserbyId(user.uid));
        print(activeUser.value.email);
        FirebaseService.updateLastLogin();
      } else {
        activeUser(UserClass(null, null, null, null, null, null, null));
      }
    });
  }

  Future<void> logOutUser() async {
    await FirebaseService.logOutUser();
    await Get.offNamed('/login');
  }

  void checkAuthStatus() {}

  Future<void> loginWithCred(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      errText("Fields cant be empty");
      return;
    }
    isLoading(true);
    try {
      UserCredential? cred =
          await FirebaseService.loginWithCred(email, password);
      if (cred != null) {
        activeUser(await FirebaseService.getUserbyId(cred.user!.uid));
        Get.offNamed('/');
      }
    } catch (e) {
      errText(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createUserWithCred(String email, String password,
      String passwordConfirm, String displayName) async {
    if (password != passwordConfirm) {
      errText("Passwords do not match");
      return;
    }
    isLoading(true);
    try {
      UserCredential? cred = await FirebaseService.createUserWithCred(
          email, password, displayName);
      if (cred != null) {
        await cred.user!.updateDisplayName(displayName);
        UserClass newUser = UserClass(displayName, cred.user!.uid,
            cred.user!.email, DateTime.now(), 0, 0, 0);
        await FirebaseService.addToDB(newUser);
        cred = await FirebaseService.loginWithCred(email, password);
        if (cred != null) {
          activeUser(await FirebaseService.getUserbyId(newUser.token!));
          Get.offNamed('/');
        }
      }
    } catch (e) {
      errText(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
