import 'package:get/get.dart';

import 'sms_fetcher_logic.dart';

class SmsFetcherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SmsFetcherLogic());
  }
}
