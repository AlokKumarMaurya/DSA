import 'package:chat_module/src/presentation/controller/chat_detail_list/chat_detail_list_controller.dart';
import 'package:chat_module/src/presentation/controller/chat_list/chat_list_controller.dart';
import 'package:chat_module/src/utils/chat_routes/chat_route_name.dart';
import 'package:custom_widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatListController>(builder: (chatListController) {
      return AppScaffold(
          isLoading: chatListController.isLoading,
          widget: Scaffold(
            appBar: AppBar(),
            body: RefreshIndicator(
              onRefresh: () async {
                await chatListController.getChatList();
                return;
              },
              child: Column(
                children: [
                  Text(chatListController.userPhone),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: chatListController.chatList.length,
                    itemBuilder: (context, index) {
                      var data = chatListController.chatList[index];
                      return ListTile(
                        onTap: () {
                          Get.toNamed(ChatRouteName.chatDetailListScreen,
                              arguments: ChatDetailListArgs(
                                  index: index,
                                  senderDetail: data.senderDetail));
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              shape: BoxShape.circle),
                          child: Image.network(
                            data.senderDetail.profileUrl,
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                chatListController.chatList[index].lastMessage),
                          ],
                        ),
                        trailing: Text(data.lastMessageTime.toString()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
