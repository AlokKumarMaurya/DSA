import 'package:auth/auth.dart';
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
      getChatDetailList();
      getMessageStream();
    }
  }

  Future<void> getChatDetailList() async {
    return await _chatUseCase
        .getChatDetailList(
            chatId: _chatDetailListArgs!.chatId,
            userId: AppLocalStorage().getUserId())
        .then(
      (value) {
        messages = value.messages;
        update();
        return;
      },
    );
  }
  
  Future<void> getMessageStream() async {
        (await _chatUseCase
        .getMessagesStream(
            chatId: _chatDetailListArgs!.chatId,
            userId: AppLocalStorage().getUserId())).listen((event) {
              getChatDetailList();
            },);
  }

  Future<void> sendMessage() async {
    if (messageTextEditingController.text.isEmpty) return;
    await _chatUseCase.sendMessage(
        message: messageTextEditingController.text,
        chatId: _chatDetailListArgs!.chatId,
        userId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: _chatDetailListArgs!.senderDetail.id.toString());
    getChatDetailList();
  }
}

class ChatDetailListArgs {
  final String chatId;
  final SenderDetail senderDetail;
  final SenderDetail receiverDetail;

  ChatDetailListArgs(
      {required this.chatId,
      required this.senderDetail,
      required this.receiverDetail});
}
