import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Controllers/home_controller.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:http/http.dart' as http;

import '../Constants/common_color.dart';
import '../Services/baseurl_service.dart';
import '../widget/snackbar/common_snackbar.dart';

class ClippingController extends GetxController
{
  bool isLoading = true;
  var isBottomLoading = false.obs;
  var isScreenLoading = true.obs;
  var nodata = false.obs;

  final storage = new GetStorage();
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController searchContact = TextEditingController();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  BaseUrlService baseUrlService = Get.find<BaseUrlService>();
  //<-------------- CompanyUser ----------------->

  var companyUser = [].obs;
  var searchcompanyUser = [].obs;
  var sharingUser = [].obs;

  String senderId = '';
  String senderFirstName = '';
  String senderLastName = '';


  @override
  void onInit() async{
    senderId = await storage.read('id');
    senderFirstName = await storage.read('firstName');
    senderLastName = await storage.read('lastName');
    super.onInit();
  }

  @override
  void onReady() async{
    await getCompanyUser();
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  Future<void> getCompanyUser() async {
    try {
      String token = await storage.read("AccessToken");
      String id = await storage.read('company_id');
      update();
      var res = await http.get(
          Uri.parse(baseUrlService.baseUrl + ApiData.companyuser + id),
          headers: {
            'Authorization': "Bearer $token",
          });
      var data = json.decode(res.body);
      data['users'].forEach((e) {
        companyUser.add(e);
      });
      Get.log("Company data from base url is $data");
      isLoading = false;
      update();
    } on SocketException catch (e) {
      print('Inter Connection Failed');
      isLoading = false;
      update();
      print(e);
    } catch (e) {
      isLoading = false;
      update();
    }

  }

  searchFunction(String v) {
    nodata.value = false;
    if (v.isEmpty || v == '') {
      searchcompanyUser.clear();
    } else {
      searchcompanyUser.clear();
      companyUser.forEach((e) {
        if (e['firstName'].toString().toLowerCase().contains(v.toLowerCase())) {
          searchcompanyUser.add(e);
        }
        else if (e['lastName']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchcompanyUser.add(e);
        }
        else if (e['firstName']
            .toString()
            .toLowerCase()
            .contains(v.split(' ').first.toLowerCase()) &&
            e['lastName'].toString().toLowerCase().contains(v.split(' ').last.toLowerCase())) {
          searchcompanyUser.add(e);
        }
      });
      if(searchcompanyUser.length == 0)
        {
          nodata.value = true;
        }
    }
  }

  String namesSplit(String n) {
    var f = n.split(' ').first;
    var l = n.split(' ').last;
    return '${f[0]} ${l[0]}';
  }

  String addDataList(String id) {
    var r = sharingUser.firstWhere((element) => element['recieverId'] == id,
        orElse: () => {'recieverId': 'nofound'});
    return r['recieverId'];
  }

  void deletedata(String id) {
    sharingUser.removeWhere((element) => element['recieverId'] == id);
  }

  Future<void> sharing(String jobId) async {
    var c = {"sharing": sharingUser , "share" : "true"};
    Get.log("Check Sharing data $c");
    isBottomLoading.value = true;
    try {
      String token = await storage.read("AccessToken");
      var res = await http.patch(
          Uri.parse(baseUrlService.baseUrl + ApiData.shareJobs + jobId),
          headers: {
            'Authorization': "Bearer $token",
            "Content-type": "application/json",
            "Accept": "application/json"
          },
          body: json.encode(c));
      var data = json.decode(res.body);
      Get.log('Shared Job Result is $data');
      if (res.statusCode == 200) {
        // await sharing();
        sharingUser.clear();
        searchContact.clear();
        homeScreenController.isLoading.value = true;
        await homeScreenController.getSentJobs();
        homeScreenController.isLoading.value = false;
        isBottomLoading.value = false;
        Get.back();
        Get.back();
        CustomSnackBar.showSnackBar(
            title: "Job shared successfully",
            message: "",
            isWarning: false,
            backgroundColor: CommonColor.greenColor);
      }
    } on SocketException catch (e) {
      print('Inter Connection Failed');
      isBottomLoading.value = false;
      update();
      print(e);
    } catch (e) {
      isBottomLoading.value = false;
      update();
    }
  }

}