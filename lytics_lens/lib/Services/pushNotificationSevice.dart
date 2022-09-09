
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

    // onMessage: When the app is open and it receives a push notification

  }
}
