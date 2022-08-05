import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/Models/alltopicmodel.dart';
import 'package:lytics_lens/utils/api.dart';

class SearchBarController extends GetxController {
  bool isLoading = true;

  final storage = new GetStorage();
  static CollectionReference headline =
      FirebaseFirestore.instance.collection('Headline');

  List headlinelist = [];

  List allData = [];
  List topic2allData = [];

  List topiclist = [];
  List topic2list = [];
  List topic3list = [];
  List<AllTopicModel> alltopic = [];

  List searchtopiclist = [];

  TextEditingController searchText = TextEditingController();

  bool isShowList = false;
  bool isHeadline = false;
  bool isSocket = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading = false;
    await gettopic();
    getHeadlines();
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  searchFunction(String v) {
    searchtopiclist.clear();
    topiclist.forEach((e) {
      if (e['name'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchtopiclist.add(e);
        print('check $e');
      }
      update();
    });
  }

  Future<void> getHeadlines() async {
    isHeadline = true;
    headlinelist.clear();
    update();
    try {
      Stream<QuerySnapshot> data = headline.snapshots();
      await data.forEach((e) {
        headlinelist.clear();
        for (var value in e.docs) {
          headlinelist.add(value.data());
        }
        isHeadline = false;
        update();
      }).catchError((e) {
        // CustomSnackBar.showSnackBar(title: AppStrings.unable, message: "", backgroundColor: Color(0xff48beeb));
      });
    } on FirebaseException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(title: AppStrings.unable, message: "", backgroundColor: Color(0xff48beeb));
    }
  }

  Future<void> gettopic() async {
    try {
      isSocket = false;
      update();
      String token = await storage.read("AccessToken");
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        var res = await http.get(Uri.parse(url + ApiData.topic), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);
        topiclist.addAll(data['results']);
        update();
      } else {
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.topic), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);
        Get.log('Data is $data');
        // print('Data is $data');
        allData.addAll(data['results']);
        update();
        allData.forEach((e) {
          topiclist.add({'id': e['name'], 'name': e['name']});
          e['topic2'].forEach((a) {
            topic2allData.add(a);
          });
        });
        update();
        topic2allData.forEach((element) {
          topiclist.add({'id': element['name'], 'name': element['name']});
          element['topic3'].forEach((a) {
            topic3list.add(a);
          });
        });
        update();
        topic3list.forEach((q) {
          topiclist.add({'id': q['name'], 'name': q['name']});
        });
        update();
        topiclist = Set.of(topiclist).toList();
        update();
        topiclist.forEach((w) {
          alltopic.add(AllTopicModel.fromJSON(w));
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      isLoading = false;
      isSocket = true;
      update();
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      print(e.toString());
    }
  }
}
