import 'package:chat_module/src/domain/entity/chat_list_entity/get_all_chat_list_entity.dart';
import 'package:network_service/network_service.dart';

import '../../repositories/chat_list_repo/chat_list_repo.dart';

class ChatUseCase {
  final ChatListRepo _repo = Get.find();

  Future<GetAllChatListEntity> getAllChatList({required String mobileNumber}) async {
    return await _repo.getAllChatList(mobileNumber: mobileNumber);
  }
}
