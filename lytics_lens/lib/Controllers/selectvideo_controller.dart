import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/utils/api.dart';

class SelectVideoController extends GetxController {
  bool isLoading = true;

  late NetworkController networkController;

  var arrg;
  final storage = new GetStorage();
  String videoPath = '';
  String jobId = '';
  String event = '';
  String topic = '';
  List subTopic = [];
  List anchor = [];
  List guest = [];
  String source = '';
  String speaker = '';
  String statment = '';
  String thumbnailpath = '';
  String channelLogo = '';
  String description = '';
  String transcription = '';
  String translation = '';

  @override
  void onInit() async {
    if (Get.isRegistered<NetworkController>()) {
      networkController = Get.find<NetworkController>();
    } else {
      networkController = Get.put(NetworkController());
    }
    if (Get.arguments != null) {
      arrg = Get.arguments;
      jobId = arrg["id"];
      print("Thumbnail path is" + thumbnailpath.toString());

      print(jobId);
      update();
    }

    super.onInit();
  }

  @override
  void onReady() async {
    await getSingleJob();
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getSingleJob() async {
    if (storage.hasData("Url") == true) {
      String url = storage.read("Url");
      String token = await storage.read("AccessToken");
      print("Bearer $token");
      var res =
          await http.get(Uri.parse(url + ApiData.singleJob + jobId), headers: {
        'Authorization': "Bearer $token",
      });
      var data = json.decode(res.body);
      print("Url Data $data");
      print('Sub Topic ${data['segments'][0]['topics']['topic2']}');
      videoPath = data["videoPath"];
      event = data['programName'];
      topic = data['segments'][0]['topics']['topic1'];
      subTopic = data['segments'][0]['topics']['topic2'];
      source = data["source"];
      guest = data["guests"];
      anchor = data['anchor'];
      speaker = data['anchor'][0];
      statment = data['programDescription'];
      channelLogo = data['channelLogoPath'];
      thumbnailpath = data['thumbnailPath'];
      description = data['programDescription'];

      // print("video path is "+data["VideoPath"]);
    } else {
      String token = await storage.read("AccessToken");

      print("Bearer $token");
      var res = await http.get(
          Uri.parse(ApiData.baseUrl + ApiData.singleJob + jobId),
          headers: {
            'Authorization': "Bearer $token",
          });
      var data = json.decode(res.body);
      print("All Data $data");
      print('Sub Topic ${data['segments'][0]['topics']['topic2']}');
      videoPath = data["videoPath"];
      event = data['programName'];
      topic = data['segments'][0]['topics']['topic1'];
      // subTopic = data['segments'][0]['topics']['topic2'][0];
      subTopic = data['segments'][0]['topics']['topic2'];
      source = data["source"];
      guest = data["guests"];
      anchor = data['anchor'];
      speaker = data['anchor'][0];
      statment = data['programDescription'];
      channelLogo = data['channelLogoPath'];
      thumbnailpath = data['thumbnailPath'];
      description = data['programDescription'];
    }
  }
}
