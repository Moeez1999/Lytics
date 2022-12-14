import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Constants/constants.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/views/player_Screen.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  final storage = new GetStorage();

  PushNotificationService(this._fcm);

  Future initialise() async {
    if (Platform.isIOS) {
      // _fcm.requestNotificationPermissions(IosNotificationSettings());
      _fcm.requestPermission();
    }
    Constants.token = await _fcm.getToken();
    print("FirebaseMessaging token: ${Constants.token}");

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('getInitialMessage data: ${message.data}');
      }
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen(
      // var messagejobid = message.data["jobID"];

      (RemoteMessage message) {
        // Get.to(ChatScreen());
        FlutterAppBadger.updateBadgeCount(message.data.length);
        print("Notification message Body ${message.data}");
        print("Notification message Body length${message.data.length}");
        var messagejobid = message.data["jobID"];
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1234,
              channelKey: 'basic_channel',
              title: "${message.notification!.title}",
              body: "${message.notification!.body}",
              notificationLayout: NotificationLayout.BigPicture,
              //bigPicture: 'https://www.fluttercampus.com/img/logo_small.webp'),
              bigPicture: storage.hasData("Url")
                  ? '${storage.read("Url").toString()}/uploads/${message.data["thumbnailPath"]}'
                  : '${ApiData.thumbnailPath + message.data["thumbnailPath"]}'),
        );

        Get.snackbar(
            "${message.notification!.title}", "${message.notification!.body}",
            backgroundColor: CommonColor.snackbarColour, onTap: (value) {
          Get.to(() => PlayerScreen(),
              arguments: {"id": message.data["jobID"]});
          // var messagejobid = message.data["jobID"];
          // var messagejobid = message.data["jobID"];
        });
      },
    );

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // FlutterAppBadger.updateBadgeCount(message.data.length);
      print("Notification message Body ${message.data}");
      print("Notification message Body length${message.data.length}");

      if (message.data["jobID"].toString().isNotEmpty ||
          message.data["jobID"].toString() != '') {
        print('JOB ID FOUND');
        var messagejobid = message.data["jobID"];
      } else {
        print('Not Job Id Found');
      }
      // Get.toNamed("/${message.data["screen"]}");
    });
  }
}
