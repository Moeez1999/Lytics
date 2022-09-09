import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Constants/app_strrings.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/widget/snackbar/common_snackbar.dart';
import 'package:lytics_lens/utils/api.dart';

import '../Services/baseurl_service.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool securetext = true;
  final storage = GetStorage();
  TextEditingController linkController = TextEditingController();
  BaseUrlService baseUrlService = Get.find<BaseUrlService>();
  final formKey = GlobalKey<FormState>();

  void onInit() async {
    print(storage.read('Url'));
    print(storage.read('email'));
    super.onInit();
  }

  Future<void> changePassword() async {
    print("i am in change password");
    try {
      String email = storage.read("email");
      var res = await http.post(
        Uri.parse(baseUrlService.baseUrl + ApiData.changePassword),
        body: {
          "email": email,
          "oldPassword": oldPassword.text,
          "newPassword": newPassword.text,
        },
      );
      // var data = json.decode(res.body);
      print(res.statusCode.toString());

      if (res.statusCode == 200) {
        await storage.write("pass", newPassword.text);
        Get.back();
        CustomSnackBar.showSnackBar(
          title: AppStrings.passwordChanged,
          message: "",
          backgroundColor: CommonColor.snackbarColour,
        );
      } else {
        CustomSnackBar.showSnackBar(
            title: AppStrings.passwordDoesNotMatch,
            message: "",
            backgroundColor: CommonColor.snackbarColour,
            isWarning: true);
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString().contains("SocketException"), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
