import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
class SmsPermissionRequestWidget extends StatelessWidget {
  const SmsPermissionRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text("Confirm Permission"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.network(
              'https://assets8.lottiefiles.com/private_files/lf30_z9ngb6sp.json',width: 150),
          const Text("this action required SMS access permission please make sure to accept this permission !"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Get.back(result: "Cancel");
          },
        ),
        TextButton(
          child: const Text("Confirm"),
          onPressed: () {
            Get.back(result: "Confirm");
          },
        ),
      ],
    );

  }
}
