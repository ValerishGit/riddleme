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
    return Scaffold(
      body: WebLayout(
        child: Center(
          child: Column(
            children: [
              Obx(() => Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 200,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authController.activeUser.value.displayName
                                .toString(),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("Best Time"),
                                  Text(authController.activeUser.value.bestTime
                                      .toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Total Answerd"),
                                  Text(authController
                                      .activeUser.value.questionAnswered
                                      .toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Score"),
                                  Text(authController.activeUser.value.score
                                      .toString()),
                                ],
                              ),
                            ],
                          )
                        ],
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
