import 'package:chat_module/src/domain/entity/chat_list_entity/get_all_chat_list_entity.dart';
import 'package:network_service/network_service.dart';

import '../../entity/chat_detail_list_entity/chat_detail_list_entity.dart';
import '../../repositories/chat_list_repo/chat_list_repo.dart';

class ChatUseCase {
  final ChatListRepo _repo = Get.find();

  Future<GetAllChatListEntity> getAllChatList({required String mobileNumber}) async {
    return await _repo.getAllChatList(mobileNumber: mobileNumber);
  }

  Future<ChatDetailListEntity> getChatDetailList({required int index,required String userId}) async{
    return await _repo.getChatDetailList(id:index,userId: userId);
  }

 Future<bool> sendMessage({required String message, required chatId, required String userId, required int receiverId}) async{
    return await _repo.sendMessage(message:message,chatId:chatId,userId:userId,receiverId:receiverId);
 }
}
