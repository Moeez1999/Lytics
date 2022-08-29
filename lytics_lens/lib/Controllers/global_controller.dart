import 'dart:convert';
import 'dart:io';

import 'package:change_case/change_case.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Controllers/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/utils/api.dart';

class GlobalController extends GetxController {
  late HomeScreenController homeScreenController;
  final storage = new GetStorage();

  @override
  void onInit() {
    if (Get.isRegistered<HomeScreenController>()) {
      homeScreenController = Get.find<HomeScreenController>();
    } else {
      homeScreenController = Get.put(HomeScreenController());
    }
    super.onInit();
  }

  Future<void> getSingleJob(String jobId) async {
    print("Check This Function calling");
    print("Check Job Id is $jobId");
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        print("Bearer $token");
        var res = await http
            .get(Uri.parse(url + ApiData.singleJob + jobId), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);
        Get.log("All Data $data");
        Get.log("All Data ${data['share']}");
        if (data['share'] == 'true') {
          print("Job insert in received");
          homeScreenController.receivedJobsList.insert(0, data);
        } else {
          print("Job insert in Alert");
          homeScreenController.job.insert(0, data);
        }
      } else {
        String token = await storage.read("AccessToken");
        print("Bearer $token");
        var res = await http.get(
            Uri.parse(ApiData.baseUrl + ApiData.singleJob + jobId),
            headers: {
              'Authorization': "Bearer $token",
            });
        var data = json.decode(res.body);
        print("Check Data $data");
        if (data['share'].toString().isLowerCase == 'true') {
          homeScreenController.receivedJobsList.insert(0, data);
        } else {
          homeScreenController.job.insert(0, data);
        }
      }
    } on SocketException catch (e) {
      print('Inter Connection Failed');
      update();
      print(e);
    } catch (e) {
      print('Global Controller Error occurred ${e.toString()}');
    }
  }
}
