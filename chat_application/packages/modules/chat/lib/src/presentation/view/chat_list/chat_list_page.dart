import 'package:chat_module/src/presentation/controller/chat_list/chat_list_controller.dart';
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
            body: ListView.builder(
              itemCount: chatListController.chatList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(chatListController.chatList[index].name),
              ),
            ),
          ));
    });
  }
}
