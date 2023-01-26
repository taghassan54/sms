import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:sms/src/screens/sms_fetcher/sms_fetcher_binding.dart';
import 'package:sms/src/screens/sms_fetcher/sms_fetcher_view.dart';

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
     initialBinding: SmsFetcherBinding(),
      home:const SmsFetcherPage(),
    );
  }
}
