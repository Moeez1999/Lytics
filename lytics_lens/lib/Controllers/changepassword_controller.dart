import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Constants/app_strrings.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/widget/common_snackbar.dart';
import 'package:lytics_lens/utils/api.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool securetext = true;
  final storage = GetStorage();
  TextEditingController linkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void onInit() async {
    print(storage.read('Url'));
    print(storage.read('email'));
    // print("Check ${storage.read("Url").toString()}");
    if (storage.hasData("Url")) {
      String url = storage.read("Url");
      linkController.text = url;
      update();
    } else {
      linkController.text = ApiData.baseUrl;
      update();
    }
    super.onInit();
  }

  Future<void> changePassword() async {
    print("i am in change password");
    String email = storage.read("email");
    //print("email is "+email);

    String url = storage.read("Url").toString();

    try {
      if (storage.hasData("Url") == true) {
        var res = await http.post(
          Uri.parse(url + ApiData.changePassword),
          body: {
            "email": email,
            "oldPassword": oldPassword.text,
            "newPassword": newPassword.text,
            //'forced': false.toString(),
          },
        );
        print(res.statusCode.toString());
        // var data = json.decode(res.body);
        if (res.statusCode == 200) {
          await storage.write("pass", newPassword.text);
          Get.back();
          CustomSnackBar.showSnackBar(
              title: AppStrings.passwordChanged,
              message: "",
              backgroundColor: CommonColor.snackbarColour,
              isWarning: true);
        } else {
          CustomSnackBar.showSnackBar(
              title: AppStrings.passwordDoesNotMatch,
              message: "",
              backgroundColor: CommonColor.snackbarColour,
              isWarning: true);
        }
      } else {
        print(ApiData.baseUrl);
        String email = storage.read("email");

        var res = await http.post(
          Uri.parse(ApiData.baseUrl + ApiData.changePassword),
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
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString().contains("SocketException"), backgroundColor: Colors.red, colorText: Colors.white);

    }
  }
}
