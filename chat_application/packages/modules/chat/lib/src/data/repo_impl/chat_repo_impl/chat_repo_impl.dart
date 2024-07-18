import 'package:chat_module/src/domain/entity/chat_list_entity/get_all_chat_list_entity.dart';
import 'package:chat_module/src/domain/repositories/chat_list_repo/chat_list_repo.dart';
import 'package:network_service/network_service.dart';

import '../../datasource/chat_data_source/chat_data_source.dart';

class ChatRepoImpl implements ChatListRepo {
  final ChatDataSource _repo = Get.find();

  @override
  Future<GetAllChatListEntity> getAllChatList(
      {required String mobileNumber}) async {
    var data = await _repo.getAllChatList(phoneNumber: mobileNumber);
    return data;
  }
}
