import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/core/color/color.dart';
import 'package:clientapp/splash/controller/controller_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashScreenController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            Image.asset(
              'assets/image/logo.png',
              color: light_blue,
              width: Get.width / 3.5,
            ),
            Expanded(child: SizedBox()),
            AutoSizeText(
              'From',
              style: TextStyle(
                  color: grey200, fontSize: 15, fontWeight: FontWeight.w400),
            ),
            AutoSizeText(
              'Junior Developer',
              style: TextStyle(
                  color: light_blue, fontSize: 18, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
