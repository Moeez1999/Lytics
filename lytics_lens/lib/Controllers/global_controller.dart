// import 'dart:convert';
// import 'dart:io';
// import 'package:change_case/change_case.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:lytics_lens/Controllers/home_controller.dart';
// import 'package:http/http.dart' as http;
// import 'package:lytics_lens/utils/api.dart';
// import '../Services/baseurl_service.dart';
//
// class GlobalController extends GetxController
// {
//
//   late HomeScreenController homeScreenController;
//   final storage = new GetStorage();
//   BaseUrlService baseUrlService = Get.find<BaseUrlService>();
//
//
//   @override
//   void onInit() {
//     if (Get.isRegistered<HomeScreenController>()) {
//       homeScreenController = Get.find<HomeScreenController>();
//     } else {
//       homeScreenController = Get.put(HomeScreenController());
//     }
//     super.onInit();
//   }
//
//   Future<void> getSingleJob(String jobId) async {
//     print("Check This Function calling");
//     print("Check Job Id is $jobId");
//     await storage.write("notificationId", jobId);
//     try {
//       String token = await storage.read("AccessToken");
//       print("Bearer $token");
//       var res = await http.get(
//           Uri.parse(baseUrlService.baseUrl + ApiData.singleJob + jobId),
//           headers: {
//             'Authorization': "Bearer $token",
//           });
//       var data = json.decode(res.body);
//       Get.log("Check Data $data");
//       if(data['share'].toString().isLowerCase == 'true')
//       {
//         print("Data insert in Received List");
//         homeScreenController.receivedJobsList.insert(0, data);
//         homeScreenController.update();
//       }
//       else
//       {
//         print("Data insert in Home List");
//         homeScreenController.job.insert(0, data);
//         homeScreenController.update();
//       }
//     } on SocketException catch (e) {
//       getSingleJob(storage.read('notificationId'));
//       print('Inter Connection Failed');
//       update();
//       print(e);
//     } catch (e) {
//       print('Global Controller Error occurred ${e.toString()}');
//     }
//   }
//
// }