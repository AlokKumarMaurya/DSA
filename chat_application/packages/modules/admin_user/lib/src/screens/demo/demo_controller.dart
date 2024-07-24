import 'dart:developer';

import 'package:admin_user/src/models/user_data_model.dart';
import 'package:firebase_service/firebase_service.dart';
import 'package:network_service/network_service.dart';

class DemoController extends GetxController {
  @override
  void onInit() {
    createDb();
    super.onInit();
  }

  String collectionName = "USERS";

  ///create users
  ///REGISTER USER
  void createDb() async {
    await Future.delayed(const Duration(seconds: 5));

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref(collectionName);
    databaseReference.set(List.generate(
      10,
      (index) => Users(
          profile: "profile$index",
          chatList: List.generate(
            4,
            (index) => ChatList(
                senderDetail: SenderDetail(
                    name: "name",
                    phoneNumber: 2313123,
                    profileUrl: "profileUrl"),
                messages: List.generate(
                  10,
                  (index) => Message(
                      msg: "msg",
                      time: 2131231231231,
                      isByMe: index.isEven,
                      isRead: index.isOdd),
                )),
          )).toJson(),
    ));
   getUser();
  }

  void getUser() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref(collectionName);
    var data =
        (await databaseReference.get()).children.first.value as Map;
    Users users = Users.fromJson(data as Map<Object?,dynamic>);
    print(users.profile);
  }
}
