import 'package:flutter/cupertino.dart';
import 'package:local_storage/get_storage/get_storage.dart';
import 'package:network_service/network_service.dart';

import '../../../domain/usecase/chat_useCase/chat_useCase.dart';

class ChatDetailListController extends GetxController {
  final ChatUseCase _chatUseCase = Get.find();
  List<Message> messages = [];
  final TextEditingController messageTextEditingController =
      TextEditingController();
  ChatDetailListArgs? _chatDetailListArgs;

  @override
  void onInit() {
    _getArguments();
    super.onInit();
  }

  void _getArguments() {
    var args = Get.arguments;
    if (args != null) {
      _chatDetailListArgs = args;
      getChatDetailList(index: _chatDetailListArgs!.index);
    }
  }

  Future<void> getChatDetailList({required int index}) async {
    return await _chatUseCase
        .getChatDetailList(index: index, userId: AppLocalStorage().getUserId())
        .then(
      (value) {
        messages = value.messages;
        update();
        return;
      },
    );
  }

  Future<void> sendMessage() async {
    if (messageTextEditingController.text.isEmpty) return;
    await _chatUseCase.sendMessage(
        message: messageTextEditingController.text,
        chatId: Get.arguments,
        userId: AppLocalStorage().getUserId(),
    receiverId:_chatDetailListArgs!.senderDetail.phoneNumber);
    getChatDetailList(index: Get.arguments);
  }
}

class ChatDetailListArgs {
  final int index;
  final SenderDetail senderDetail;

  ChatDetailListArgs({required this.index, required this.senderDetail});
}
