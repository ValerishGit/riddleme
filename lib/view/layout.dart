import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        Center(child: child),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    Key? key,
  }) : super(key: key);

  final AuthController authController = Get.find();
  var colorizeColors = [
    Globals.primary,
    Globals.primary_2,
    Globals.primary_2,
    Globals.primary,
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 64,
      constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: width < 500
                ? const EdgeInsets.symmetric(horizontal: 5)
                : const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (() => Get.toNamed('/')),
                  child: Row(
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText('R ? D D L E M E',
                                colors: colorizeColors,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Globals.primary,
                                      fontWeight: FontWeight.bold,
                                    )),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      FirebaseAuth.instance.currentUser != null && width > 500,
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: ShapeDecoration(
                            color: Globals.primary, shape: StadiumBorder()),
                        child: Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
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
