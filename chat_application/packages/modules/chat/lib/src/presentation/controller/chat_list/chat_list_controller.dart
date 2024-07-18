import 'package:chat_module/src/domain/usecase/chat_useCase/chat_useCase.dart';
import 'package:network_service/network_service.dart';

import '../../../domain/entity/chat_list_entity/get_all_chat_list_entity.dart';

class ChatListController extends GetxController {
  bool isLoading = false;
  List<AllChatListEntity> chatList = [];

  // final ChatUseCase _chatUseCase = Get.find();

  @override
  void onInit() {
    // _getChatList();
    super.onInit();
  }

  void _getChatList() async {
    // _chatUseCase.getAllChatList(mobileNumber: '6386506352').then(
    //   (value) {
    //     chatList = value.chatList;
    //     update();
    //   },
    // );
  }
}
