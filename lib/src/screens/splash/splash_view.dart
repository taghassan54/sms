import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sms/generated/assets.dart';

import 'splash_logic.dart';

class SplashPage extends GetView<SplashLogic> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashLogic().onInit();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(Assets.lottiefilesMobileMoneyTransfer),
          const SizedBox(height: 10,),
          const Text("Welcome in SMS Application")
        ],
      ),
    );
  }
}
