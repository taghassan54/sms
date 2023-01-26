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
          print(state is SMSLoadedSuccessfully);
          if (state is SMSLoadedSuccessfully) {
            return ListView.builder(
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
                            Text("${controller.transactionalMessages[index].sender}"),
                            Text("${controller.transactionalMessages[index].dateSent?.toIso8601String().substring(0,10)}")
                          ],
                        ),
                        const Divider(),
                        Text("${controller.transactionalMessages[index].body}"),
                        Text("${controller.transactionalMessages[index].threadId}"),
                      ],
                    ),
              ),

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
        onError: (error) => Text("$error"),
      ),
    );
  }
}
