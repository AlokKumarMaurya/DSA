import 'package:chat_module/src/domain/entity/chat_list_entity/get_all_chat_list_entity.dart';


abstract class ChatListRepo {
  Future<GetAllChatListEntity> getAllChatList(
      {required String mobileNumber});
}
