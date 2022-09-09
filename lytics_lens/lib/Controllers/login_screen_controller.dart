import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/Constants/app_strrings.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/global_controller.dart';
import 'package:lytics_lens/widget/snackbar/common_snackbar.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/views/dashboard_screen.dart';
import 'package:local_auth/local_auth.dart';
import '../Services/baseurl_service.dart';

class LoginScreenController extends GetxController {
  final formkey = GlobalKey<FormState>();

  late NetworkController networkController;
  BaseUrlService baseUrlService = Get.find<BaseUrlService>();

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
    //<---------- Assign BaseUrl to LinkController ----------->
    linkController.text = baseUrlService.baseUrl;
    update();
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

  void formatNickname() {
    userNameController.text = userNameController.text.replaceAll(" ", "");
  }


  //<--------- This function is used for verify Email and Password ----------->

  Future<void> verifyEmailPassword() async {
    if (formkey.currentState!.validate()) {
      try {
        var res = await http.post(
          Uri.parse(baseUrlService.baseUrl + ApiData.login),
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
      } on SocketException catch (e) {
        print(e);
        CustomSnackBar.showSnackBar(
            title: AppStrings.interneterror,
            message: "",
            isWarning: true,
            backgroundColor: CommonColor.snackbarColour);
      } catch (e) {
        if (e.toString().contains("access")) {
          CustomSnackBar.showSnackBar(
              title: AppStrings.inncorrectUsername,
              message: "",
              backgroundColor: CommonColor.snackbarColour,
              isWarning: true);
        }
      }
    }
  }

  //<----------- This Function Used for Update Baseurl ------->

  Future<void> getUrl() async {
    await storage.write("Url", linkController.text);
    await baseUrlService.isBaseUrlCheck();
    print("Check Base Url ${baseUrlService.baseUrl}");
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

  Future<void> eraseUrlStorage() async{
    storage.remove("Url");
    await baseUrlService.isBaseUrlCheck();
    print("Check Base Url ${baseUrlService.baseUrl}");
    linkController.text = baseUrlService.baseUrl;
    update();
    CustomSnackBar.showSnackBar(
        title: AppStrings.baseurlactive,
        message: "",
        backgroundColor: CommonColor.snackbarColour);
  }
}
