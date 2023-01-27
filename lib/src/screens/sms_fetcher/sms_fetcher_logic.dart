import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms/src/screens/sms_fetcher/widgets/sms_permission_request.dart';
import 'package:collection/collection.dart';

import 'sms_fetcher_state.dart';

class SmsFetcherLogic extends GetxController with StateMixin<SmsFetcherState> {
  // list of sms messages
  List<SmsMessage> allMessages = [];
  List<SmsMessage> transactionalMessages = [];
  SmsQuery query = SmsQuery();
  PermissionStatus smsPermissionStatus = PermissionStatus.denied;
  double totalAmount = 0.0;

  @override
  void onInit() async {
    await requestSMSPermissionAndGetData();

    super.onInit();
  }

  requestSMSPermissionAndGetData() async {
    change(null, status: RxStatus.loading());
    smsPermissionStatus = await Permission.sms.status;
    update();
    if (smsPermissionStatus.isDenied) {
      var result = await Get.dialog(const SmsPermissionRequestWidget());
      if (result == "Confirm") {
        await Permission.sms.request();
        smsPermissionStatus = await Permission.sms.status;
        if (smsPermissionStatus.isGranted) {
          getSmsData();
        } else {
          change(null, status: RxStatus.error("permission is not Granted !"));
        }
        update();
      } else {
        change(null, status: RxStatus.error("permission is not Granted !"));
        Get.showSnackbar(const GetSnackBar(
          title: "Failed",
          message: "you reject the permission !",
          backgroundColor: Colors.red,
        ));
      }
    } else {
      getSmsData();
    }
  }

  void getSmsData() async {
    allMessages = await query.getAllSms;
    allMessages = allMessages
        .where(
          (element) =>
              (element.kind == SmsMessageKind.received) &&
              (element.body != null && element.body!.contains("AED")),
        )
        .toList();
    transactionalMessages = allMessages;
    Future.delayed(
      Duration.zero,
          () => calculateTotalAmount(),
    );
    // allMessages.groupBy((event) => event.dateTime.toLocal().toIso8601String().substring(0,10));
    change(SMSLoadedSuccessfully(), status: RxStatus.success());
    update();
  }

  void onSearchInputChanged(String value) {
    if (value.isEmpty) {
      transactionalMessages = allMessages;
    } else {
      transactionalMessages = allMessages
          .where((element) =>
              (element.sender?.toLowerCase().contains(value.toLowerCase()) ??
                  false) ||
              (element.body?.toLowerCase().contains(value.toLowerCase()) ??
                  false))
          .toList();
    }
    Future.delayed(
      Duration.zero,
          () => calculateTotalAmount(),
    );
    update();
  }

  String? extractMoneyAmount(String smsText) {
    // // Define the regex pattern to match money amount
    // final pattern =
    //     RegExp(r'(AED\s)?([0-9]+(\.[0-9][0-9])?\sAED|\d+,\d+\.\d+|\d+\.\d+)\s');
    //
    // // Search for the first match of the pattern in the SMS text
    // final match = pattern.firstMatch(smsText);
    //
    // // Extract the money amount from the matched text
    //
    // return match?.group(0);
    // Define the regex pattern to match money amount in different formats
    final pattern = RegExp(r'(AED\s)?([0-9]+(\.[0-9][0-9])?\sAED|\d+,\d+\.\d+|\d+\.\d+)\s|(AED|available\sbalance\sAED|Amount\sPaid\:\sAED)\s([0-9]+(\.[0-9][0-9])?|insufficient\sbalance)');

    // Search for the first match of the pattern in the SMS text
    final match = pattern.firstMatch(smsText);

    // Extract the money amount from the matched text
    return match?.group(2);
  }

  calculateTotalAmount() {
    // totalAmount = double.parse("${transactionalMessages.length}");

    totalAmount = transactionalMessages.map((item) {
      if(extractMoneyAmount("${item.body}")?.replaceAll("AED", "")!=null) {
        return double.parse(
          "${extractMoneyAmount("${item.body}")?.replaceAll("AED", "").replaceAll(",","")}");
      }else{
        return 0.0;
      }
    }).sum;
    totalAmount= double.parse(totalAmount.toStringAsFixed(2));
    update();
  }
}
