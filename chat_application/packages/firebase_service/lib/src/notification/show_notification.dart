import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_storage/get_storage/get_storage.dart';

class ShowNotification {
  void getPermission({required StreamController controller}) async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      print("token ==> $token");
      _updateFcmInDataBase(token:token);
      AppLocalStorage().saveFcmToken(token: token ?? "");
    }
    _notificationListner(notificationStreamController: controller);
  }

  void _notificationListner(
      {required StreamController notificationStreamController}) {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Get.snackbar(message.notification?.title??"Title",message.notification?.body??'' );
      notificationStreamController.sink.add(message);
      showNotification();
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    showNotification();
    // Get.snackbar(message.notification?.title??"Title",message.notification?.body??'' );
  }

  initializePlatformSpecifics() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_notfication_icon');
    var ios = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        showNotification();
      },
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: ios);

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions();
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) =>
          showNotification(),
      onDidReceiveNotificationResponse: (details) => showNotification(),
    );
  }

  void showNotification() {}

  void _updateFcmInDataBase({String? token}) async{
    final CollectionReference usersChatCollectionReference =
    FirebaseFirestore.instance.collection('USER_PROFILE');
    (await usersChatCollectionReference.doc(FirebaseAuth.instance.currentUser?.uid).update({
      "fcmToken":token,
    }));
    // var dd = (data.data()) as Map;
  }
}
