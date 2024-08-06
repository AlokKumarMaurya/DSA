import 'dart:math';

import 'package:auth/auth.dart';
import 'package:chat_module/src/data/models/response/get_all_chat_list_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_service/firebase_service.dart';
import 'package:network_service/network_service.dart';

import '../../../domain/entity/chat_detail_list_entity/chat_detail_list_entity.dart';
import '../../../domain/entity/chat_list_entity/get_all_chat_list_entity.dart';

abstract class ChatDataSource {
  Future<GetAllChatListEntity> getAllChatList({required String userId});

  Future<ChatDetailListEntity> getChatDetailList(
      {required String chatId, required String userId});
  Future<Stream<DatabaseEvent>> getMessagesStream(
      {required String chatId, required String userId});

  Future<bool> sendMessage(
      {required String message,
      required String chatId,
      required String userId,
      required String receiverId});

  Future<bool> addNewUserToChat({required String number});
}

class ChatDataSourceImpl implements ChatDataSource {
  @override
  Future<GetAllChatListEntity> getAllChatList({required String userId}) async {
    final CollectionReference usersChatCollectionReference =
        FirebaseFirestore.instance.collection('USER_CHATS');
    //getting all chat IDs
    List oldIds = (await usersChatCollectionReference.doc(userId).get())
        .get("chatId") as List;

    List<GetAllChatListResponse> res = [];
    for (String id in oldIds) {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("CHAT_LIST/$id");
      var data = (await databaseReference.get());
      //last message of this chat
      Map map = ((data.value) as List).last as Map;
      String messageSenderID = map["senderId"];
      String receiverId = map["receiverId"];
      var senderDetail = await _getUserProfile(userId: messageSenderID);
      var receiverDetail = await _getUserProfile(userId: receiverId);
      res.add(FirebaseAuth.instance.currentUser!.uid == receiverDetail.id
          ? GetAllChatListResponse(
              receiverDetail: receiverDetail,
              id: id,
              senderDetail: senderDetail,
              lastMessageTime: map["time"],
              lastMessage: map["msg"])
          : GetAllChatListResponse(
              receiverDetail: senderDetail,
              id: id,
              senderDetail: receiverDetail,
              lastMessageTime: map["time"],
              lastMessage: map["msg"]));
    }
    return GetAllChatListEntity(message: "Data get success", chatList: res);
  }

  @override
  Future<ChatDetailListEntity> getChatDetailList(
      {required String chatId, required String userId}) async {
    List<Message> message = await _getMessages(
      chatId: chatId,
    );
    return ChatDetailListEntity(
        messages: message, message: "Data get successfully");
  }
  @override
  Future<Stream<DatabaseEvent>> getMessagesStream(
      {required String chatId, required String userId}) async {
    return _getMessagesStream(chatId: chatId);
  }

  Future<List<Message>> _getMessages({required String chatId}) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("CHAT_LIST/$chatId");
    databaseReference.onValue;
    var data = (await databaseReference.get()).value;
    return List<Message>.from((data as List).map((x) => Message.fromJson(x)));
  }

  Future<Stream<DatabaseEvent>> _getMessagesStream(
      {required String chatId}) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("CHAT_LIST/$chatId");
    return databaseReference.onValue;
  }

  @override
  Future<bool> sendMessage(
      {required String message,
      required String chatId,
      required String userId,
      required String receiverId}) async {
    List<Message> messageList = await _getMessages(chatId: chatId);
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("CHAT_LIST/$chatId");
    int id = Random.secure().nextInt(10000000);
    (await databaseReference.update({
      messageList.length.toString(): Message(
              receiverId: receiverId,
              id: id,
              msg: message,
              time: DateTime.now().microsecondsSinceEpoch,
              senderId: FirebaseAuth.instance.currentUser!.uid,
              isRead: false)
          .toJson()
    }));
    //send notification
    String receiversFCMToken =
        (await _getUserProfile(userId: receiverId)).fcmToken;
    NotificationManager().sendNotification(
        receiversFCMToken: receiversFCMToken,
        message: message,
        title: "New Message");
    return true;
  }

  @override
  Future<bool> addNewUserToChat({required String number}) async {
    final CollectionReference usersProfileCollectionReference =
        FirebaseFirestore.instance.collection('USER_PROFILE');

    var temp =
        (await usersProfileCollectionReference.get()).docs.firstWhereOrNull(
      (element) {
        return element.get("phoneNumber") == number;
      },
    );
    if (!(temp?.exists ?? false)) return false;
    String receiverId = await temp!.get("id");

    //add data to sender chat list ids
    final CollectionReference usersChatCollectionReference =
        FirebaseFirestore.instance.collection('USER_CHATS');
    List oldIds = (await usersChatCollectionReference
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .get("chatId") as List;
    //CREATE A NEW CHAT AND GET THE ID FROM THERE
    String chatId = (await _createEmptyChatAndGetId(
            userId: FirebaseAuth.instance.currentUser!.uid,
            receiverId: receiverId))
        .toString();
    oldIds.add(chatId);
    await usersChatCollectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "chatId": oldIds,
    });
    await _addToReceiverChatList(receiverPhoneNumber: number, chatId: chatId);
    return true;
  }

  Future<int> _createEmptyChatAndGetId(
      {required String userId, required String receiverId}) async {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("CHAT_LIST");
    int len = (await databaseReference.get()).children.length;
    databaseReference.update({
      "$len": [
        Message(
          id: 0,
          msg: "Hey there let's chat",
          time: DateTime.now().microsecondsSinceEpoch,
          senderId: userId,
          receiverId: receiverId,
          isRead: false,
        ).toJson()
      ]
    });
    return len;
  }

  Future<String> _addToReceiverChatList(
      {required String receiverPhoneNumber, required String chatId}) async {
    final CollectionReference usersProfileCollectionReference =
        FirebaseFirestore.instance.collection('USER_PROFILE');
    String receiverId =
        (await usersProfileCollectionReference.get()).docs.firstWhere(
      (element) {
        return element.get("phoneNumber") == receiverPhoneNumber;
      },
    ).get("id");
    String receiverFcmToken =
        (await usersProfileCollectionReference.get()).docs.firstWhere(
      (element) {
        return element.get("phoneNumber") == receiverPhoneNumber;
      },
    ).get("fcmToken");

    final CollectionReference usersChatCollectionReference =
        FirebaseFirestore.instance.collection('USER_CHATS');
    List oldIds = [];
    try {
      oldIds = (await usersChatCollectionReference.doc(receiverId).get())
          .get("chatId");
      oldIds.add(chatId);
      await usersChatCollectionReference.doc(receiverId).update({
        "chatId": oldIds,
      });
    } catch (e) {
      oldIds.add(chatId);
      await usersChatCollectionReference.doc(receiverId).set({
        "chatId": oldIds,
      });
    }

    return receiverFcmToken;
  }

  Future<SenderDetail> _getUserProfile({required String userId}) async {
    //add data to sender chat list ids
    final CollectionReference usersChatCollectionReference =
        FirebaseFirestore.instance.collection('USER_PROFILE');
    var data = (await usersChatCollectionReference.doc(userId).get());
    var dd = (data.data()) as Map;
    return SenderDetail.fromJson(dd);
  }
}
