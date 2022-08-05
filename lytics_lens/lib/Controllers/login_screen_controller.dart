import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/Constants/app_strrings.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Constants/constants.dart';
import 'package:lytics_lens/widget/common_snackbar.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/views/dashboard_screen.dart';
import 'package:local_auth/local_auth.dart';

import '../Services/remoteconfig_service.dart';

class LoginScreenController extends GetxController {
  final formkey = GlobalKey<FormState>();

  late NetworkController networkController;

  RemoteConfigService remoteConfigService = Get.find<RemoteConfigService>();

  bool isLoading = false;
  bool isAuth = false;
  bool? hasBioScreen;

  bool securetext = true;
  List<BiometricType>? availableAuth;

  LocalAuthentication authentication = LocalAuthentication();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final storage = new GetStorage();

  bool forced = true;
  bool appToken = true;
  String userId = '';
  FocusNode node = new FocusNode();

  @override
  void onInit() async {
    print(
        'All Remote Text is ${remoteConfigService.remoteConfig.getString('biometric')}');

    node.addListener(() {
      if (!node.hasFocus) {
        formatNickname();
      }
    });
    if (Get.isRegistered<NetworkController>()) {
      networkController = Get.find<NetworkController>();
    } else {
      networkController = Get.put(NetworkController());
    }

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

  void formatNickname() {
    userNameController.text = userNameController.text.replaceAll(" ", "");
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

  Future<void> verifyEmailPassword() async {
    if (formkey.currentState!.validate()) {
      try {
        if (storage.hasData("Url") == true) {
          String url = storage.read("Url");
          print(url);
          var res = await http.post(
            Uri.parse(url + ApiData.login),
            body: {
              'email': userNameController.text,
              'password': passwordController.text,
              'forced': 'APP',
            },
          );
          var data = json.decode(res.body);
          var userdata = data["user"];
          Constants.subscription = data["subscription"];

          var accesstoken = data["tokens"]["access"];
          var token = data["tokens"]["refresh"];
          await storage.write("RefreshToken", token["token"]);
          await storage.write("UsersChannels", userdata['channels']);
          await storage.write("AccessToken", accesstoken["token"]);
          print(res.body);
          print(res.statusCode);
          if (isAuth) {
            print('Password is ${passwordController.text}');
            await storage.write("email", userNameController.text);
            await storage.write("pass", passwordController.text);
            await storage.write("id", userdata['id']);
            await storage.write("firstName", userdata['firstName']);
            await storage.write("lastName", userdata['lastName']);
            await storage.write("company_id", userdata['company']['id']);
            print('Password is Storage ${storage.read('pass')}');
            Get.offAll(() => Dashboard());
          } else {
            await storage.write("id", userdata['id']);
            await storage.write("firstName", userdata['firstName']);
            await storage.write("lastName", userdata['lastName']);
            await storage.write("email", userNameController.text);
            await storage.write("company_id", userdata['company']['id']);
            Get.offAll(() => Dashboard());
          }
        } else {
          print(ApiData.baseUrl);
          var res = await http.post(
            Uri.parse(ApiData.baseUrl + ApiData.login),
            body: {
              'email': userNameController.text,
              'password': passwordController.text,
              //'forced': false.toString(),f
              'forced': 'APP',
            },
          );
          var data = json.decode(res.body);
          var userdata = data["user"];
          var accesstoken = data["tokens"]["access"];
          var token = data["tokens"]["refresh"];
          await storage.write("RefreshToken", token["token"]);
          await storage.write("UsersChannels", userdata['channels']);
          await storage.write("AccessToken", accesstoken["token"]);
          await storage.write("Subscription", userdata['subscription']);
          Get.log('Result is ${res.body}');
          print(res.statusCode);
          if (isAuth) {
            print('Password is ${passwordController.text}');
            await storage.write("email", userNameController.text);
            await storage.write("pass", passwordController.text);
            await storage.write("id", userdata['id']);
            await storage.write("firstName", userdata['firstName']);
            await storage.write("lastName", userdata['lastName']);
            await storage.write("company_id", userdata['company']['id']);
            print('Password is Storage ${storage.read('pass')}');
            Get.offAll(() => Dashboard());
          } else {
            await storage.write("id", userdata['id']);
            await storage.write("firstName", userdata['firstName']);
            await storage.write("lastName", userdata['lastName']);
            await storage.write("email", userNameController.text);
            await storage.write("company_id", userdata['company']['id']);
            Get.offAll(() => Dashboard());
          }
        }
      } on SocketException catch (e) {
        print(e);
        CustomSnackBar.showSnackBar(
            title: AppStrings.interneterror,
            message: "",
            isWarning: true,
            backgroundColor: CommonColor.snackbarColour);
      } catch (e) {
        // Get.snackbar('Error', e.toString().contains("SocketException"), backgroundColor: Colors.red, colorText: Colors.white);
        if (e.toString().contains("access")) {
          CustomSnackBar.showSnackBar(
              title: AppStrings.inncorrectUsername,
              message: "",
              backgroundColor: CommonColor.snackbarColour,
              isWarning: true);
        }
        // e.toString().contains("SocketException")?Get.snackbar("", message)
      }
    }
  }

  Future<void> getUrl() async {
    await storage.write("Url", linkController.text);
    Get.back();
    Get.back();
    CustomSnackBar.showSnackBar(
        title: AppStrings.urlUpdated,
        message: "",
        backgroundColor: CommonColor.snackbarColour);
  }

  Future<void> checkBio() async {
    try {
      hasBioScreen = await authentication.canCheckBiometrics;
      if (hasBioScreen!) {
        getAuth();
      }
      print(hasBioScreen);
    } catch (e) {
      CustomSnackBar.showSnackBar(
          title: AppStrings.unable,
          message: "",
          backgroundColor: CommonColor.snackbarColour);
    }
  }

  Future<void> getAuth() async {
    print(storage.read('email'));
    print(storage.read('pass'));
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await authentication.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face) ||
          availableBiometrics.contains(BiometricType.fingerprint)) {
        isAuth = await authentication.authenticate(
          localizedReason: "Scan your Face/Finger to access the app",
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        );
        if (isAuth) {
          if (storage.hasData('email') == false &&
              storage.hasData('pass') == false) {
            CustomSnackBar.showSnackBar(
                title: AppStrings.fingerPrintError,
                message: "",
                backgroundColor: CommonColor.snackbarColour);
          } else {
            print('PasswordStorage is ${storage.read('pass')}');
            userNameController.text = storage.read("email").toString();
            passwordController.text = storage.read("pass").toString();
            update();
            await verifyEmailPassword();
          }
          print(storage.read("email"));
          // if()
        }
      } else {
        print('Not Available');
      }

      availableAuth = availableBiometrics;
      update();

      print(isAuth);
    } on PlatformException catch (e) {
      print(e);
      CustomSnackBar.showSnackBar(
          title: AppStrings.unable,
          message: "",
          backgroundColor: CommonColor.snackbarColour);
    }
  }

  void eraseUrlStorage() {
    storage.remove("Url");
    if (storage.read("Url").toString() != "null") {
      String url = storage.read("Url");
      linkController.text = url;
      update();
    } else {
      linkController.text = ApiData.baseUrl;
      update();
    }
    // Get.snackbar('', "base url is active",
    // backgroundColor: CommonColor.snackbarColour, colorText: Colors.white);
    CustomSnackBar.showSnackBar(
        title: AppStrings.baseurlactive,
        message: "",
        backgroundColor: CommonColor.snackbarColour);
  }
}
