import 'package:auth/auth.dart';
import 'package:chat_module/src/presentation/controller/chat_detail_list/chat_detail_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class ChatDetailListView extends StatelessWidget {
  const ChatDetailListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatDetailListController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              await controller.getChatDetailList();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        var data = controller.messages[index];
                        if (data.senderId ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          return Text(
                            data.msg,
                            textAlign: TextAlign.right,
                          );
                        } else {
                          return Text(
                            data.msg,
                            textAlign: TextAlign.left,
                          );
                        }
                      },
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    controller: controller.messageTextEditingController,
                    prefix: IconButton(
                        onPressed: () {
                          controller.sendMessage();
                        },
                        icon: const Icon(Icons.send)),
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    placeholder: "Message",
                    placeholderStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: CupertinoColors.placeholderText),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
