import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  RxBool networkStatus = true.obs;
  @override
  void onInit() {
    checkInternet();
    super.onInit();
  }

  checkInternet() {
    // ignore: cancel_subscriptions, unused_local_variable
    StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_print
            print('Data connection is available.');
            networkStatus.value = true;
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            print('You are disconnected from the internet.');
            networkStatus.value = false;
            break;
        }
      },
    );
  }
}
