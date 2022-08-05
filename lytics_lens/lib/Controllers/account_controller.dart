import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/Constants/constants.dart';
import 'package:lytics_lens/Controllers/home_controller.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/Views/Login_Screen.dart';
import 'package:lytics_lens/utils/api.dart';

class AccountController extends GetxController {
  bool isLoading = true;
  bool selected = false;

  bool isShow = false;

  List updateList = [];

  final storage = GetStorage();

  late NetworkController networkController;

  late HomeScreenController controller = Get.find<HomeScreenController>();

  static CollectionReference show =
      FirebaseFirestore.instance.collection('remotConfigFile');

  static CollectionReference isUpdate =
      FirebaseFirestore.instance.collection('updateApp');

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    getShow();
    getShowUpdate();
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getShow() async {
    try {
      Stream<QuerySnapshot> data = show.snapshots();
      await data.forEach((e) {
        for (var value in e.docs) {
          isShow = value.get('isShow');
        }
        update();
      }).catchError((e) {
        // CustomSnackBar.showSnackBar(title: AppStrings.unable, message: "", backgroundColor: Color(0xff48beeb));
      });
    } on FirebaseException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(title: AppStrings.unable, message: "", backgroundColor: Color(0xff48beeb));
    }
  }

  Future<void> getShowUpdate() async {
    try {
      Stream<QuerySnapshot> sdata = isUpdate.snapshots();
      await sdata.forEach((w) {
        updateList.clear();
        for (var value in w.docs) {
          updateList.add(value.data());
          print("CHeck The Version Txt ${value.data()}");
        }
        update();

        
      }).catchError((e) {
        // CustomSnackBar.showSnackBar(title: AppStrings.unable, message: "", backgroundColor: Color(0xff48beeb));
      });
    } on FirebaseException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(title: AppStrings.unable, message: "", backgroundColor: Color(0xff48beeb));
    }
  }

  Future<void> sendDeviceToken() async {
    print('check Send Device Token');
    print('Token ${storage.read("AccessToken")}');
    String token = await storage.read("AccessToken");
    if (storage.hasData("Url") == true) {
      String url = storage.read("Url");
      var res = await http.post(Uri.parse(url + ApiData.deviceToken),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-type": 'application/json',
          },
          body: json.encode({
            "userId": storage.read('id'),
            "deviceToken": Constants.token,
            "addToken": "false",
          }));
      var data = json.decode(res.body);
      print("response of device token api" + res.statusCode.toString());
      print("response of device token api" + data.toString());
    } else {
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.deviceToken),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-type": 'application/json',
        },
        body: json.encode({
          "userId": storage.read('id'),
          "deviceToken": Constants.token,
          "addToken": "false",
        }),
      );
      var data = json.decode(res.body);
      print("response of device token api" + data.toString());
    }
  }

  Future<void> logout() async {
    print("call function");
    try {
      await sendDeviceToken();
      await storage.remove("RefreshToken");
      await storage.remove("AccessToken");
      await storage.remove("username");
      await storage.remove("password");
      await storage.remove("id");
      await storage.remove("firstName");
      await storage.remove("lastName");
      await storage.remove("UsersChannels");
       await storage.remove("isOnboard");
      Constants.index = 0;

      Get.offAll(() => LoginScreen());
      // if(storage.hasData("Url") == true){
      //   String url = storage.read("Url");
      //   print(url);
      //   String token =await storage.read("RefreshToken");
      //   print(token);
      //   var res = await http.post(
      //     Uri.parse(url + ApiData.logut),
      //     body: {"refreshToken": token, "latest": "true"},
      //   );
      //   print(res.body);
      //   print(res.statusCode);
      //   await storage.remove("RefreshToken");
      //   await storage.remove("AccessToken");
      //   await storage.remove("isLogin");
      //   Constants.index=0;
      //
      //   Get.offAll(() => LoginScreen());
      // }
      // else
      //   {
      //     String token =await storage.read("RefreshToken");
      //     print(token);
      //     var res = await http.post(
      //       Uri.parse(ApiData.baseUrl+ApiData.logut),
      //       body: {"refreshToken": token, "latest": "true"},
      //     );
      //     print(res.body);
      //     print(res.statusCode);
      //     await storage.remove("RefreshToken");
      //     await storage.remove("AccessToken");
      //     await storage.remove("username");
      //     await storage.remove("password");
      //     Constants.index=0;
      //     Get.offAll(() => LoginScreen());
      //   }
    } on SocketException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),isWarning: false);

    } catch (e) {
      print(e.toString());
      // Get.snackbar('Catch Error', e.toString(), backgroundColor: Colors.red);
    }
  }
}
