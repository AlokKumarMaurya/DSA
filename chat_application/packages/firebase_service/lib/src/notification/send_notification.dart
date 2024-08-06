import 'dart:convert';

import 'package:network_service/network_service.dart';

class NotificationManager {
  Future<bool> sendNotification(
      {required String receiversFCMToken,
      required String message,
      required String title}) async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ya29.a0AcM612xHUJb1noF2cXU3hrAlxZWMsNdPeYedYWRwYvmLeH6oL0vvnCgrPb5tEH7Fd9l14I3C9kkuOh-8ZM-7cWUbxOYFD1ZizkZYABIcfF8nvzxTh1do6PCm-v9hW6Tss4t2Cjzhs64cmzRv_8ngzOd8NqvBa9lolWWx-QaCgYKAaASARESFQHGX2MiJQVR75kQgMKKeUy34DuF4g0173'
      };

      var body = {
        "message": {
          "token": receiversFCMToken,
          "notification": {
            "body": message,
            "title": title,
          }
        }
      };

      await Network().post(
          body: json.encode(body),
          url:
              'https://fcm.googleapis.com/v1/projects/chat-application-ffd8c/messages:send',
          header: header);
      Get.snackbar("Success", "User has been notified for you message");
      return true;
    } catch (_) {
      Get.snackbar("Error", "Some error occurred");
      return false;
    }
  }
}
