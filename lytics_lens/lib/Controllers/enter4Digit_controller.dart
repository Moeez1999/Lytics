
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/Views/CreateNewPasswordScreen.dart';

class Enter4DigitController extends GetxController {
  bool isLoading = true;

  TextEditingController firstDigit = TextEditingController();
  TextEditingController secondDigit = TextEditingController();
  TextEditingController thirdDigit = TextEditingController();
  TextEditingController fourthDigit = TextEditingController();
  String otp = "";

  var resentcode;


  late NetworkController networkController;

  @override
  void onInit(){
    if(Get.isRegistered<NetworkController>())
    {
      networkController = Get.find<NetworkController>();
    }
    else
    {
      networkController = Get.put(NetworkController());
    }
    if(Get.arguments != null){
      resentcode = Get.arguments;
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


  void enterButton(){
    otp = firstDigit.text + secondDigit.text + thirdDigit.text + fourthDigit.text;
    print(otp);
    Get.to(() =>CreateNewPasswordScreen());
  }


}
