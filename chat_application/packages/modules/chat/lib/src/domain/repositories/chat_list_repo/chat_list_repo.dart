import 'package:chat_module/src/domain/entity/chat_list_entity/get_all_chat_list_entity.dart';
import 'package:firebase_service/firebase_service.dart';

import '../../entity/chat_detail_list_entity/chat_detail_list_entity.dart';

abstract class ChatListRepo {
  Future<GetAllChatListEntity> getAllChatList({required String mobileNumber});

  Future<ChatDetailListEntity> getChatDetailList({required String id,required String userId});
  Future<Stream<DatabaseEvent>> getMessagesStream({required String id,required String userId});

 Future<bool> sendMessage({required String message, required String chatId, required String userId, required String receiverId});

 Future<bool> addNewUserToChatList({required String number, required String userId});
}
