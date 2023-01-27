import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms/src/screens/splash/splash_binding.dart';
import 'package:sms/src/screens/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS Fetcher',
      initialBinding: SplashBinding(),
      home: const SplashPage(),
    );
  }
}
