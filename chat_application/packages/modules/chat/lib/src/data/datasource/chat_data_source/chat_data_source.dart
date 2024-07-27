import 'dart:math';

import 'package:auth/auth.dart';
import 'package:chat_module/src/data/models/response/get_all_chat_list_response.dart';
import 'package:firebase_service/firebase_service.dart';
import 'package:network_service/network_service.dart';

import '../../../domain/entity/chat_detail_list_entity/chat_detail_list_entity.dart';
import '../../../domain/entity/chat_list_entity/get_all_chat_list_entity.dart';

abstract class ChatDataSource {
  Future<GetAllChatListEntity> getAllChatList({required String phoneNumber});

  Future<ChatDetailListEntity> getChatDetailList(
      {required int chatId, required String userId});

  Future<bool> sendMessage(
      {required String message,
      required int chatId,
      required String userId,
      required int receiverId});
}

class ChatDataSourceImpl implements ChatDataSource {
  @override
  Future<GetAllChatListEntity> getAllChatList(
      {required String phoneNumber}) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("USERS");
    List<Object?> ds = [];
    for (var element in (await databaseReference.get()).children) {
      var data = element.value as Map;
      if (data["Profile"]["phoneNumber"] == phoneNumber) {
        ds = data["Chat-List"];
        break;
      }
    }
    List<GetAllChatListResponse> res = [];
    for (var element in ds) {
      element as Map;
      res.add(GetAllChatListResponse(
          senderDetail: SenderDetail.fromJson(element["Sender-Detail"]),
          lastMessage: element["messages"].last['msg'],
          lastMessageTime: element["messages"].last['time']));
    }
    return GetAllChatListEntity(message: "Data get success", chatList: res);
  }

  @override
  Future<ChatDetailListEntity> getChatDetailList(
      {required int chatId, required String userId}) async {
    List<Message> message = await _getMessages(chatId: chatId, userId: userId);
    return ChatDetailListEntity(
        messages: message, message: "Data get successfully");
  }

  Future<List<Message>> _getMessages(
      {required int chatId, required String userId}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref("USERS/$userId/Chat-List/$chatId/messages");
    var data = (await databaseReference.get()).value;
    return List<Message>.from((data as List).map((x) => Message.fromJson(x)));
  }

  @override
  Future<bool> sendMessage(
      {required String message,
      required int chatId,
      required String userId,
      required int receiverId}) async {
    List<Message> messageList =
        await _getMessages(chatId: chatId, userId: userId);
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref("USERS/$userId/Chat-List/$chatId/messages");
    int id = Random.secure().nextInt(10000000);
    (await databaseReference.update({
      messageList.length.toString(): Message(
              id: id,
              msg: message,
              time: DateTime.now().microsecondsSinceEpoch,
          senderId: FirebaseAuth.instance.currentUser!.uid,
              isRead: false)
          .toJson()
    }));
    await _addMessageToReceiverDataBase(
        messageId: id,
        message: message,
        chatId: chatId,
        userId: receiverId.toString(),
        receiverId: receiverId);
    return true;
  }

  Future<bool> _addMessageToReceiverDataBase(
      {required String message,
      required int chatId,
      required String userId,
      required int messageId,
      required int receiverId}) async {
    List<Message> messageList =
        await _getMessages(chatId: chatId, userId: userId);
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref("USERS/$userId/Chat-List/$chatId/messages");
    (await databaseReference.update({
      messageList.length.toString(): Message(
              id: messageId,
              msg: message,
              time: DateTime.now().microsecondsSinceEpoch,
          senderId: FirebaseAuth.instance.currentUser!.uid,
              isRead: false)
          .toJson()
    }));
    return true;
  }
}
