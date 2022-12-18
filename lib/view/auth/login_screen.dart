import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddle_me/controllers/auth_controller.dart';
import 'package:riddle_me/view/layout.dart';

import '../../utils/const_values.dart';
import '../components/common_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WebLayout(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "New riddle everyday! who will solve it faster?"
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Globals.primary_2,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 300,
                        constraints:
                            const BoxConstraints(minWidth: 250, maxWidth: 350),
                        child: !_authController.isLoading.value
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login to enter the game",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AuthTextField(
                                      inverse: true,
                                      controller: _emailController,
                                      hint: "Email",
                                      icon: Icons.email),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  AuthTextField(
                                      inverse: true,
                                      controller: _passwordController,
                                      hint: "Password",
                                      icon: Icons.password,
                                      isHashed: true),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                    () => SizedBox(
                                        height: 30,
                                        child: Text(
                                          _authController.errText.value,
                                          style:
                                              TextStyle(color: Globals.primary),
                                        )),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        _authController.loginWithCred(
                                            _emailController.text,
                                            _passwordController.text);
                                      },
                                      child: const Text(
                                        "SIGN IN",
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed('register');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "First Time?",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          " Sign up",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
