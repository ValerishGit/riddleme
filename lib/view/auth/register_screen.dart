import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddle_me/controllers/auth_controller.dart';
import 'package:riddle_me/view/layout.dart';

import '../../utils/const_values.dart';
import '../components/common_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController _emailController = TextEditingController(),
      _displayNameController = TextEditingController(),
      _passwordController = TextEditingController();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: WebLayout(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Center(
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 250, maxWidth: 500),
                  child: Obx(
                    () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () => Get.toNamed('/login'),
                                  child: const Icon(Icons.arrow_back_ios_new)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Create a new account",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          !_authController.isLoading.value
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                    AuthTextField(
                                        inverse: true,
                                        controller: _displayNameController,
                                        hint: "Display Name",
                                        icon: Icons.person,
                                        isHashed: false),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => SizedBox(
                                          height: 30,
                                          child: Text(
                                            _authController.errText.value,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          _authController.createUserWithCred(
                                              _emailController.text,
                                              _passwordController.text,
                                              _displayNameController.text);
                                        },
                                        child: const Text(
                                          "Sign Up",
                                        ))
                                  ],
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
