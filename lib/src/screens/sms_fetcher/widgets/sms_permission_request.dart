import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SmsPermissionRequestWidget extends StatelessWidget {
  const SmsPermissionRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text("Confirm Permission Request"),
      content: const Text("this action required SMS access permission please make sure to accept this permission !"),
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
