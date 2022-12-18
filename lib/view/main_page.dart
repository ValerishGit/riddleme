import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddle_me/controllers/auth_controller.dart';
import 'package:riddle_me/utils/const_values.dart';
import 'package:riddle_me/view/layout.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: WebLayout(
        child: Center(
          child: Column(
            children: [
              Obx(() => Container(
                  width: size.width < 500 ? 350 : 500,
                  height: 250,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: authController.activeUser.value.token != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back ${authController.activeUser.value.displayName}'
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Globals.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Personal Stats".toUpperCase(),
                                  style: TextStyle(
                                      color: Globals.primary_2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Best Time".toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        authController.activeUser.value.bestTime
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Correct Answers".toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        authController
                                            .activeUser.value.questionAnswered
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Score".toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        authController.activeUser.value.score
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ))),
              TextButton(
                  onPressed: () {
                    Get.toNamed('/daily-riddle');
                  },
                  child: const Text("Daily Riddle")),
            ],
          ),
        ),
      ),
    );
  }
}
