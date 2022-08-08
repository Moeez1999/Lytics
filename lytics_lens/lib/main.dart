import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Constants/constants.dart';
import 'package:lytics_lens/Services/pushNotificationSevice.dart';
import 'package:lytics_lens/views/dashboard_screen.dart';
import 'package:lytics_lens/views/login_screen.dart';
import 'package:resize/resize.dart';
import 'Services/remoteconfig_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await initService();
  
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
  );
  SystemChrome.setSystemUIOverlayStyle( 
    SystemUiOverlayStyle(
      statusBarColor: CommonColor.appBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: CommonColor.appBarColor,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(
      LensApp(),
    );
  });
}

Future<void> initService() async {
  RemoteConfigService remoteConfigService = RemoteConfigService();
  await Get.putAsync(() => remoteConfigService.init());
}

class LensApp extends StatelessWidget {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  final storage = new GetStorage();

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();
    print('Notification token ${Constants.token}');
    print(storage.hasData("AccessToken"));
    return Resize(
        allowtextScaling: false,
        builder: () {
          return GetMaterialApp(
            title: "Lytics Lens",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color.fromRGBO(27, 29, 40, 1),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Color.fromRGBO(242, 106, 50, 1),
              ),
            ),
            home: storage.hasData("AccessToken") == true
                ? Dashboard()
                : LoginScreen(),
          );
        });
  }
}
