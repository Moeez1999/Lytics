import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/widget/common_snackbar.dart';

import '../Services/remoteconfig_service.dart';

class CreatenewpasswordController extends GetxController {
  bool isLoading = true;
  String email = '';

  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  RemoteConfigService remoteConfigService =  Get.find<RemoteConfigService>();

  final formkey = GlobalKey<FormState>();

  bool securetext = true;
  bool securetext1 = true;

  final storage = GetStorage();

  @override
  void onInit() {
    if(Get.arguments != null)
    {
      email = Get.arguments.toString();
      update();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> createNewPassword() async {
    if (formkey.currentState!.validate()) {
      try {
        if (storage.hasData("Url") == true) {
          String url = storage.read("Url").toString();
          print(url);
          var data =
              await http.post(Uri.parse(url + ApiData.resetpassword), body: {
            'email': email,
            'newPassword': retypePasswordController.text,
          });
          if (data.statusCode == 200) {
            Get.back();
            Get.back();
            Get.back();
            CustomSnackBar.showSnackBar(
                title: 'Password updated successfully',
                message: "",
                backgroundColor: CommonColor.snackbarColour,
                isWarning: false);
          } else {
            print(data.body);
          }
        } else {
          print("email is "+ email);
          print('All Email is ${storage.read('forgetemail').toString()}');
          var data = await http
              .post(Uri.parse(ApiData.baseUrl + ApiData.resetpassword), body: {
            'email': email.toString(),
            'newPassword': retypePasswordController.text,
          });
          var res = json.decode(data.body);
          print('Data result is $res');
          print('Data Code is ${data.statusCode}');
          if (data.statusCode == 200) {
            Get.back();
            Get.back();
            Get.back();
            CustomSnackBar.showSnackBar(
                title: 'Password updated successfully',
                message: "",
                backgroundColor: CommonColor.snackbarColour,
                isWarning: false);
          } else {
            print(res);
          }
        }
      } catch (e) {
        CustomSnackBar.showSnackBar(
            title: e.toString(),
            message: "",
            backgroundColor: CommonColor.snackbarColour,
            isWarning: false);
      }
    }
  }
}
