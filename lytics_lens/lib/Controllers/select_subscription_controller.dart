import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/Services/internetcheck.dart';

import '../Models/subscriptionmodel.dart';
import '../Services/baseurl_service.dart';
import '../utils/api.dart';

class SelectSubscriptionController extends GetxController {
  List intelligence = [];

  RxBool isShownContaine = false.obs;
  List<String> child = [];
  List alltopic = [];
  var filterlist = [];
  List reportTiming = [];
  List subValues = [];
  List filterlist1 = [].obs;

  Map ch = {};
  Map selectintelligence = {};
  Map allData = {};

  final TreeController treeController = TreeController(allNodesExpanded: false);
  BaseUrlService baseUrlService = Get.find<BaseUrlService>();

  List<Map<String, dynamic>> check = [];
  List<Map<String, dynamic>> check1 = [];
  List<Map<String, dynamic>> subscriptionSelectList = [];

  final storage = new GetStorage();
  var result;
  List filter = [];

  List<Subscription> subscriptionList = [];
  List<SourceValue> sourceList = [];

  List<String> parentList = [];
  List<String> childList = [];

  String key = '';

  var temp = [];
  TextEditingController controller = TextEditingController();
  TextEditingController reportTimeController =
      TextEditingController(text: '60');
  late NetworkController networkController;

  void onInit() async {
    if (Get.isRegistered<NetworkController>()) {
      networkController = Get.find<NetworkController>();
    } else {
      networkController = Get.put(NetworkController());
    }
    intelligence = [
      {'name': 'Transcription', 'check': false},
      {'name': 'Translation', 'check': false},
      {'name': 'Sentiment', 'check': false},
      {'name': 'Speaker Recognition', 'check': false},
    ];
    reportTiming = [
      {'timming': '24 Hours', 'check': false, 'min': '1440'},
      {'timming': '12 Hours', 'check': false, 'min': '720'},
      {'timming': '6 Hours', 'check': false, 'min': '360'},
      {'timming': '3 Hours', 'check': false, 'min': '180'},
      {'timming': '1 Hour', 'check': false, 'min': '60'},
    ];

    await getUserInformation();
    update();

    super.onInit();
  }

  Future<void> getUserInformation() async {
    temp.clear();
    filter.clear();
    String token = await storage.read("AccessToken");
    String id = await storage.read("id");
    print("Current User Id is $id");

    var res = await http.get(
        Uri.parse(baseUrlService.baseUrl + ApiData.getUserInformation + id),
        headers: {
          'Authorization': "Bearer $token",
        });
    var data = json.decode(res.body);

    Get.log("All Data $data");
    Map response = data["subscription"];

    checkMap(response);

    update();
  }

  void checkMap(Map a) {
    subValues.clear();
    update();
    a.entries.forEach((element) {
      print("Hello World ${element.value.toString().length}");
      if (element.value.toString().length != 2) {
        print("Hello World True ");
        element.value.forEach((e) {
          print("Data is  $e");
          subValues.add({
            "sValues": e,
            // "sCheck": false,
          });
        });
      } else {
        subValues = [];
      }

      check.add({
        'source': element.key,
        'source_value': subValues,
      });
    });

    for (int i = 0; i < check.length; i++) {
      print("The rollah is  ${check[i]}");
      filter.add({
        'source': check[i]['source'],
        'source_value':
            check[i]['source'] == 'socialMedia' ? [] : check[i]['source_value']
      });
    }

    for (int i = 0; i < filter.length; i++) {
      subscriptionList.add(Subscription.fromJson(filter[i]));
    }
    update();
  }

  void addDataInList(String c, List b) {
    ch.addAll({'$c': b});
    subscriptionSelectList.add({'$c': b});
    update();
    print("Key Is $c");
  }

  void show() {
    subscriptionSelectList.forEach((element) {
      // print("Values Is $element");
    });
    print("Values Is $ch");
    print("Intelligence is $selectintelligence");

    allData.addAll({
      "subscription": ch,
      "intelligence": selectintelligence,
      "reportTiming": reportTimeController.text
    });
    update();

    print("All Data is $allData");
  }

  Future<void> sendData() async {
    String token = await storage.read("AccessToken");
    // var d = json.encode(allData);
    String id = storage.read("id");
    print("Current User Id is $id");
    print("Current User Token is $token");
    var res = await http.patch(
      Uri.parse(baseUrlService.baseUrl + ApiData.getUserInformation + id),
      body: json.encode({'escalations': allData, 'device': 'mobile'}),
      headers: {
        'Authorization': "Bearer $token",
      },
    );
    print('Job Request is ${res.body}');
  }
}
