import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms/src/screens/sms_fetcher/widgets/sms_permission_request.dart';
import 'package:collection/collection.dart';

import 'sms_fetcher_state.dart';

class SmsFetcherLogic extends GetxController with StateMixin<SmsFetcherState> {
  // list of sms messages
  List<SmsMessage>  allMessages =[];
  List<SmsMessage> transactionalMessages=[];
  SmsQuery query = SmsQuery();
  PermissionStatus smsPermissionStatus = PermissionStatus.denied;

  @override
  void onInit()async {
    change(null, status: RxStatus.loading());
   await requestSMSPermission();

    super.onInit();
  }

  requestSMSPermission() async {
     smsPermissionStatus = await Permission.sms.status;
    update();
    if (smsPermissionStatus.isDenied) {
      var result = await Get.dialog(const SmsPermissionRequestWidget());
      if (result == "Confirm") {
        await Permission.sms.request();
        smsPermissionStatus = await Permission.sms.status;
        if(smsPermissionStatus.isGranted){
          getSmsData();
        }else{
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
    }else{
      getSmsData();
    }
  }

  void getSmsData()async {
    allMessages=await query.getAllSms;
    allMessages= allMessages.where((element) => (element.kind==SmsMessageKind.received)&&(element.body!=null&&element.body!.contains("AED")),).toList();
    transactionalMessages =allMessages ;
    // allMessages.groupBy((event) => event.dateTime.toLocal().toIso8601String().substring(0,10));
    change(SMSLoadedSuccessfully(), status: RxStatus.success());
    update();
  }
}
