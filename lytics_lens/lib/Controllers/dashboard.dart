import 'dart:collection';

import 'package:get/get.dart';
import 'package:lytics_lens/views/player_Screen.dart';

class DashboardController extends GetxController {

  int currentindex=0;
  ListQueue<int> navigationQueue =ListQueue();


  @override
  void onInit() {
    print('Dashboard Arrgument is ${Get.arguments}');
    if(Get.arguments != null)
    {
      print('Dashboard Arrgument is ${Get.arguments}');
      Get.to(() =>PlayerScreen(), arguments: {
        "id": Get.arguments.toString()});
    }
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }
// this is a very useless application made by hamza, hammad and moeez

  void changeTabIndex(int index) {
    currentindex = index;

    if(index == currentindex){
      navigationQueue.clear();
      // navigationQueue.removeWhere((element) => element == index);
      navigationQueue.addLast(index);
      currentindex = index;
      update();
      print('Current Index is $currentindex');
    }
    update();
    checkdata();
  }

  void checkdata(){
    navigationQueue.forEach((element) {
      print('Add Data in Queue $element');
    });
  }

}
