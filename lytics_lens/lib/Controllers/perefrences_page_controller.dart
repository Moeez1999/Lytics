import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Models/alltopicmodel.dart';
import 'package:lytics_lens/Models/datesmodel.dart';
import 'package:lytics_lens/Models/datesmodel1.dart';
import 'package:lytics_lens/utils/api.dart';

import '../Services/baseurl_service.dart';

class PreferencesPageController extends GetxController {
  bool isLoading = false;
  bool isExpanded = false;
  var currentindex;
  RxBool datecheckvalue = false.obs;
  TextEditingController startSearchDate = TextEditingController();
  TextEditingController endSearchDate = TextEditingController();
  var index;
  var filterlist1 = [].obs;
  List<AllTopicModel> programType = [];
  List<DatesModel1> alldatelist1 = [];
  var filterlist = [].obs;
  List<DatesModel> alldatelist = [];
  List filterProgramType = [];
  List topic = [];
  RxBool programcheckvalue = false.obs;
  List subtopics = [];
  List subtopics1 = [];
  final storage = GetStorage();
  DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
  DateTime week = DateTime.now().subtract(Duration(days: 7));
  DateTime quarter = DateTime.now().subtract(Duration(days: 15));
  DateTime now = DateTime.now();
  List datelist = [];

  BaseUrlService baseUrlService = Get.find<BaseUrlService>();

  @override
  void onInit() {
    datelist = [
      {
        'id': 'Today',
        'name': 'Today',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${now.year}-${now.month}-${now.day}',
      },
      {
        'id': 'Yesterday',
        'name': 'Yesterday',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${yesterday.year}-${yesterday.month}-${yesterday.day}',
      },
      {
        'id': 'This Week',
        'name': 'This Week',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${week.year}-${week.month}-${week.day}',
      },
      {
        'id': 'This Month',
        'name': 'This Month',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': now.month - 1 == 0
            ? '${now.year - 1}-12-${now.day}'
            : '${now.year}-${now.month - 1}-${now.day}',
      },
      {
        'id': 'This Quarter',
        'name': 'This Quarter',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${quarter.year}-${quarter.month}-${quarter.day}',
      },
      {
        'id': 'This Year',
        'name': 'This Year',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${now.year - 1}-${now.month}-${now.day}',
      },
    ];
    subtopics = [
      {
        'id': 'Economy',
        'name': 'Economy',
        'check': false,
      },
      {
        'id': 'Cryptocurrency',
        'name': 'Cryptocurrency',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Sugars Farms',
        'name': 'Sugars Farms',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Agriculture',
        'name': 'Agriculture',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Sugar Farms',
        'name': 'Sugar Farms',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Agriculture',
        'name': 'Agriculture',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Sugar Farms',
        'name': 'Sugar Farms',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Cryptocurrency',
        'name': 'Cryptocurrency',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Sugars Farms',
        'name': 'Sugars Farms',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Agriculture',
        'name': 'Agriculture',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Sugar Farms',
        'name': 'Sugar Farms',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Agriculture',
        'name': 'Agriculture',
        'check': false,
        'onTapcheck': false
      },
      {
        'id': 'Sugar Farms',
        'name': 'Sugar Farms',
        'check': false,
        'onTapcheck': false
      },
    ];

    subtopics1 = [
      {
        'id': 'Economy',
        'name': 'Economy',
        'check': false,
      },
      {'id': 'Cryptocurrency', 'name': 'Cryptocurrency', 'check': false},
      {'id': 'Sugars Farms', 'name': 'Sugars Farms', 'check': false},
      {'id': 'Agriculture', 'name': 'Agriculture', 'check': false},
      {'id': 'Sugar Farms', 'name': 'Sugar Farms', 'check': false},
      {'id': 'Agriculture', 'name': 'Agriculture', 'check': false},
      {'id': 'Sugar Farms', 'name': 'Sugar Farms', 'check': false},
      {'id': 'Cryptocurrency', 'name': 'Cryptocurrency', 'check': false},
      {'id': 'Sugars Farms', 'name': 'Sugars Farms', 'check': false},
      {'id': 'Agriculture', 'name': 'Agriculture', 'check': false},
      {'id': 'Sugar Farms', 'name': 'Sugar Farms', 'check': false},
      {'id': 'Agriculture', 'name': 'Agriculture', 'check': false},
      {'id': 'Sugar Farms', 'name': 'Sugar Farms', 'check': false},
    ];

    topic = [
      {
        'id': 'Economy',
        'name': 'Economy',
        'check': false,
      },
      {'id': 'Cryptocurrency', 'name': 'Cryptocurrency', 'check': false},
      {'id': 'Tier 2', 'name': 'Tier 2', 'check': false},
      {'id': 'Tier 3', 'name': 'Tier 3', 'check': false},
      {'id': 'Tier 4', 'name': 'Tier 4', 'check': false},
      // {'id': 'Tier 5', 'name': 'Tier 5', 'check': false},
      // {'id': 'Tier 6', 'name': 'Tier 6', 'check': false},
      // {'id': 'Tier 7', 'name': 'Tier 7', 'check': false},
      // {'id': 'Tier 8', 'name': 'Tier 8', 'check': false},
      // {'id': 'Tier 9', 'name': 'Tier 9', 'check': false},
    ];

    update();
    // ignore: unnecessary_statements
    currentindex;
    // ignore: unnecessary_statements
    index;
    super.onInit();
  }

  @override
  void onReady() async {
    await getProgramType();
    getdates();
    update();
    //??isLoading.value = false;

    super.onReady();
  }

  void getdates() {
    datelist.forEach((element) {
      print("All Dates $element");
      alldatelist.add(DatesModel.fromJSON(element));
      alldatelist1.add(DatesModel1.fromJSON(element));
    });
    update();
  }

  Future<void> getProgramType() async {
    print('Program Type Function');
    List responseprogramtyperesult = [];
    List responseprogramlist = [];
    programType.clear();
    responseprogramtyperesult.clear();
    try {
      String token = await storage.read("AccessToken");
      var res = await http
          .get(Uri.parse(baseUrlService.baseUrl + ApiData.programTypes), headers: {
        'Authorization': 'Bearer $token',
      });
      var response = json.decode(res.body);
      print('Programtype Response $response');
      responseprogramtyperesult.addAll(response['results']);
      responseprogramtyperesult.forEach((element) {
        responseprogramlist
            .add({'id': element['name'], 'name': element['name']});
        // programTypesList.add({"id": element['name'], "name": element['name']});
      });
      update();
      responseprogramlist.forEach((element) {
        programType.add(AllTopicModel.fromJSON(element));
      });
      update();
    } on SocketException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),
      //     isWarning: true);
    } catch (e) {
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
