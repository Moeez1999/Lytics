import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {


  bool isLoading = true;
  List notificationsList = [];
  bool status = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;


  static CollectionReference notifications =
      FirebaseFirestore.instance.collection('Notifications');

  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onReady() async{
    await getNotificationData();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getNotificationData() async
  {
    notificationsList.clear();
    var data = await notifications.get();
    data.docs.forEach((element) {
      notificationsList.add(element.data());
    });
     update();
  }

  Future<void> getUpdateValue(String docId , bool v) async
  {
    print('Doc Id is $docId');
    await notifications.doc(docId).update({
      'isShow' : v
    });
  }





}
