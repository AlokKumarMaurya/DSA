import 'package:chat_module/src/domain/entity/chat_list_entity/get_all_chat_list_entity.dart';

import '../../entity/chat_detail_list_entity/chat_detail_list_entity.dart';

abstract class ChatListRepo {
  Future<GetAllChatListEntity> getAllChatList({required String mobileNumber});

  Future<ChatDetailListEntity> getChatDetailList({required int id,required String userId});

 Future<bool> sendMessage({required String message, required int chatId, required String userId, required int receiverId});
}
