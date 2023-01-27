import 'package:get/get.dart';
import 'package:sms/src/screens/sms_fetcher/sms_fetcher_binding.dart';
import 'package:sms/src/screens/sms_fetcher/sms_fetcher_view.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

@override
  void onInit()async {

Future.delayed(const Duration(seconds: 2),() => Get.offAll(const SmsFetcherPage(),binding: SmsFetcherBinding()),);
    super.onInit();
  }
}
