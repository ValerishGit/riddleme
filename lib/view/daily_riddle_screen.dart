import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:riddle_me/controllers/daily_riddle_controller.dart';
import 'package:riddle_me/view/layout.dart';

class DailyRiddle extends StatelessWidget {
  DailyRiddle({super.key});

  DailyRiddleController dailyRiddleController =
      Get.put(DailyRiddleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebLayout(
            child: Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () => Get.toNamed('/'),
                  child: const Icon(Icons.arrow_back_ios_new)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Column(
            children: [
              Obx(() => Text(
                    dailyRiddleController.dailyQuestion.value.question ?? "",
                    style: Theme.of(context).textTheme.displaySmall,
                  ))
            ],
          )
        ],
      ),
    )));
  }
}
