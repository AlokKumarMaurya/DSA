import 'package:chat_module/src/presentation/controller/chat_detail_list/chat_detail_list_controller.dart';
import 'package:chat_module/src/presentation/controller/chat_list/chat_list_controller.dart';
import 'package:chat_module/src/utils/chat_routes/chat_route_name.dart';
import 'package:custom_widgets/app_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

import '../../../data/models/response/get_all_chat_list_response.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatListController>(builder: (chatListController) {
      return AppScaffold(
          isLoading: chatListController.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: Text(chatListController.userPhone),
            ),
            body: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                await chatListController.getChatList();
                return;
              },
              child: StreamBuilder<List<GetAllChatListResponse>>(
                  stream: chatListController.getChatListStream(),
                  initialData: chatListController.chatList,
                  builder: (context,
                      AsyncSnapshot<List<GetAllChatListResponse>> builder) {
                    // chatListController.getChatList();
                    return ListView.builder(
                      itemCount: chatListController.chatList.length,
                      itemBuilder: (context, index) {
                        var data = chatListController.chatList[index];
                        return ListTile(
                          onTap: () {
                            Get.toNamed(ChatRouteName.chatDetailListScreen,
                                arguments: ChatDetailListArgs(
                                    receiverDetail: data.receiverDetail,
                                    chatId: data.id,
                                    senderDetail: data.senderDetail));
                          },
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                shape: BoxShape.circle),
                            child: Image.network(
                              data.senderDetail.id,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person);
                              },
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.senderDetail.name.isEmpty
                                    ? data.senderDetail.phoneNumber.toString()
                                    : data.senderDetail.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(chatListController
                                  .chatList[index].lastMessage),
                            ],
                          ),
                          trailing:
                              Text(data.senderDetail.phoneNumber.toString()),
                        );
                      },
                    );
                  }),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: "Logout",
                    onPressed: () => chatListController.logoutUser(),
                    //chatListController.addNewUserToChat(),
                    child: const Icon(Icons.logout),
                  ),
                  FloatingActionButton(
                    heroTag: "Send Message",
                    onPressed: () => enterNumberBottomSheet(),
                    //chatListController.addNewUserToChat(),
                    child: const Icon(Icons.message),
                  ),
                ],
              ),
            ),
          ));
    });
  }

  void enterNumberBottomSheet() {
    Get.bottomSheet(
      Wrap(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CupertinoTextFormFieldRow(
                controller: Get.find<ChatListController>()
                    .newChatNumberTextEditingController,
                padding: const EdgeInsets.only(right: 20),
                prefix: IconButton(
                    onPressed: () => Get.find<ChatListController>()
                        .addNewUserToChat(
                            number: Get.find<ChatListController>()
                                .newChatNumberTextEditingController
                                .text),
                    icon: const Icon(Icons.send)),
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                placeholder: "Enter number to start chat",
                placeholderStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: CupertinoColors.placeholderText),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.grey.withOpacity(0.1),
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }
}
