import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helpers/helpers.dart' show OpacityTransition;
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/clipping_controller.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/widget/textFields/common_textfield.dart';
import 'package:lytics_lens/widget/snackbar/common_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_editor/video_editor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:path_provider/path_provider.dart';

import '../Services/baseurl_service.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ClippingScreen extends StatefulWidget {
  const ClippingScreen({Key? key, required this.fileurl, required this.jobId , required this.videoDuration})
      : super(key: key);

  final String fileurl;
  final String jobId;
  final int videoDuration;

  @override
  State<ClippingScreen> createState() => _ClippingScreenState();
}

class _ClippingScreenState extends State<ClippingScreen> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;
  late VideoEditorController _controller;
  ClippingController clippingController = Get.put(ClippingController());
  ClippingController clipController = Get.find<ClippingController>();
  BaseUrlService baseUrlService = Get.find<BaseUrlService>();
  var audioFile = null;
  final storage = new GetStorage();
  dynamic start;
  dynamic end;
  double progress = 0.0;
  File? videoFilePath;
  dynamic duration;
  Codec _codec = Codec.aacMP4;
  String _mPath = '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4';

  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  bool mPlayerIsInited = false;
  RxBool isPlay = false.obs;

  final recorder = FlutterSoundRecorder();

  // <--------- Player ------------->

  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    mPlayer!.openPlayer().then((value) {
      setState(() {
        mPlayerIsInited = true;
      });
    });
    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        // showPlaceholderUntilPlay: true,
        aspectRatio: 16 / 9,
        looping: false,
        autoDispose: true,
        autoPlay: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
            enableAudioTracks: false,
            enablePip: false,
            enableOverflowMenu: false,
            enablePlayPause: false,
            enableProgressBar: false,
            enableFullscreen: false,
            forwardSkipTimeInMilliseconds: 10000,
            backwardSkipTimeInMilliseconds: 10000,
            progressBarPlayedColor: Colors.orange,
            progressBarBufferedColor: Color(0xff676767),
            progressBarBackgroundColor: Color(0xff676767)),
        fit: BoxFit.cover,
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.fileurl,
      ),
    );
    setState(() {});
    urlToFile();
    super.initState();
  }

  @override
  void dispose() {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    recorder.closeRecorder();
    mPlayer!.closePlayer();
    mPlayer = null;
    Get.delete<ClippingController>();
    super.dispose();
  }

  Future<void> urlToFile() async {
    clipController.isScreenLoading.value = true;
    try {
      setState(() {
        progress = 0.0;
      });
      final request = Request('GET', Uri.parse(widget.fileurl));
      final StreamedResponse response = await Client().send(request);
      final contentLength = response.contentLength;
      setState(() {
        progress = 0.000001;
      });
      List<int> bytes = [];
      var rng = new Random();
      final file = await getFile((rng.nextInt(100)).toString() + '.mp4');
      response.stream.listen(
        (List<int> newBytes) {
          bytes.addAll(newBytes);
          final downloadedLength = bytes.length;
          setState(() {
            progress = downloadedLength.toDouble() / (contentLength ?? 1);
          });
          print("progress: $progress");
        },
        onDone: () async {
          setState(() {
            progress = 1;
          });
          await file.writeAsBytes(bytes);
          _controller = VideoEditorController.file(file,
              maxDuration: Duration(seconds: widget.videoDuration))
            ..initialize().then((_) => setState(() {}));
          initRecorder();
          betterPlayerController.pause();
          clipController.isScreenLoading.value = false;
        },
        onError: (e) {
          debugPrint(e);
          clipController.isScreenLoading.value = false;
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint(e.toString());
      clipController.isScreenLoading.value = false;
    }
  }

  Future<File> getFile(String filename) async {
    final dir = await getTemporaryDirectory();
    // final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$filename");
  }

  void audioplay(String p) {
    try {
      isPlay.value = true;
      mPlayer!
          .startPlayer(
            fromURI: p,
            whenFinished: () {
              isPlay.value = false;
            },
          )
          .then((value) {});
    } catch (e) {
      print("Audio Play Error is ${e.toString()}");
    }
  }

  void stopPlayer() {
    isPlay.value = false;
    try {
      mPlayer!.stopPlayer().then((value) {});
    } catch (e) {
      print("Audio Stop Error is ${e.toString()}");
    }
  }

  void pausePlayer() {
    isPlay.value = false;
    try {
      mPlayer!.pausePlayer().then((value) {});
    } catch (e) {
      print("Audio Stop Error is ${e.toString()}");
    }
  }

  Future<void> record() async {
    await recorder.startRecorder(
        toFile: _mPath, codec: _codec, audioSource: AudioSource.microphone);
  }

  Future<void> stop() async {
    final path = await recorder.stopRecorder();
    setState(() {
      audioFile = File(path!);
    });
    print("Audio File Path is $audioFile");
    print("Audio File Path is ${File(path!).runtimeType}");
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
  }

  Future<void> exportVideo() async {
    if (isPlay.value = true) {
      isPlay.value = false;
      stop();
    }
    // clippingController.isLoading = true;
    // clippingController.update();
    clipController.isBottomLoading.value = true;
    await _controller.exportVideo(onProgress: (stats, value) {
      print("Progress Value is $value");
    }, onError: (e, s) {
      clipController.isBottomLoading.value = false;
      print("Error on export video ");
    }, onCompleted: (videoFile) async {
      await sendData(videoFile);
      clipController.isBottomLoading.value = false;
    });
  }

  Future<void> sendData(File vpath) async {
    print("Check This $audioFile");
    try {
      print("Start Time ${start.toString()}");
      print("Start Time ${end.toString()}");
      print("Start Time ${widget.jobId}");
      var st = start.toStringAsFixed(2);
      var ed = end.toStringAsFixed(2);
      var s = '$st-$st';
      var e = '$ed-$ed';
      print("Start Time $s");
      print("Start Time $e");
      // var c = json.encode(clipController.sharingUser);
      String token = await storage.read("AccessToken");
      if (audioFile.path == null || audioFile.path == '') {
        print("Audio Function Call");
        Map<String, String> h = {'Authorization': 'Bearer $token'};
        var uri = Uri.parse(baseUrlService.baseUrl + ApiData.createClipJob);
        var res = http.MultipartRequest('POST', uri)
          ..headers.addAll(h)
          ..fields['id'] = widget.jobId
          ..fields['title'] = clipController.title.text
          ..fields['comments'] = clipController.des.text
          ..fields['share'] = "true"
          ..fields['startDuration'] = s.toString()
          ..fields['endDuration'] = e.toString()
          ..fields['sharing'] = json.encode(clipController.sharingUser)
          ..files
              .add(await http.MultipartFile.fromPath('videoPath', vpath.path));
        var response = await res.send();
        print('Check Response ${response.statusCode}');
        var result = await response.stream.bytesToString();
        Get.log('Check Response ${result}');
        if (response.statusCode == 200) {
          clipController.sharingUser.clear();
          clipController.homeScreenController.isLoading.value = true;
          await clipController.homeScreenController.getSentJobs();
          clipController.homeScreenController.isLoading.value = false;
          clipController.isBottomLoading.value = false;
          Get.back();
          Get.back();
          CustomSnackBar.showSnackBar(
              title: "Job shared successfully",
              message: "",
              isWarning: false,
              backgroundColor: CommonColor.greenColor);
        } else {
          Get.back();
          clipController.isBottomLoading.value = false;
        }
      } else {
        Map<String, String> h = {'Authorization': 'Bearer $token'};
        var uri = Uri.parse(baseUrlService.baseUrl + ApiData.createClipJob);
        var res = http.MultipartRequest('POST', uri)
          ..headers.addAll(h)
          ..fields['id'] = widget.jobId
          ..fields['title'] = clipController.title.text
          ..fields['comments'] = clipController.des.text
          ..fields['startDuration'] = s.toString()
          ..fields['endDuration'] = e.toString()
          ..fields['share'] = "true"
          ..fields['sharing'] = json.encode(clipController.sharingUser)
          ..files
              .add(await http.MultipartFile.fromPath('audio', audioFile.path))
          ..files
              .add(await http.MultipartFile.fromPath('videoPath', vpath.path));
        var response = await res.send();
        print('Check Response audio/video status code ${response.statusCode}');
        var result = await response.stream.bytesToString();
        Get.log('Check Response audio/video ${result}');
        clipController.sharingUser.clear();
        clipController.homeScreenController.isLoading.value = true;
        await clipController.homeScreenController.getSentJobs();
        clipController.homeScreenController.isLoading.value = false;
        clipController.isBottomLoading.value = false;
        Get.back();
        Get.back();
        CustomSnackBar.showSnackBar(
          title: "Job shared successfully",
          message: "",
          isWarning: false,
          backgroundColor: CommonColor.greenColor,
        );
      }
    } catch (e) {
      print("Error Uploading ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CommonColor.backgroundColour,
        appBar: AppBar(
          backgroundColor: CommonColor.appBarColor,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    clipController.isScreenLoading.value
                        ? Container(
                            color: CommonColor.backgroundColour,
                            height: 210,
                            width: Get.width,
                            child: BetterPlayer(
                              controller: betterPlayerController,
                            ),
                          )
                        : CropGridViewer(
                            controller: _controller,
                            showGrid: false,
                          ),
                    clipController.isScreenLoading.value
                        ? SizedBox()
                        : AnimatedBuilder(
                            animation: _controller.video,
                            builder: (_, __) => OpacityTransition(
                              visible: !_controller.isPlaying,
                              child: GestureDetector(
                                onTap: _controller.video.play,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.play_arrow,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Clip Video",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     showClipInformation(context);
                    //   },
                    //   child: Icon(
                    //     Icons.info_outline,
                    //     size: 20,
                    //     color: Colors.white,
                    //   ),
                    // )
                  ],
                ).marginOnly(left: 20.0, right: 20.0),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  height: 2,
                  color: Colors.white,
                ).marginOnly(left: 20.0, right: 20.0),
                SizedBox(
                  height: 20.0,
                ),
                CommonTextField(
                  fillcolor: Colors.transparent,
                  controller: clipController.title,
                  hintText: 'Add Title (required)',
                  maxLength: 60,
                  hintTextColor: Colors.white.withOpacity(0.6),
                  textInputAction: TextInputAction.next,
                ).marginOnly(left: 20.0, right: 20.0),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width / 1.5,
                      child: CommonTextField(
                        fillcolor: Colors.transparent,
                        controller: clipController.des,
                        hintText: 'Add Description',
                        maxLine: 5,
                        hintTextColor: Colors.white.withOpacity(0.6),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        audioFile == null
                            ? SizedBox(
                                height: 25,
                                width: 25,
                              )
                            : GestureDetector(
                                onTap: () {
                                  stopPlayer();
                                  setState(() {
                                    audioFile = null;
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.delete,
                                    color: CommonColor.greenBorderColor,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        audioFile != null
                            ? Obx(
                                () => isPlay.value == false
                                    ? GestureDetector(
                                        onTap: () {
                                          audioplay(audioFile.path);
                                        },
                                        child: Container(
                                          height: 41,
                                          width: 41,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Color(0xff22B161),
                                                Color(0xff35B7A5),
                                                Color(0xff48BEEB),
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.play_arrow_sharp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 41,
                                        width: 41,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color:
                                                  CommonColor.greenBorderColor),
                                        ),
                                        child: Center(
                                          child: Lottie.asset(
                                                  'assets/images/waves.json')
                                              .marginOnly(
                                                  left: 3.0, right: 3.0),
                                        ),
                                      ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (recorder.isRecording) {
                                    await stop();
                                  } else {
                                    await record();
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 41,
                                  width: 41,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff23b662)),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      recorder.isRecording
                                          ? Icons.stop
                                          : Icons.mic,
                                      color: Color(0xff23b662),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  ],
                ).marginOnly(left: 20.0, right: 20.0),
                SizedBox(
                  height: clipController.isScreenLoading.value == false
                      ? 10.0
                      : 20.0,
                ),
                clipController.isScreenLoading.value == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _trimSlider(),
                      )
                    : Center(
                        child: Container(
                          // width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: LinearPercentIndicator(
                            // width: Get.width / 1.5,
                            // animation: true,
                            // animationDuration: 1000,
                            backgroundColor: Colors.transparent,
                            lineHeight: 40.0,
                            percent: progress,
                            center: Text(
                              "${(progress * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            progressColor: Color(0xff28c66e),
                          ),
                        ).marginOnly(bottom: 20.0),
                      ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    side: BorderSide(
                      color: clipController.isScreenLoading.value
                          ? Colors.grey
                          : Color(0xff23B662),
                    ),
                  ),
                  onPressed: clipController.isScreenLoading.value == true
                      ? null
                      : () async {
                          // await exportVideo();
                          shareVideoWithContact(context, clippingController);
                          print("Button press");
                          // print("Video Trip Path is ${_controller.exportVideo(onCompleted: onCompleted)}")
                        },
                  child: Text(
                    "SHARE CLIP",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: clipController.isScreenLoading.value
                            ? Colors.grey
                            : Color(0xff2CE08E),
                        letterSpacing: 0.4,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700),
                    maxLines: 2,
                  ),
                  minWidth: Get.width / 3,
                  height: 40,
                  // color: Color.fromRGBO(72, 190, 235, 1),
                  color: Color(0xff23B662).withOpacity(0.1),
                ),
              ],
            ),
          ),
        ));
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      AnimatedBuilder(
        animation: _controller.video,
        builder: (_, __) {
          duration = _controller.video.value.duration.inSeconds;
          final pos = _controller.trimPosition * duration;
          start = _controller.minTrim * duration;
          end = _controller.maxTrim * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: height / 4),
            child: Row(children: [
              Text(
                formatter(Duration(seconds: pos.toInt())),
                style: TextStyle(color: Colors.white),
              ),
              const Expanded(child: SizedBox()),
              OpacityTransition(
                visible: _controller.isTrimming,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    formatter(Duration(seconds: start.toInt())),
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    formatter(Duration(seconds: end.toInt())),
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              )
            ]),
          );
        },
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: height / 4),
        child: TrimSlider(
          controller: _controller,
          height: height,
          horizontalMargin: height / 4,
          child: TrimTimeline(
            controller: _controller,
            margin: const EdgeInsets.only(top: 10),
          ),
        ),
      )
    ];
  }

  void shareVideoWithContact(BuildContext context, ClippingController _) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              height: Get.height - 260,
              width: Get.width,
              color: Color(0xff131C3A),
              child: Obx(() => _.isBottomLoading.value
                  ? Center(
                      child: Image.asset(
                        "assets/images/gif.gif",
                        height: 300.0,
                        width: 300.0,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Container(
                                height: 5.0,
                                width: Get.width / 3,
                                decoration: BoxDecoration(
                                  color: CommonColor.textFieldBorderColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 34,
                                width: Get.width / 1.6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6.0),
                                    bottomLeft: Radius.circular(6.0),
                                    topLeft: Radius.circular(6.0),
                                    bottomRight: Radius.circular(6.0),
                                  ),
                                  color: Color(0xff455177),
                                ),
                                child: TextFormField(
                                  controller: _.searchContact,
                                  cursorColor: CommonColor.greenColor,
                                  onChanged: (c) {
                                    _.searchFunction(c);
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.green,
                                    ),
                                    // prefixIcon: Image.asset(
                                    // "assets/images/search-green.png",
                                    //
                                    // //fit: BoxFit.none,
                                    // ).marginOnly(),

                                    // ).marginOnly(left: 20,top: 9,bottom: 9,right: 11),
                                    hintText: "Search",
                                    fillColor: Color(0xff455177),
                                    contentPadding: EdgeInsets.zero,
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffD3D3D3),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff455177),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff455177),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                color: CommonColor.greenColorWithOpacity,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: _.sharingUser.length == 0
                                          ? Colors.grey
                                          : Color(0xff23B662),
                                    ),
                                    borderRadius: BorderRadius.circular(9.0)),
                                onPressed: _.sharingUser.length == 0
                                    ? null
                                    : () async {
                                        shareDialougebox(context, _);
                                      },
                                child: Text(
                                  "SHARE",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: _.sharingUser.length == 0
                                          ? Colors.grey
                                          : CommonColor.greenButtonTextColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700),
                                ),
                                minWidth: Get.width / 3.9,
                                height: 33,
                              ).marginOnly(left: 13),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: _.nodata.value
                                ? Center(
                                    child: Text(
                                      "No data found",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: _.searchcompanyUser.length == 0
                                        ? _.companyUser.length
                                        : _.searchcompanyUser.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (c, i) {
                                      return SizedBox(
                                        height: 10.0,
                                      );
                                    },
                                    itemBuilder: (c, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (_.searchcompanyUser.length ==
                                                0) {
                                              if (_.addDataList(
                                                      _.companyUser[i]['id']) ==
                                                  '${_.companyUser[i]['id']}') {
                                                _.deletedata(
                                                    _.companyUser[i]['id']);
                                              } else {
                                                _.sharingUser.add({
                                                  "senderId": _.senderId,
                                                  "senderFirstName":
                                                      _.senderFirstName,
                                                  "senderLastName":
                                                      _.senderLastName,
                                                  "recieverId": _.companyUser[i]
                                                      ['id'],
                                                  "recieverFirstName":
                                                      _.companyUser[i]
                                                          ['firstName'],
                                                  "recieverLastName":
                                                      _.companyUser[i]
                                                          ['lastName'],
                                                  "time":
                                                      DateTime.now().toString(),
                                                });
                                              }
                                            } else {
                                              if (_.addDataList(
                                                      _.searchcompanyUser[i]
                                                          ['id']) ==
                                                  '${_.searchcompanyUser[i]['id']}') {
                                                _.deletedata(
                                                    _.searchcompanyUser[i]
                                                        ['id']);
                                              } else {
                                                _.sharingUser.add({
                                                  "senderId": _.senderId,
                                                  "senderFirstName":
                                                      _.senderFirstName,
                                                  "senderLastName":
                                                      _.senderLastName,
                                                  "recieverId":
                                                      _.searchcompanyUser[i]
                                                          ['id'],
                                                  "recieverFirstName":
                                                      _.searchcompanyUser[i]
                                                          ['firstName'],
                                                  "recieverLastName":
                                                      _.searchcompanyUser[i]
                                                          ['lastName'],
                                                  "time":
                                                      DateTime.now().toString(),
                                                });
                                              }
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Color(0xff34f68a),
                                                  ),
                                                  color: _.searchcompanyUser
                                                              .length ==
                                                          0
                                                      ? _.addDataList(
                                                                  _.companyUser[
                                                                          i]
                                                                      ['id']) ==
                                                              '${_.companyUser[i]['id']}'
                                                          ? Color(0xff34f68a)
                                                          : Colors.transparent
                                                      : _.addDataList(
                                                                  _.searchcompanyUser[
                                                                          i]
                                                                      ['id']) ==
                                                              '${_.searchcompanyUser[i]['id']}'
                                                          ? Color(0xff34f68a)
                                                          : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Center(
                                                child: _.searchcompanyUser
                                                            .length ==
                                                        0
                                                    ? _.addDataList(
                                                                _.companyUser[i]
                                                                    ['id']) ==
                                                            '${_.companyUser[i]['id']}'
                                                        ? Icon(
                                                            Icons.check,
                                                            color: CommonColor
                                                                .whiteColor,
                                                            size: 40,
                                                          )
                                                        : Text(
                                                            _
                                                                .namesSplit(
                                                                    '${_.companyUser[i]['firstName']} ${_.companyUser[i]['lastName']}')
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff34f68a),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ).marginOnly(
                                                            top: 12.0,
                                                            bottom: 12.0,
                                                            //left: 5,
                                                            //right: 5
                                                          )
                                                    : _.addDataList(
                                                                _.searchcompanyUser[
                                                                    i]['id']) ==
                                                            '${_.searchcompanyUser[i]['id']}'
                                                        ? Icon(
                                                            Icons.check,
                                                            color: CommonColor
                                                                .whiteColor,
                                                            size: 40,
                                                          )
                                                        : Text(
                                                            _
                                                                .namesSplit(
                                                                    '${_.searchcompanyUser[i]['firstName']} ${_.searchcompanyUser[i]['lastName']}')
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff34f68a),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ).marginOnly(
                                                            top: 12.0,
                                                            bottom: 12.0,
                                                            //left: 5,
                                                            //right: 5
                                                          ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2.5,
                                              child: Text(
                                                _.searchcompanyUser.length == 0
                                                    ? '${_.companyUser[i]['firstName']} ${_.companyUser[i]['lastName']}'
                                                    : '${_.searchcompanyUser[i]['firstName']} ${_.searchcompanyUser[i]['lastName']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(
                                              'assets/images/logo (2).png',
                                              height: 30,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ]).marginOnly(left: 20, top: 20)),
            );
          });
        });
  }

  //<--------------------------------Dialouge Box ForClip information-----------------
  Future<void> showClipInformation(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff131C3A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'What’s a Clip?',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
          content: Container(
            height: 130.0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A clip is a part of a video or a live stream. With the clip feature, you can clip videos and share them or save them in your library.',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 0.4,
                      fontFamily: 'Roboto'),
                ),
                Center(
                  child: MaterialButton(
                    color: CommonColor.greenColorWithOpacity,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff23B662),
                        ),
                        borderRadius: BorderRadius.circular(9.0)),
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text(
                      "GOT IT",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          color: CommonColor.greenButtonTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    minWidth: Get.width / 3.5,
                    height: 38,
                  ).marginOnly(top: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

//<--------------------------------Dialouge Box Confirmation Share information-----------------

  Future<void> shareDialougebox(context, ClippingController _) {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff131C3A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Are you sure?',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
          content: Container(
            height: 100.0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You’ll share the clip with the people you selected',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 0.4,
                      fontFamily: 'Roboto'),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: Text(
                        "CANCEL",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: CommonColor.cancelButtonColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      minWidth: Get.width / 3.5,
                      height: 38,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    MaterialButton(
                      color: CommonColor.greenColorWithOpacity,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xff23B662),
                          ),
                          borderRadius: BorderRadius.circular(9.0)),
                      onPressed: () async {
                        print("Start Time $start");
                        print("Start Time $end");
                        print(
                            "Start Time ${_controller.video.value.duration.inSeconds}");
                        print("End Time $audioFile");
                        if (_.title.text.isEmpty &&
                            _.des.text.isEmpty &&
                            audioFile == null &&
                            start == 0.0 &&
                            end == end) {
                          Get.back();
                          await _.sharing(widget.jobId);
                        } else {
                          if (start != 0.0 ||
                              end !=
                                  _controller.video.value.duration.inSeconds) {
                            if (_.title.text == '' && _.title.text.isEmpty) {
                              CustomSnackBar.showSnackBar(
                                  title: "Job title is required",
                                  message: "",
                                  isWarning: true,
                                  backgroundColor: CommonColor.greenColor);
                            } else {
                              print("check ${_.sharingUser.toString()}");
                              Get.back();
                              _.searchContact.clear();
                              _.update();
                              exportVideo();
                            }
                          } else {}
                        }
                      },
                      child: Text(
                        "SHARE",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: CommonColor.greenButtonTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      minWidth: Get.width / 3.5,
                      height: 38,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
