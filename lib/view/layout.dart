import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:riddle_me/controllers/auth_controller.dart';

import '../utils/const_values.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeaderWidget(),
        const SizedBox(
          height: 90,
        ),
        Center(child: child),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    Key? key,
  }) : super(key: key);

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (() => Get.toNamed('/')),
                  child: Row(
                    children: [
                      Text(
                        "R?DDLE ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Globals.primary,
                                fontWeight: FontWeight.bold,
                                shadows: [
                              Shadow(color: Globals.primary, blurRadius: 5)
                            ]),
                      ),
                      Text(
                        "ME ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Globals.primary_2,
                                fontWeight: FontWeight.bold,
                                shadows: [
                              Shadow(color: Globals.primary_2, blurRadius: 5)
                            ]),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: FirebaseAuth.instance.currentUser != null,
                  child: Row(
                    children: [
                      Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? ""),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: (() => authController.logOutUser()),
                        child: Icon(Icons.logout),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
