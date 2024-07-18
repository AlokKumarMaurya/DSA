import 'package:chat_module/src/data/models/response/get_all_chat_list_response.dart';
import 'package:firebase_service/firebase_service.dart';

import '../../../domain/entity/chat_list_entity/get_all_chat_list_entity.dart';

abstract class ChatDataSource{
  Future<GetAllChatListEntity> getAllChatList({required String phoneNumber});
}


class ChatDataSourceImpl implements ChatDataSource{
  @override
  Future<GetAllChatListEntity> getAllChatList({required String phoneNumber}) async{

    // DatabaseReference starCountRef =
    // FirebaseDatabase.instance.ref(FirebaseConst.chatKey.collectionName);
    // starCountRef.get();
    return GetAllChatListEntity(message: "message", chatList: []);
  }

}