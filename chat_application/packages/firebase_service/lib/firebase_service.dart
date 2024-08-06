library firebase_service;

export 'package:firebase_database/firebase_database.dart';
export 'src/notification/send_notification.dart';

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_service/src/firebase_options.dart';
import 'package:firebase_service/src/notification/show_notification.dart';

///Firebase service call
///call FirebaseService.init(); to initialize the firebase
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  static late final StreamController _notificationStreamController;

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  static Future<void> init(
      {required StreamController notificationStreamController}) async {
    _notificationStreamController = notificationStreamController;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _askForNotificationPermission();
    return;
  }


  static Future<void> _askForNotificationPermission() async {
    ShowNotification().getPermission(controller:_notificationStreamController);
  }


}
