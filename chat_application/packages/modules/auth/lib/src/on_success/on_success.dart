import 'dart:math';

import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_service/firebase_service.dart';
import 'package:local_storage/get_storage/get_storage.dart';
import 'package:network_service/network_service.dart';

class OnAuthSuccess {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref("CHAT_LIST");

  ///REGISTER USER
  void createDb() async {
/*    FirebaseAuth.instance.currentUser!.uid;
    AppLocalStorage()
        .setUserId(userId: (await _getUserListLength()).toString());
    _databaseReference.update({
      "${(await _getUserListLength())}": Users(
        id: Random.secure().nextInt(10000000),
          profile: Profile(
            id: Random.secure().nextInt(10000000),
              name: FirebaseAuth.instance.currentUser?.displayName ?? "",
              phoneNumber:
                  FirebaseAuth.instance.currentUser?.phoneNumber ?? ""),
          chatList: List.generate(
            4,
            (index) => ChatList(
              id: Random.secure().nextInt(10000000),
                senderDetail: SenderDetail(
                    name: "name",
                    phoneNumber: 2313123,
                    profileUrl: "profileUrl"),
                messages: List.generate(
                  10,
                  (index) => Message(
                    id: Random.secure().nextInt(10000000),
                      msg: "msg",
                      time: 2131231231231,
                      isByMe: index.isEven,
                      isRead: index.isOdd),
                )),
          )).toJson(),
    });*/
    final CollectionReference profileCollectionReference =
        FirebaseFirestore.instance.collection('USER_PROFILE');
    final CollectionReference usersChatCollectionReference =
        FirebaseFirestore.instance.collection('USER_CHATS');
    try {
      ///add the profile data
      await profileCollectionReference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(Profile(
            name: "Alok",
            phoneNumber:
                FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
            id: FirebaseAuth.instance.currentUser!.uid,
          ).toJson());

      ///add the usersChat data that has the joins between the userTable and the chatList table
      await usersChatCollectionReference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(UserChats(
            chatId: [(await _getUserListLength()).toString()],
            userId: FirebaseAuth.instance.currentUser!.uid,
          ).toJson());

      ///create chats for demo in the current user account in RealTime DB
      _databaseReference.update({
        "${await _getUserListLength()}": List.generate(
          10,
          (index) => Message(
                  id: index,
                  msg: "msg",
                  time: DateTime.now().microsecondsSinceEpoch,
                  senderId: index.isOdd
                      ? FirebaseAuth.instance.currentUser!.uid
                      : "DEMO_ID",
                  isRead: false)
              .toJson(),
        )
      });
    } catch (_) {}
  }

  Future<int> _getUserListLength() async {
    return (await _databaseReference.get()).children.length;
  }
}
