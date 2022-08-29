import 'dart:convert';
import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lytics_lens/Controllers/home_controller.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/utils/api.dart';
import 'package:wakelock/wakelock.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:math';

class VideoController extends GetxController {
  bool isLoading = true;

  var isBottomLoading = false.obs;

  bool isSocket = false;
  List recieveruser = [];

  String imagePathLast = '';
  var isVoicePressed = false.obs;

  var filePath;

  File? videoFilePath;

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  // <------------- Recorder ---------------->

  bool isAudio = false;
  bool isComment = false;

  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  bool mPlayerIsInited = false;
  RxBool isPlay = false.obs;

//<-------------Variables for trim video---------------->

  var isPlaying = false;
  bool progressVisibility = false;
  var isVideoPlay = false.obs;

  TextEditingController searchContact = TextEditingController();

//--------------------------------------------------------
  var arrg;
  var videoURL;
  RxBool startTimer = false.obs;
  RxBool showBack = false.obs;
  late BetterPlayerController betterPlayerController;
  late NetworkController networkController;
  TextEditingController englishsearchtext = TextEditingController();
  TextEditingController urdusearchtext = TextEditingController();
  Duration? playerTime;
  final bool looping = false;
  String videolink = "";
  String urduText = "";
  String englishText = "";
  List transcriptionlist = [];
  List transcriptionlistdir = [];
  List dir = [];
  List translationlist = [];
  List translationlist1 = [];
  List data = [];

  // <----------------- New Code ------------------>
  final storage = new GetStorage();
  String audioPath = '';
  String channel = '';
  String videoPath = '';
  String sourcevideoPath = '';
  String jobId = '';
  String event = '';
  String programName = '';
  String topic = '';
  List subTopic = [];
  List anchor = [];
  List guest = [];
  List sharedList = [];
  String analysis = '';
  List segments = [];
  List hashTags = [];
  String source = '';
  String speaker = '';
  String statment = '';
  String thumbnailpath = '';
  String channelLogo = '';
  String description = '';
  String title = '';
  List queryWords = [];
  String programType = '';
  var transcription;
  var translation;
  String programTime = '';
  String programDate = '';
  var duration = 0.obs;
  List thumbnail = [];
  var loadingData = true.obs;
  String comment = ' ';

  // <---------  For WebSite Only ---------->
  String transcriptionText = '';

  Duration startAt = Duration();

  TextEditingController selectedTab = TextEditingController(text: 'Details');

  //<-------------- CompanyUser ----------------->

  var companyUser = [].obs;
  var searchcompanyUser = [].obs;
  var sharingUser = [].obs;

  String senderId = '';
  String senderFirstName = '';
  String senderLastName = '';

  @override
  void onInit() async {
    // Get.delete<VideoController>();
    // Get.put(VideoController());
    senderId = await storage.read('id');
    senderFirstName = await storage.read('firstName');
    senderLastName = await storage.read('lastName');
    update();
    mPlayer!.openPlayer().then((value) {
      mPlayerIsInited = true;
      update();
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (Get.isRegistered<NetworkController>()) {
      networkController = Get.find<NetworkController>();
    } else {
      networkController = Get.put(NetworkController());
    }
    if (Get.arguments != null) {
      print('Id is ${Get.arguments['id']}');

      print("image path is " + imagePathLast.toString());
      isSocket = false;
      jobId = Get.arguments['id'];
      update();

      await getSingleJob(Get.arguments['id']);
      await getCompanyUser();
      // await urlToFile(videoPath);
    }

    // This is Use for online Video

    transcriptionlist.addAll(transcription);
    // transcriptionlist.sort((a, b) => a["duration"].compareTo(b["duration"]));
    if (translation.toString() != "null") {
      dir.add(translation);
    }

    update();
    transcriptionlist.forEach((element) {
      data.add(element['line']);
      transcriptionlistdir.add(element);
    });
    update();
    transcriptionlistdir.forEach((element) {
      // print('Transcription List $element');
    });
    if (dir.length != 0) {
      for (int i = 0; i < dir.length; i++) {
        dir[i].forEach((e) {
          translationlist.add(e);
        });
      }
    }
    // translationlist.forEach((element) {
    //   translationlist1.add(element['line']);
    // });
    urduText = data.join(" ");
    englishText = translationlist.join("");
    print("VIDEO LINK $videoPath");
    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        // showPlaceholderUntilPlay: true,
        aspectRatio: 16 / 9,
        looping: false,
        autoDispose: true,
        autoPlay: true,
        startAt: startAt,
        eventListener: (BetterPlayerEvent e) => eveB(e),
        controlsConfiguration: BetterPlayerControlsConfiguration(
            enableAudioTracks: false,
            enablePip: false,
            enableOverflowMenu: false,
            enablePlayPause: false,
            enableProgressBar: true,
            enableFullscreen: true,
            forwardSkipTimeInMilliseconds: 10000,
            backwardSkipTimeInMilliseconds: 10000,
            progressBarPlayedColor: Colors.orange,
            progressBarBufferedColor: Color(0xff676767),
            progressBarBackgroundColor: Color(0xff676767)),
        fit: BoxFit.cover,
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoPath,
      ),
    );
    betterPlayerController.videoPlayerController!.addListener(() {
      playerTime = betterPlayerController.videoPlayerController!.value.position;
      print(
          "Test the Value ${betterPlayerController.videoPlayerController!.value.position.runtimeType}");
      update();
      // print('Check Video Time ${betterPlayerController.videoPlayerController!.value.position.inSeconds}');
    });
    // dir = [TextDirection.rtl, TextDirection.ltr];
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
    betterPlayerController.dispose();
    mPlayer!.closePlayer();
    mPlayer = null;
    Wakelock.disable();
    super.onClose();
  }

  Future<void> urlToFile(String videoPath) async {
    try {
      var rng = new Random();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file =
          new File('$tempPath' + (rng.nextInt(100)).toString() + '.mp4');
      http.Response response = await http.get(Uri.parse(videoPath));
      await file.writeAsBytes(response.bodyBytes);
      videoFilePath = file;
      // return file;
      update();
    } catch (e) {
      print("Url to File Error ${e.toString()}");
    }
  }

  //<----------------- Get Job By Id ------------------->
  Future<void> getSingleJob(String jobId) async {
    try {
      if (storage.hasData("Url") == true) {
        thumbnail.clear();
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        print("Bearer $token");
        var res = await http
            .get(Uri.parse(url + ApiData.singleJob + jobId), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);
        // print("All Data $data");
        Get.log("All Data $data");
        // print("English Data ${data['translation']}");
        // print('Sub Topic ${data['segments'][0]['topics']['topic2']}');

        Get.log("All Data $data");
        print("English Data ${data['translation']}");
        // print('Sub Topic ${data['segments'][0]['topics']['topic2']}');
        print("check data is ${data['transcription']}");
        source = data["source"];
        channel = data['channel'];
        comment = data["comments"];

        sourcevideoPath = source.toString() == 'websites'
            ? 'http://checkk'
            : data["videoPath"];
        // videoPath = sourcevideoPath.split('http://172.168.1.131/Videos/').last;
        videoPath = sourcevideoPath;
        // await urlToFile(videoPath);
        if (data["comments"] == null || data["comments"]=='') {
          isComment = false;
          update();
        } else {
          isComment = true;
          update();
        }
        if (data['audio'] == null) {
          audioPath = '';

        } else {
          audioPath = data["audio"];
          isAudio = true;
          update();
        }
        // event = data['programName'];
        programName = data['programName'];
        segments = data['segments'];
        if (data['sharing'].toString().length == 2) {
          sharedList = [];
        } else {
          data['sharing'].forEach((e) {
            print("Shared User $e");
            if (senderId == e['senderId']) {
              print("Condition Sender True");
              sharedList.add(e);
            }
          });
          update();
        }

        if (data['segments'].toString().length == 2) {
          topic = '';
        } else {
          topic = data['segments'][0]['topics']['topic1'];
        }
        if (data['segments'].toString().length == 2) {
          subTopic = [];
          analysis = '';
        } else {
          subTopic = data['segments'][0]['topics']['topic2'];
          analysis =
          data["segments"][0]['segmentAnalysis']["analysis"]["analyst"];
        }
        if (data['segments'].toString().length == 2) {
          hashTags = [];
        } else {
          hashTags = data['segments'][0]['hashtags'];
        }
        if (source.toLowerCase() == 'website' ||
            source.toLowerCase() == 'print' ||
            source.toLowerCase() == 'blog') {
          title = data['programDescription'].toString() == 'null' ||
              data['programDescription'].toString() == ''
              ? ''
              : data['programDescription'];
        }

        guest = data["guests"];
        queryWords.addAll(data['queryWords']);
        anchor = data['anchor'];
        speaker = data['anchor'].toString() == '[]' ? '' : data['anchor'][0];
        statment = data['programDescription'];
        channelLogo = data['channelLogoPath'].toString().contains('http')
            ? data['channelLogoPath']
            : ApiData.channelLogoPath + data['channelLogoPath'];
        thumbnailpath = storage.hasData("Url")
            ? "${storage.read("Url").toString()}/uploads/${data['thumbnailPath']}"
            : "${ApiData.thumbnailPath + data['thumbnailPath']}";
        if (source.toLowerCase() == 'website' ||
            source.toLowerCase() == 'print') {
          if (data['gallary'].toString().length == 2) {
            thumbnail = [];
          } else {
            print("Data in Gallary is ${data['gallary'].toString().length}");
            data['gallary'].forEach((e) {
              e.toString().contains('http')
                  ? thumbnail.add(e)
                  : thumbnail.add(ApiData.baseUrl + '/uploads/' + e);
            });
            update();
          }
        }
        description = data['programDescription'];

        programTime = data['programTime'];
        programDate = data['programDate'];
        imagePathLast = "${ApiData.thumbnailPath + data['thumbnailPath']}";
        programType = data['programType'];
        transcription = data['transcription'].toString().toLowerCase() == 'null'
            ? []
            : data['transcription'];
        translation = data['translation'];
        print("videoPath is " + data["videoPath"]);
        print("Date Program Time " + data["programTime"]);
        print("Date Program Time " + data["programDate"]);
      } else {
        String token = await storage.read("AccessToken");
        thumbnail.clear();
        print("Bearer $token");
        var res = await http.get(
            Uri.parse(ApiData.baseUrl + ApiData.singleJob + jobId),
            headers: {
              'Authorization': "Bearer $token",
            });
        var data = json.decode(res.body);
        print("User id is $senderId");
        Get.log("Sharing Job data is ${data['sharing']}");
        // print("All Data $data");
        Get.log("All Data $data");
        print("English Data ${data['translation']}");
        // print('Sub Topic ${data['segments'][0]['topics']['topic2']}');
        print("check data is ${data['transcription']}");
        source = data["source"];
        channel = data['channel'];
        comment = data["comments"];

        sourcevideoPath = source.toString() == 'websites'
            ? 'http://checkk'
            : data["videoPath"];
        // videoPath = sourcevideoPath.split('http://103.31.81.34/Videos/').last;
        videoPath = sourcevideoPath;
        // await urlToFile(videoPath);
         if (data["comments"] == null || data["comments"]=='') {
          isComment = false;
          update();
        } else {
          isComment = true;
          update();
        }
        if (data['audio'] == null) {
          audioPath = '';

        } else {
          audioPath = data["audio"];
          isAudio = true;
          update();
        }
        // event = data['programName'];
        programName = data['programName'];
        segments = data['segments'];
        if (data['sharing'].toString().length == 2) {
          sharedList = [];
        } else {
          data['sharing'].forEach((e) {
            print("Shared User $e");
            if (senderId == e['senderId']) {
              print("Condition Sender True");
              sharedList.add(e);
            }
          });
          update();
        }

        if (data['segments'].toString().length == 2) {
          topic = '';
        } else {
          topic = data['segments'][0]['topics']['topic1'];
        }
        if (data['segments'].toString().length == 2) {
          subTopic = [];
          analysis = '';
        } else {
          subTopic = data['segments'][0]['topics']['topic2'];
          analysis =
              data["segments"][0]['segmentAnalysis']["analysis"]["analyst"];
        }
        if (data['segments'].toString().length == 2) {
          hashTags = [];
        } else {
          hashTags = data['segments'][0]['hashtags'];
        }
        if (source.toLowerCase() == 'website' ||
            source.toLowerCase() == 'print' ||
            source.toLowerCase() == 'blog') {
          title = data['programDescription'].toString() == 'null' ||
                  data['programDescription'].toString() == ''
              ? ''
              : data['programDescription'];
        }

        guest = data["guests"];
        queryWords.addAll(data['queryWords']);
        anchor = data['anchor'];
        speaker = data['anchor'].toString() == '[]' ? '' : data['anchor'][0];
        statment = data['programDescription'];
        channelLogo = data['channelLogoPath'].toString().contains('http')
            ? data['channelLogoPath']
            : ApiData.channelLogoPath + data['channelLogoPath'];
        thumbnailpath = storage.hasData("Url")
            ? "${storage.read("Url").toString()}/uploads/${data['thumbnailPath']}"
            : "${ApiData.thumbnailPath + data['thumbnailPath']}";
        if (source.toLowerCase() == 'website' ||
            source.toLowerCase() == 'print') {
          if (data['gallary'].toString().length == 2) {
            thumbnail = [];
          } else {
            print("Data in Gallary is ${data['gallary'].toString().length}");
            data['gallary'].forEach((e) {
              e.toString().contains('http')
                  ? thumbnail.add(e)
                  : thumbnail.add(ApiData.baseUrl + '/uploads/' + e);
            });
            update();
          }
        }
        description = data['programDescription'];

        programTime = data['programTime'];
        programDate = data['programDate'];
        imagePathLast = "${ApiData.thumbnailPath + data['thumbnailPath']}";
        programType = data['programType'];
        transcription = data['transcription'].toString().toLowerCase() == 'null'
            ? []
            : data['transcription'];
        translation = data['translation'];
        print("videoPath is " + data["videoPath"]);
        print("Date Program Time " + data["programTime"]);
        print("Date Program Time " + data["programDate"]);
      }
    } on SocketException catch (e) {
      print('Inter Connection Failed');
      isLoading = false;
      isSocket = true;
      update();
      print(e);
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  String convertTime(String time) {
    var dateList = time.split(" ").first;
    return dateList;
  }

  String convertIntoDateTime(String month) {
    if (month == "01") {
      return ' Jan';
    } else if (month == "02") {
      return ' Feb';
    } else if (month == "03") {
      return ' Mar';
    } else if (month == "04") {
      return ' Apr';
    } else if (month == "05") {
      return ' May';
    } else if (month == "06") {
      return ' Jun';
    } else if (month == "07") {
      return ' Jul';
    } else if (month == "08") {
      return ' Aug';
    } else if (month == "09") {
      return ' Sep';
    } else if (month == "10") {
      return ' Oct';
    } else if (month == "11") {
      return ' Nov';
    } else {
      return ' Dec';
    }
  }

  String convertDateUtc(String cdate) {
    var strToDateTime = DateTime.parse(cdate);
    final convertLocal = strToDateTime.toLocal();
    var newFormat = DateFormat("dd MM");
    String updatedDt = newFormat.format(convertLocal);
    String q = updatedDt.split(' ').last;
    String a = updatedDt.split(' ').first;
    print(updatedDt);
    return a + convertIntoDateTime(q);
  }

  void eveB(e) {
    if (e.betterPlayerEventType == BetterPlayerEventType.play) {
      startTimer(true);
      Wakelock.enable();
    } else if (e.betterPlayerEventType == BetterPlayerEventType.pause) {
      startTimer(false);
    } else if (e.betterPlayerEventType ==
        BetterPlayerEventType.controlsVisible) {
      showBack(true);
    } else if (e.betterPlayerEventType ==
        BetterPlayerEventType.hideFullscreen) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    } else if (e.betterPlayerEventType ==
        BetterPlayerEventType.openFullscreen) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
  }

  Color check(String d, Duration s) {
    String splittext = d.split('-').first;
    String splittext2 = d.split('-').last;
    double starttime = double.parse(splittext);
    // print('Time in Min $s');
    double endtime = double.parse(splittext2);

    var z = s.inMilliseconds / 1000;

    print('Is Start Time is $starttime');
    print('Is End Time Color is  $endtime');
    print('Is Sec Time Color is  $s');
    if (starttime < z && endtime > z) {
      return Colors.yellow;
    } else {
      // print('Is true Return Color Else');
      return Colors.transparent;
    }
    // return Colors.transparent;
  }

  Color check1(String d, Duration s) {
    String splittext = d.split('-').first;
    String splittext2 = d.split('-').last;
    double starttime = double.parse(splittext);
    // print('Time in Min $s');
    double endtime = double.parse(splittext2);

    var z = s.inMilliseconds / 1000;

    print('Is Start Time is $starttime');
    print('Is End Time Color is  $endtime');
    print('Is Sec Time Color is  $s');
    if (starttime < z && endtime > z) {
      return Colors.yellow;
    } else {
      // print('Is true Return Color Else');
      return Colors.transparent;
    }
    // return Colors.transparent;
  }

  String getTopicString(List segment) {
    List topic2 = [];
    List topic3 = [];

    String topic2string = "";
    String topic3string = "";

    String topic = "";
    // Get.log('Segments $segment');
    //_.job[index]['segments'][0]['topics']['topic1']
    segment.forEach((element) {
      print('Segment is ${element['topics']['topic2']}');
      if (element['topics']['topic2'].toString().length != 2) {
        element['topics']['topic2'].forEach((q) {
          topic2.add(q);
        });
      }
      if (element['topics']['topic3'].toString().length != 2) {
        element['topics']['topic3'].forEach((qw) {
          topic3.add(qw);
        });
      }
      topic2.forEach((element) {});
    });

    if (topic2.isNotEmpty) {
      topic2string = topic2.join('-');
    }
    if (topic3.isNotEmpty) {
      topic3string = topic3.join('-');
    }
    if (topic2.isEmpty && topic3.isNotEmpty) {
      topic = topic3.join('-');
    }
    if (topic2.isNotEmpty && topic3.isEmpty) {
      topic = topic2.join('-');
    }
    if (topic2.isNotEmpty && topic3.isNotEmpty) {
      topic = "$topic2string | $topic3string";
    }
    if (topic2.isEmpty && topic3.isEmpty) {
      topic = '';
    }
    return topic;
  }

  String subTopicString(List c) {
    var sTopic = c.join(", ");
    return sTopic;
  }

  String anchorString(List c) {
    var anchor = c.join(", ");
    return anchor;
  }

  String guestString(List c) {
    List g = [];
    for (int i = 0; i < c.length; i++) {
      g.add(c[i]['name']);
    }
    print("Guest Length is $g");
    // update();
    var guest = g.join(", ");
    // var guest = " ";
    return guest;
  }

  Future<void> getCompanyUser() async {
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        String id = await storage.read('company_id');
        companyUser.clear();
        var res =
            await http.get(Uri.parse(url + ApiData.companyuser + id), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);

        data['users'].forEach((e) {
          companyUser.add(e);
        });
      } else {
        String token = await storage.read("AccessToken");
        String id = await storage.read('company_id');
        update();

        var res = await http.get(
            Uri.parse(ApiData.baseUrl + ApiData.companyuser + id),
            headers: {
              'Authorization': "Bearer $token",
            });
        var data = json.decode(res.body);
        data['users'].forEach((e) {
          companyUser.add(e);
        });
      }
    } on SocketException catch (e) {
      print('Inter Connection Failed');
      isLoading = false;
      isSocket = true;
      update();
      print(e);
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  String namesSplit(String n) {
    var f = n.split(' ').first;
    var l = n.split(' ').last;
    return '${f[0]} ${l[0]}';
  }

  searchFunction(String v) {
    if (v.isEmpty || v == '') {
      searchcompanyUser.clear();
    } else {
      searchcompanyUser.clear();
      companyUser.forEach((e) {
        if (e['firstName'].toString().toLowerCase().contains(v.toLowerCase())) {
          searchcompanyUser.add(e);
        } else if (e['lastName']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchcompanyUser.add(e);
        }
      });
    }
  }

  String addDataList(String id) {
    var r = sharingUser.firstWhere((element) => element['recieverId'] == id,
        orElse: () => {'recieverId': 'nofound'});
    return r['recieverId'];
  }

  void deletedata(String id) {
    sharingUser.removeWhere((element) => element['recieverId'] == id);
  }

  void audioplay(String audioPath) {
    try {
      isPlay.value = true;
      update();
      mPlayer!
          .startPlayer(
              fromURI: audioPath,
              whenFinished: () {
                isPlay.value = false;
                update();
              })
          .then((value) {});
    } catch (e) {
      print("Audio Play Error is ${e.toString()}");
    }
  }

  void stopPlayer() {
    isPlay.value = false;
    try {
      mPlayer!.stopPlayer().then((value) {
        update();
      });
    } catch (e) {
      print("Audio Stop Error is ${e.toString()}");
    }
  }
}
