import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Controllers/home_controller.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:http/http.dart' as http;

import '../Constants/common_color.dart';
import '../widget/common_snackbar.dart';

class ClippingController extends GetxController
{
  bool isLoading = true;
  var isBottomLoading = false.obs;
  final storage = new GetStorage();
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController searchContact = TextEditingController();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
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
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        String id = await storage.read('company_id');
        companyUser.clear();
        var res =
        await http.get(Uri.parse(url + ApiData.companyuser + id), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);

        data['users'].forEach((e) {
          companyUser.add(e);
        });
        Get.log("Company data is $data");
        isLoading = false;
        update();
      } else {
        String token = await storage.read("AccessToken");
        String id = await storage.read('company_id');
        update();
        var res = await http.get(
            Uri.parse(ApiData.baseUrl + ApiData.companyuser + id),
            headers: {
              'Authorization': "Bearer $token",
            });
        var data = json.decode(res.body);
                //companyUser.add("Everyone");

        data['users'].forEach((e) {
          companyUser.add(e);
        });
        Get.log("Company data from base url is $data");
        isLoading = false;
        update();
      }
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
    if (v.isEmpty || v == '') {
      searchcompanyUser.clear();
    } else {
      searchcompanyUser.clear();
      companyUser.forEach((e) {
        if (e['firstName'].toString().toLowerCase().contains(v.toLowerCase())) {
          searchcompanyUser.add(e);
        } else if (e['lastName']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchcompanyUser.add(e);
        }
      });
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
    var c = {"sharing": sharingUser};
    Get.log("Check Sharing data $c");
    isBottomLoading.value = true;
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.patch(Uri.parse(url + ApiData.shareJobs + jobId),
            headers: {
              'Authorization': "Bearer $token",
              "Content-type": "application/json",
              "Accept": "application/json"
            },
            body: json.encode(c));
        var data = json.decode(res.body);
        if (res.statusCode == 200) {
          sharingUser.clear();
          homeScreenController.isLoading.value = true;
          await homeScreenController.getReceiveJob();
          homeScreenController.isLoading.value = false;
          Get.back();
          isBottomLoading.value = false;
          CustomSnackBar.showSnackBar(
              title: "Job shared successfully",
              message: "",
              isWarning: false,
              backgroundColor: CommonColor.greenColor);
        }
        Get.log('Result is $data');
      } else {
        String token = await storage.read("AccessToken");

        var res = await http.patch(
            Uri.parse(ApiData.baseUrl + ApiData.shareJobs + jobId),
            headers: {
              'Authorization': "Bearer $token",
              "Content-type": "application/json",
              "Accept": "application/json"
            },
            body: json.encode(c));
        var data = json.decode(res.body);
        Get.log('Result is $data');
        if (res.statusCode == 200) {
          // await sharing();
          sharingUser.clear();
          searchContact.clear();
          homeScreenController.isLoading.value = true;
          await homeScreenController.getReceiveJob();
          homeScreenController.isLoading.value = false;
          Get.back();
          isBottomLoading.value = false;
          CustomSnackBar.showSnackBar(
              title: "Job shared successfully",
              message: "",
              isWarning: false,
              backgroundColor: CommonColor.greenColor);
        }
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