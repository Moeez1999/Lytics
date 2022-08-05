import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/utils/api.dart';
// import 'package:lytics_lens/views/enter4DigitCode.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Services/remoteconfig_service.dart';

class ForgotPasswordController extends GetxController {
  bool isLoading = true;


  RemoteConfigService remoteConfigService =  Get.find<RemoteConfigService>();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pin = TextEditingController();

  String lastcode = '';

  final storage = GetStorage();

  late Timer otptimer;
  int start = 60;

  late NetworkController networkController;

  @override
  void onInit() {
    if (Get.isRegistered<NetworkController>()) {
      networkController = Get.find<NetworkController>();
    } else {
      networkController = Get.put(NetworkController());
    }
    errorController = StreamController<ErrorAnimationType>();
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

  Future<void> forgotPassword() async {
    if (formkey.currentState!.validate()) {
      pin.clear();
      print("email is " + emailController.text);
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        print(url);
        var res = await http.post(Uri.parse(url + ApiData.forgot),
            body: {'email': emailController.text});
        print("status code is" + res.statusCode.toString());
        var data = jsonDecode(res.body);
        if (res.statusCode == 200) {
          storage.write('forgetemail', emailController.text);
          lastcode = data.toString();
          update();
          if (start == 0) {
            start = 60;
            startTimer();
          } else {
            start = 60;
            startTimer();
          }
        }
        print(data);
      } else {
        print("Check All data ");
        var res = await http.post(Uri.parse(ApiData.baseUrl + ApiData.forgot),
            body: {'email': emailController.text});
        print("status code is" + res.statusCode.toString());
        var data = jsonDecode(res.body);
        if (res.statusCode == 200) {
          lastcode = data.toString();
          update();
          if (start == 0) {
            start = 60;
            startTimer();
          } else {
            start = 60;
            startTimer();
          }
        }
        print(data);
      }
    }
  }

  void startTimer() {
    const onesec = const Duration(seconds: 1);
    otptimer = new Timer.periodic(onesec, (Timer timer) {
      if (start < 1) {
        timer.cancel();
      } else if (pin.text.isEmpty) {
        start = start - 1;
      } else if (pin.text.isNotEmpty) {
        start = start - 1;
      }
      update();
    });
  }
}
