import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms/src/screens/sms_fetcher/sms_fetcher_state.dart';

import 'sms_fetcher_logic.dart';

class SmsFetcherPage extends GetView<SmsFetcherLogic> {
  const SmsFetcherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) {
          if (state is SMSLoadedSuccessfully) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title:  const Text("SMS Fetcher",
                      style: TextStyle(color: Colors.black45)),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          hintText: 'Search SMS',
                        ),
                        onChanged: controller.onSearchInputChanged,
                      ),
                    ),
                  )),
              body: Stack(
                children: [
                  ListView.builder(
                    itemCount: controller.transactionalMessages.length,
                    itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${controller.transactionalMessages[index].sender}"),
                                Text(
                                    "${controller.transactionalMessages[index].dateSent?.toIso8601String().substring(0, 10)}")
                              ],
                            ),
                            const Divider(),
                            Text(
                                "${controller.transactionalMessages[index].body}"),
                            const Divider(),
                            Text(
                                "${controller.extractMoneyAmount('${controller.transactionalMessages[index].body}')} AED"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 80,
                        width: Get.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              "${controller.totalAmount} AED",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            );
          }
          return Container();
        },

        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Text('No data found'),

        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$error"),
              TextButton(
                  onPressed: controller.requestSMSPermissionAndGetData,
                  child: const Text("Retry"))
            ],
          ),
        ),
      ),
    );
  }
}
