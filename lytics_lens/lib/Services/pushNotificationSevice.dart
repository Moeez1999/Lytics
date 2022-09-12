
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Constants/constants.dart';

class PushNotificationService {

  final FirebaseMessaging _fcm;
  final storage = new GetStorage();

  PushNotificationService(this._fcm);

  Future initialise() async {

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

    // replacement for onResume: When the app is in the background and opened directly from the push notification.

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("Notification message Body ${message.data}");
      print("Notification message Body length${message.data.length}");
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1234,
          channelKey: 'basic_channel',
          title: "${message.notification!.title}",
          body: "${message.notification!.body}",
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: '${message.data["thumbnailPath"]}',
        ),
      );
      if (message.data["jobID"].toString().isNotEmpty ||
          message.data["jobID"].toString() != '') {
        print('JOB ID FOUND');
      } else {
        print('Not Job Id Found');
      }
    });

  }
}
