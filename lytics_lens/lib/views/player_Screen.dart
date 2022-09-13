import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/playerController.dart';
import 'package:lytics_lens/views/Components/widget/common_textfield.dart';
import 'package:lytics_lens/views/Components/widget/text_highlight.dart';
import 'package:lytics_lens/views/clipping_screen.dart';
import 'package:lytics_lens/widget/webview_container.dart';
import 'package:lottie/lottie.dart';

class PlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: GetBuilder<VideoController>(
        init: VideoController(),
        builder: (_) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: () {
                  _.betterPlayerController.dispose();
                  Get.back();
                },
                child: Icon(
                  Icons.keyboard_backspace_rounded,
                ),
              ),
            ),
            // bottomNavigationBar: GlobalBottomNav(),
            body: bodyData(context, _),
          );
        },
      ),
    );
  }

  Widget bodyData(context, VideoController _) {
    return OrientationBuilder(builder: (context, orientation) {
      // if (orientation == Orientation.portrait) {
      //   // _.betterPlayerController.enterFullScreen();
      //   SystemChrome.setPreferredOrientations(
      //       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      // }
      // else {
      //   _.betterPlayerController.enterFullScreen();
      // }
      return Container(
        color: CommonColor.backgroundColour,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: _.isLoading
            ? Center(
                child: Image.asset(
                  "assets/images/gif.gif",
                  height: 300.0,
                  width: 300.0,
                ),
              )
            : _.isSocket
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 235,
                        width: Get.width,
                        child: Stack(
                          children: [
                            Container(
                              height: 235,
                              width: Get.width,
                              child: CachedNetworkImage(
                                imageUrl: _.imagePathLast,
                                placeholder: (c, e) => Lottie.asset(
                                    "assets/images/imgload.json",
                                    height: 235,
                                    width: Get.width,
                                    fit: BoxFit.cover),
                                errorWidget: (c, e, r) => Lottie.asset(
                                    "assets/images/imgload.json",
                                    fit: BoxFit.cover),
                                height: 235,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 235,
                              width: Get.width,
                              color: Color.fromARGB(189, 0, 0, 0),
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Player Container

                      _.source.toLowerCase() == 'tv' ||
                              _.source.toLowerCase() == 'online'
                          ? Column(
                              children: [
                                Container(
                                  color: CommonColor.backgroundColour,
                                  height: 235,
                                  width: Get.width,
                                  child: BetterPlayer(
                                    controller: _.betterPlayerController,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Divider(
                                    thickness: 2.0,
                                    height: 1.0,
                                    color: _.source.toLowerCase() == 'tv'
                                        ? Color(0xff00FFD9)
                                        : _.source.toLowerCase() == 'online'
                                            ? Color(0xff76D14B)
                                            : Color(0xffffd9),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Get.width / 1.3,
                                          child: Text(
                                            "${_.getTopicString(_.segments)}",
                                            textScaleFactor: 1.0,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: _.source.toLowerCase() ==
                                                      'tv'
                                                  ? Color(0xff00FFD9)
                                                  : _.source.toLowerCase() ==
                                                          'online'
                                                      ? Color(0xff76D14B)
                                                      : Color(0xffffd9),
                                              fontSize: 16.0,
                                              letterSpacing: 0.4,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).marginOnly(top: 10.0),
                                    Container(
                                      width: 36,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _.source.toLowerCase() ==
                                                      'tv'
                                                  ? Color(0xff00FFD9)
                                                  : _.source.toLowerCase() ==
                                                          'online'
                                                      ? Color(0xff76D14B)
                                                      : Color(0xffffd9)),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(2.0),
                                            bottomRight: Radius.circular(2.0),
                                          ),
                                          color: Colors.transparent),
                                      child: Center(
                                        child: Text(
                                          '${_.source.toUpperCase()}',
                                          style: TextStyle(
                                            color:
                                                _.source.toLowerCase() == 'tv'
                                                    ? Color(0xff00FFD9)
                                                    : _.source.toLowerCase() ==
                                                            'online'
                                                        ? Color(0xff76D14B)
                                                        : Color(0xffffd9),
                                            fontSize: 10.0,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                          ),
                                        ).paddingOnly(
                                            left: 8.0,
                                            right: 7.0,
                                            top: 5.0,
                                            bottom: 4.0),
                                      ),
                                    )
                                  ],
                                ).marginOnly(left: 15.0, right: 15.0),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   "By $anchorName",
                                      //   textScaleFactor: 1.0,
                                      //   style: TextStyle(
                                      //     color: Color(0xffd3d3d3),
                                      //     fontSize: 9.5,
                                      //     fontWeight: FontWeight.w400,
                                      //     letterSpacing: 0.4,
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   width: 13.0,
                                      // ),
                                      Icon(
                                        Icons.access_time,
                                        size: 10.0,
                                        color: Colors.white,
                                      ).marginOnly(bottom: 2),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "${_.convertDateUtc(_.programDate)}",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.asset(
                                          "assets/images/dot2.png",
                                          height: 3,
                                          width: 3,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "${_.convertTime(_.programTime)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0.4,
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "${_.channel}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0.4,
                                          fontSize: 10,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 5.0,
                                      // ),
                                      Spacer(),
                                      _.sharedList.length != 0
                                          ? GestureDetector(
                                              onTap: () {
                                                sharedUser(
                                                    context, _.sharedList);
                                              },
                                              child: Text(
                                                '${_.sharedList.length}',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: CommonColor.whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        width: _.sharedList.length == 0
                                            ? 0.0
                                            : 3.0,
                                      ),
                                      _.sharedList.length != 0
                                          ? GestureDetector(
                                              onTap: () {
                                                sharedUser(
                                                    context, _.sharedList);
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: CommonColor.whiteColor,
                                                size: 18,
                                              ))
                                          : SizedBox(),
                                      SizedBox(
                                        width: _.sharedList.length == 0
                                            ? 0.0
                                            : 15.0,
                                      ),
                                      //------------Add share icon---------------
                                      InkWell(
                                        onTap: () async {
                                          Get.to(() => ClippingScreen(
                                                file: _.videoFilePath!,
                                                jobId: _.jobId,
                                              ));
                                          // _.betterPlayerController
                                          //     .pause();
                                          // shareVideoWithContact(
                                          //     context, _);
                                        },
                                        child: Column(children: [
                                          Image.asset(
                                              "assets/images/shareicon.png"),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Share",
                                            style: TextStyle(
                                              color: Color(0xff22B161),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ]).marginOnly(left: 15.0, right: 15.0),
                              ],
                            )
                          : WebViewContainer(
                              imageurl: _.thumbnail,
                              thumbnailPath: _.imagePathLast,
                              programDes: _.title,
                              programDate: _.convertDateUtc(_.programDate),
                              source: _.source,
                              anchorName: _.anchor[0].toString(),
                            ),
                      //SizedBox(height: 1.0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          color: Color(0xffd3d3d3).withOpacity(0.16),
                          thickness: 1.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _.selectedTab.text = 'Details';
                              _.update();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.5),
                                topRight: Radius.circular(3.5),
                              ),
                              child: Container(
                                height:
                                    _.selectedTab.text == 'Details' ? 44 : 38,
                                width: Get.width / 4.0,
                                decoration: BoxDecoration(
                                  color: _.selectedTab.text == 'Details'
                                      ? Color(0xff48beeb)
                                      : Color.fromRGBO(72, 190, 235, 0.19),
                                  border: Border(
                                    top: BorderSide(
                                      width: 2,
                                      color: Color(0xff48beeb),
                                    ),
                                    left: BorderSide(
                                      width: 3,
                                      color: Color(0xff48beeb),
                                    ),
                                    right: BorderSide(
                                      width: 3,
                                      color: Color(0xff48beeb),
                                    ),
                                  ),
                                  // border: Border(
                                  //     top: BorderSide(
                                  //         color:_.selectedTab.text == 'Details' ?Color(0xff48beeb) : Color(0xff48beeb),
                                  //         width: 1)),
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(5.0),
                                  //   topRight: Radius.circular(5.0),
                                  // ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Details',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      letterSpacing: 0.4,
                                      color: _.selectedTab.text == 'Details'
                                          ? Colors.white
                                          : Color(0xff48beeb),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              _.selectedTab.text = 'Transcription';
                              _.update();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.5),
                                topRight: Radius.circular(3.5),
                              ),
                              child: Container(
                                height: _.selectedTab.text == 'Transcription'
                                    ? 44
                                    : 38,
                                width: Get.width / 4.0,
                                decoration: BoxDecoration(
                                  color: _.selectedTab.text == 'Transcription'
                                      ? Color(0xff1cb0c2)
                                      : Color.fromRGBO(72, 190, 235, 0.19),
                                  border: Border(
                                    top: BorderSide(
                                      width: 2,
                                      color: Color(0xff1cb0c2),
                                    ),
                                    left: BorderSide(
                                      width: 3,
                                      color: Color(0xff1cb0c2),
                                    ),
                                    right: BorderSide(
                                      width: 3,
                                      color: Color(0xff1cb0c2),
                                    ),
                                    bottom: BorderSide.none,
                                  ),
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(5.0),
                                  //   topRight: Radius.circular(5.0),
                                  // ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Transcription',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      letterSpacing: 0.4,
                                      color:
                                          _.selectedTab.text == 'Transcription'
                                              ? Colors.white
                                              : Color(0xff1cb0c2),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              _.selectedTab.text = 'Translation';
                              _.update();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.5),
                                topRight: Radius.circular(3.5),
                              ),
                              child: Container(
                                height: _.selectedTab.text == 'Translation'
                                    ? 44
                                    : 38,
                                width: Get.width / 4.0,
                                decoration: BoxDecoration(
                                  color: _.selectedTab.text == 'Translation'
                                      ? CommonColor.gradientColor
                                      : CommonColor.gradientColor2,
                                  border: Border(
                                    top: BorderSide(
                                      width: 2,
                                      color: CommonColor.gradientColor,
                                    ),
                                    left: BorderSide(
                                      width: 3,
                                      color: CommonColor.gradientColor,
                                    ),
                                    right: BorderSide(
                                      width: 3,
                                      color: CommonColor.gradientColor,
                                    ),
                                    bottom: BorderSide.none,
                                  ),
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(5.0),
                                  //   topRight: Radius.circular(5.0),
                                  // ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Translation',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      letterSpacing: 0.4,
                                      color: _.selectedTab.text == 'Translation'
                                          ? Colors.white
                                          : CommonColor.greenTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: Get.width,
                            // height: MediaQuery.of(context).size.height / 2.5,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: _.selectedTab.text == 'Transcription'
                                        ? Color(0xff1cb0c2)
                                        : _.selectedTab.text == 'Translation'
                                            ? CommonColor.greenBorderColor
                                            : Color(0xff48beeb),
                                    width: 2),
                              ),
                              color: CommonColor.bottomSheetBackgroundColour,
                            ),
                            child: _.selectedTab.text == 'Transcription'
                                ? Column(
                                    children: [
                                      Expanded(
                                          child:
                                              _.transcriptionlistdir.isNotEmpty
                                                  ? Container(
                                                      width: Get.width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                      ),
                                                      child: RawScrollbar(
                                                        thumbColor:
                                                            Color(0xff1cb0c2),
                                                        radius:
                                                            Radius.circular(20),
                                                        mainAxisMargin: 5.0,
                                                        thickness: 5,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              _.source.toLowerCase() == 'website' ||
                                                                      _.source.toLowerCase() ==
                                                                          'print' ||
                                                                      _.source.toLowerCase() ==
                                                                          'blog'
                                                                  ? CommonTextField3(
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter.deny(
                                                                            RegExp(r"\s\b|\b\s"))
                                                                      ],
                                                                      hintText:
                                                                          'Search Transcription',
                                                                      prefixIcon:
                                                                          Icons
                                                                              .search,
                                                                      controller:
                                                                          _.urdusearchtext,
                                                                      fillcolor:
                                                                          Color(
                                                                              0xffEAEAEA),
                                                                    ).marginOnly(
                                                                      left: 50,
                                                                      right: 50,
                                                                      bottom:
                                                                          14)
                                                                  : CommonTextField4(
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter.deny(
                                                                            RegExp(r"\s\b|\b\s"))
                                                                      ],
                                                                      hintText:
                                                                          'لفظ تلاش کریں',
                                                                      prefixIcon:
                                                                          Icons
                                                                              .search,
                                                                      controller:
                                                                          _.urdusearchtext,
                                                                      fillcolor:
                                                                          Color(
                                                                              0xffEAEAEA),
                                                                    ).marginOnly(
                                                                      left: 50,
                                                                      right: 50,
                                                                      bottom:
                                                                          14),
                                                              _.source.toLowerCase() == 'tv' ||
                                                                      _.source.toLowerCase() ==
                                                                          'online' ||
                                                                      _.source.toLowerCase() ==
                                                                          'website' ||
                                                                      _.source.toLowerCase() ==
                                                                          'print' ||
                                                                      _.source.toLowerCase() ==
                                                                          'blog'
                                                                  ? InteractiveViewer(
                                                                      child:
                                                                          Directionality(
                                                                        textDirection: _.source.toLowerCase() == 'website' ||
                                                                                _.source.toLowerCase() == 'print' ||
                                                                                _.source.toLowerCase() == 'blog'
                                                                            ? TextDirection.ltr
                                                                            : TextDirection.rtl,
                                                                        child:
                                                                            Wrap(
                                                                          children: [
                                                                            for (int i = 0;
                                                                                i < _.transcriptionlistdir.length;
                                                                                i++)
                                                                              GestureDetector(
                                                                                onDoubleTap: () {
                                                                                  String splittext = _.transcriptionlistdir[i]['duration'].split('-').first;
                                                                                  String splittext2 = _.transcriptionlistdir[i]['duration'].split('-').last;
                                                                                  double starttime = double.parse(splittext);
                                                                                  double endtime = double.parse(splittext2);
                                                                                  print('Tap Start Time is $starttime');
                                                                                  print('Tap End Time is $endtime');
                                                                                  _.betterPlayerController.videoPlayerController!.seekTo(Duration(seconds: starttime.toInt()));
                                                                                  _.update();
                                                                                },
                                                                                child: _.source.toLowerCase() == 'website' || _.source.toLowerCase() == 'print' || _.source.toLowerCase() == 'blog'
                                                                                    ? TextHighlighting(
                                                                                        text: '${_.transcriptionlistdir[i]['line']}',
                                                                                        highlights: [
                                                                                          _.urdusearchtext.text.isEmpty ? "ssadsauadnasjjwjeiweuywdsjandsakjdsad" : _.urdusearchtext.text
                                                                                        ],
                                                                                        style: TextStyle(fontSize: 13.0, letterSpacing: 0.4, fontWeight: FontWeight.w400, fontFamily: "urdu"),
                                                                                        textAlign: _.source.toLowerCase() == 'website' || _.source.toLowerCase() == 'print' || _.source.toLowerCase() == 'blog' ? TextAlign.start : TextAlign.center,
                                                                                      )
                                                                                    : FittedBox(
                                                                                        fit: BoxFit.fill,
                                                                                        child: Container(
                                                                                          height: 20.0,
                                                                                          color: _.check(_.transcriptionlistdir[i]['duration'], _.playerTime!),
                                                                                          child: TextHighlighting(
                                                                                            text: '${_.transcriptionlistdir[i]['line']}',
                                                                                            highlights: [
                                                                                              _.urdusearchtext.text.isEmpty ? "ssadsauadnasjjwjeiweuywdsjandsakjdsad" : _.urdusearchtext.text
                                                                                            ],
                                                                                            style: TextStyle(fontSize: 13.0, letterSpacing: 0.4, fontWeight: FontWeight.w400, fontFamily: "urdu"),
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                              )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : InteractiveViewer(
                                                                      child:
                                                                          Directionality(
                                                                        textDirection:
                                                                            TextDirection.ltr,
                                                                        child:
                                                                            Text(
                                                                          '${_.transcriptionText}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.4,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                "Roboto",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ).marginAll(9.0),
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                      'Not Available',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          letterSpacing: 0.4,
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white),
                                                    ))),
                                    ],
                                  ).marginAll(10.0)
                                : _.selectedTab.text == 'Translation'
                                    ? Column(
                                        children: [
                                          Expanded(
                                              child: _.translationlist
                                                      .isNotEmpty
                                                  ? Container(
                                                      width: Get.width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                      ),
                                                      child: RawScrollbar(
                                                        thumbColor:
                                                            Color(0xff22B161),
                                                        radius:
                                                            Radius.circular(20),
                                                        mainAxisMargin: 5.0,
                                                        thickness: 5,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              CommonTextField3(
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .deny(RegExp(
                                                                          r"\s\b|\b\s"))
                                                                ],
                                                                hintText:
                                                                    'Search Translation',
                                                                prefixIcon:
                                                                    Icons
                                                                        .search,
                                                                controller: _
                                                                    .englishsearchtext,
                                                                fillcolor: Color(
                                                                    0xffEAEAEA),
                                                              ).marginOnly(
                                                                  left: 50,
                                                                  right: 50,
                                                                  bottom: 14),
                                                              InteractiveViewer(
                                                                child:
                                                                    Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  child: Wrap(
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: [
                                                                      for (int i =
                                                                              0;
                                                                          i < _.translationlist.length;
                                                                          i++)
                                                                        GestureDetector(
                                                                          onDoubleTap:
                                                                              () {
                                                                            String
                                                                                splittext =
                                                                                _.translationlist[i]['duration'].split('-').first;
                                                                            String
                                                                                splittext2 =
                                                                                _.translationlist[i]['duration'].split('-').last;
                                                                            double
                                                                                starttime =
                                                                                double.parse(splittext);
                                                                            double
                                                                                endtime =
                                                                                double.parse(splittext2);
                                                                            print('Tap Start Time is $starttime');
                                                                            print('Tap End Time is $endtime');
                                                                            _.betterPlayerController.videoPlayerController!.seekTo(Duration(seconds: starttime.toInt()));
                                                                            _.update();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color: _.source.toLowerCase() == 'website' || _.source.toLowerCase() == 'print' || _.source.toLowerCase() == 'blog'
                                                                                ? Colors.white
                                                                                : _.check1(_.translationlist[i]['duration'], _.playerTime!),
                                                                            child:
                                                                                TextHighlighting(
                                                                              caseSensitive: false,
                                                                              text: '${_.translationlist[i]['line']}',
                                                                              highlights: [
                                                                                _.englishsearchtext.text.isEmpty ? "ssadsauadnasjjwjeiweuywdsjandsakjdsad" : _.englishsearchtext.text
                                                                              ],
                                                                              style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                letterSpacing: 0.4,
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          ),
                                                                        )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ).marginAll(10.0),
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                      'Not Available',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          letterSpacing: 0.4,
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white),
                                                    ))),
                                        ],
                                      ).marginAll(10.0)
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: RawScrollbar(
                                              thumbColor: Color(0xff48beeb),
                                              radius: Radius.circular(20),
                                              mainAxisMargin: 5.0,
                                              thickness: 5,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 110,
                                                          height: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff3C3D5C),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                          child: Center(
                                                            child: Text(
                                                              '${_.programType}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        _.isAudio
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  _.betterPlayerController
                                                                      .pause();
                                                                  _.audioplay(_
                                                                      .audioPath);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 34,
                                                                  width: 34,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: Alignment
                                                                          .topRight,
                                                                      end: Alignment
                                                                          .bottomLeft,
                                                                      colors: [
                                                                        Color(
                                                                            0xff22B161),
                                                                        Color(
                                                                            0xff35B7A5),
                                                                        Color(
                                                                            0xff48BEEB),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Obx(
                                                                        () =>
                                                                            Icon(
                                                                              _.isPlay.value == false ? Icons.play_arrow_outlined : Icons.stop,
                                                                              color: Colors.white,
                                                                            )),
                                                                  ),
                                                                ).marginOnly(
                                                                        top:
                                                                            20),
                                                              )
                                                            : SizedBox(),
                                                        _.isComment
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  print("comment added " +
                                                                      _.comment);
                                                                  showCommentDialouge(
                                                                      context,
                                                                      _);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 34,
                                                                  width: 34,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: Alignment
                                                                          .topRight,
                                                                      end: Alignment
                                                                          .bottomLeft,
                                                                      colors: [
                                                                        Color(
                                                                            0xff22B161),
                                                                        Color(
                                                                            0xff35B7A5),
                                                                        Color(
                                                                            0xff48BEEB),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .comment,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ).marginOnly(
                                                                        top: 20,
                                                                        left:
                                                                            7),
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ).marginOnly(bottom: 16),
                                                    Text(
                                                      "${_.topic}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white),
                                                    ).marginOnly(bottom: 5),
                                                    Text(
                                                      _.subTopic.length == 0
                                                          ? ''
                                                          : '${_.subTopicString(_.subTopic)}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    ).marginOnly(bottom: 11),
                                                    Row(
                                                      children: [
                                                        // Text(
                                                        //   "Anchor - ",
                                                        //   style: TextStyle(
                                                        //       color: Color(
                                                        //           0xffC4C4C4),
                                                        //       fontWeight:
                                                        //           FontWeight
                                                        //               .w300,
                                                        //       fontSize: 10),
                                                        // ),
                                                        Flexible(
                                                          child: Text(
                                                            _.anchor.length == 0
                                                                ? ''
                                                                : '${_.anchorString(_.anchor)}',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xffC4C4C4),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                        _.guest.length != 0? Container(
                                                          height: 10,
                                                          width: 1,
                                                          color:
                                                              Color(0xffC4C4C4),
                                                        ).marginSymmetric(
                                                            horizontal: 8):SizedBox(),
                                                        // Text(
                                                        //   "Guests - ",
                                                        //   style: TextStyle(
                                                        //       color: Color(
                                                        //           0xffC4C4C4),
                                                        //       fontWeight:
                                                        //           FontWeight
                                                        //               .w300,
                                                        //       fontSize: 10),
                                                        // ),
                                                        Flexible(
                                                          child: Text(
                                                            _.guest.length == 0
                                                                ? ''
                                                                : '${_.guestString(_.guest)}',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xffC4C4C4),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    _.description == ''
                                                        ? SizedBox()
                                                        : SizedBox(
                                                            height: 10,
                                                          ),
                                                    Text(
                                                      "${_.description}",
                                                      maxLines: 100,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Color(
                                                              0xffC4C4C4)),
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              Get.width / 3.5,
                                                          child: Text(
                                                            "Keywords",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ).marginOnly(
                                                              top: 10.0),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width / 2.2,
                                                          child: showQueryWords(
                                                              _, _.source),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              Get.width / 3.5,
                                                          child: Text(
                                                            "Related Hasgtags",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ).marginOnly(
                                                              top: 12.0),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width / 2.2,
                                                          child: showHashTags(
                                                              _, _.source),
                                                        ),
                                                      ],
                                                    ),
                                                    // DeatilContainer(
                                                    //   heading:
                                                    //       'Related Hashtags',
                                                    //   isWidget: true,
                                                    //   chips:
                                                    //       showHashTags(
                                                    //           _,
                                                    //           _.source),
                                                    //   isDivider: false,
                                                    // ),
                                                    // DeatilContainer(
                                                    //   heading: 'Event',
                                                    //   content:
                                                    //       '${_.event}',
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 10,
                                                    // ),
                                                    // DeatilContainer(
                                                    //   heading: 'Topic',
                                                    //   content: _.topic
                                                    //               .toString()
                                                    //               .length ==
                                                    //           2
                                                    //       ? ''
                                                    //       : '${_.topic}',
                                                    //   isDivider: true,
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 10.0,
                                                    // ),
                                                    // DeatilContainer(
                                                    //   heading:
                                                    //       'Sub-Topic',
                                                    //   content: _.subTopic
                                                    //               .length ==
                                                    //           0
                                                    //       ? ''
                                                    //       : '${_.subTopicString(_.subTopic)}',
                                                    //   isDivider: true,
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 10.0,
                                                    // ),
                                                    // DeatilContainer(
                                                    //   heading: 'Anchor',
                                                    //   content: _.anchor
                                                    //               .length ==
                                                    //           0
                                                    //       ? ''
                                                    //       : '${_.anchorString(_.anchor)}',
                                                    //   isDivider: true,
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 10.0,
                                                    // ),
                                                    // DeatilContainer(
                                                    //   heading: 'Guests',
                                                    //   content: _.guest
                                                    //               .length ==
                                                    //           0
                                                    //       ? ''
                                                    //       : '${_.guestString(_.guest)}',
                                                    //   isDivider: true,
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 10.0,
                                                    // ),
                                                    // DeatilContainer(
                                                    //   heading:
                                                    //       'TV Rating',
                                                    //   content: '',
                                                    //   isDivider: true,
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 10.0,
                                                    // ),
                                                    // _.source.toLowerCase() ==
                                                    //         'online'
                                                    //     ? DeatilContainer(
                                                    //         heading:
                                                    //             'YouTube Views',
                                                    //         content: '',
                                                    //         isDivider:
                                                    //             true,
                                                    //       )
                                                    //     : DeatilContainer(
                                                    //         heading:
                                                    //             'Program Type',
                                                    //         content:
                                                    //             '${_.programType}',
                                                    //         isDivider:
                                                    //             true,
                                                    //       ),
                                                    // SizedBox(
                                                    //   height: 10.0,
                                                    // ),
                                                    // _.source
                                                    //                 .toLowerCase() ==
                                                    //             'website' ||
                                                    //         _.source.toLowerCase() ==
                                                    //             'print' ||
                                                    //         _.source.toLowerCase() ==
                                                    //             'blog'
                                                    //     ? SizedBox()
                                                    //     : DeatilContainer(
                                                    //         heading:
                                                    //             'Analysis',
                                                    //         content:
                                                    //             '${_.statment}',
                                                    //         isDivider:
                                                    //             true,
                                                    //       ),
                                                    // SizedBox(
                                                    //   height: 20.0,
                                                    // ),
                                                    // DeatilContainer(
                                                    //   heading:
                                                    //       'Related Hashtags',
                                                    //   isWidget: true,
                                                    //   chips:
                                                    //       showHashTags(
                                                    //           _,
                                                    //           _.source),
                                                    //   isDivider: true,
                                                    // ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                  ],
                                                ),
                                              ).marginOnly(
                                                  top: 16,
                                                  left: 25.0,
                                                  right: 25.0),
                                            ),
                                          )
                                        ],
                                      ),
                          ).marginOnly(left: 13.0, right: 13.0, bottom: 13.0),
                        ),
                      ),
                    ],
                  ),
      );
    });
  }

  Widget showHashTags(_, String source) {
    List<Widget> g = [];
    if (source.toLowerCase() == 'tv') {
      for (int i = 0; i < _.hashTags.length; i++) {
        g.add(FittedBox(
          fit: BoxFit.fill,
          child: Container(
            height: 27,
            decoration: BoxDecoration(
              color: Color(0xff393D63),
              border: Border.all(color: Color(0xff000000).withOpacity(0.1)),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Center(
              child: Text(
                "${_.hashTags[i]}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ).marginOnly(left: 15.0, right: 15.0),
            ),
          ),
        ).marginAll(5.0));
      }
    } else {
      for (int i = 0; i < _.hashTags.length; i++) {
        _.hashTags.forEach((e) {
          g.add(FittedBox(
            fit: BoxFit.fill,
            child: Container(
              height: 27,
              decoration: BoxDecoration(
                color: Color(0xff393D63),
                border: Border.all(color: Color(0xff000000).withOpacity(0.1)),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Center(
                child: Text(
                  "$e",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ).marginOnly(left: 15.0, right: 15.0),
              ),
            ),
          ).marginAll(5.0));
        });
      }
    }

    return Wrap(
      // alignment: WrapAlignment.center,
      // crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }

  //<--------------------------------- QueryWords --------------------------
  Widget showQueryWords(_, String source) {
    List<Widget> g = [];
    if (source.toLowerCase() == 'tv') {
      for (int i = 0; i < _.queryWords.length; i++) {
        g.add(FittedBox(
          fit: BoxFit.fill,
          child: Container(
            height: 27,
            decoration: BoxDecoration(
              color: Color(0xff393D63),
              border: Border.all(color: Color(0xff000000).withOpacity(0.1)),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Center(
              child: Text(
                "${_.queryWords[i]['word']}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ).marginOnly(left: 15.0, right: 15.0),
            ),
          ),
        ).marginAll(5.0));
      }
    } else {
      for (int i = 0; i < _.queryWords.length; i++) {
        _.queryWords[i]['words'].forEach((e) {
          g.add(FittedBox(
            fit: BoxFit.fill,
            child: Container(
              height: 27,
              decoration: BoxDecoration(
                color: Color(0xff393D63),
                border: Border.all(color: Color(0xff000000).withOpacity(0.1)),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Center(
                child: Text(
                  "$e",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ).marginOnly(left: 15.0, right: 15.0),
              ),
            ),
          ).marginAll(5.0));
        });
      }
    }

    return Wrap(
      // alignment: WrapAlignment.center,
      // crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }

  void sharedUser(BuildContext context, List user) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              height: Get.height / 2.5,
              width: Get.width,
              color: Color(0xff131C3A),
              child: Column(
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
                      height: 20.0,
                    ),
                    Center(
                      child: Text(
                        'Shared with',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: CommonColor.whiteColor,
                            fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: user.length,
                        shrinkWrap: true,
                        separatorBuilder: (c, i) {
                          return SizedBox(
                            height: 10.0,
                          );
                        },
                        itemBuilder: (c, i) {

                          print( 'First name is ${user[i]['recieverFirstName']}',);
                          return Text(
                            '${user[i]['recieverFirstName']}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ]).marginOnly(left: 20, top: 20),
            );
          });
        });
  }

  //<-----------------------------Share video With Contact Bottom sheet-------------

  void shareVideoWithContact(BuildContext context, VideoController _) {
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
                                color: CommonColor.newButtonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0)),
                                onPressed: () async {
                                  shareDialougebox(context, _);
                                },
                                child: Text(
                                  "Share Clip",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                                minWidth: 125,
                                height: 35,
                              ).marginOnly(left: 13),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: ListView.separated(
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
                                      if (_.searchcompanyUser.length == 0) {
                                        if (_.addDataList(
                                                _.companyUser[i]['id']) ==
                                            '${_.companyUser[i]['id']}') {
                                          _.deletedata(_.companyUser[i]['id']);
                                        } else {
                                          _.sharingUser.add({
                                            "senderId": _.senderId,
                                            "senderFirstName":
                                                _.senderFirstName,
                                            "senderLastName": _.senderLastName,
                                            "recieverId": _.companyUser[i]
                                                ['id'],
                                            "recieverFirstName":
                                                _.companyUser[i]['firstName'],
                                            "recieverLastName": _.companyUser[i]
                                                ['lastName'],
                                          });
                                        }
                                      } else {
                                        if (_.addDataList(
                                                _.searchcompanyUser[i]['id']) ==
                                            '${_.searchcompanyUser[i]['id']}') {
                                          _.deletedata(
                                              _.searchcompanyUser[i]['id']);
                                        } else {
                                          _.sharingUser.add({
                                            "senderId": _.senderId,
                                            "senderFirstName":
                                                _.senderFirstName,
                                            "senderLastName": _.senderLastName,
                                            "recieverId": _.searchcompanyUser[i]
                                                ['id'],
                                            "recieverFirstName":
                                                _.searchcompanyUser[i]
                                                    ['firstName'],
                                            "recieverLastName":
                                                _.searchcompanyUser[i]
                                                    ['lastName'],
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
                                            color: _.searchcompanyUser.length ==
                                                    0
                                                ? _.addDataList(_.companyUser[i]
                                                            ['id']) ==
                                                        '${_.companyUser[i]['id']}'
                                                    ? Color(0xff34f68a)
                                                    : Colors.transparent
                                                : _.addDataList(
                                                            _.searchcompanyUser[
                                                                i]['id']) ==
                                                        '${_.searchcompanyUser[i]['id']}'
                                                    ? Color(0xff34f68a)
                                                    : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: _.searchcompanyUser.length == 0
                                              ? _.addDataList(_.companyUser[i]
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
                                                          color:
                                                              Color(0xff34f68a),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Roboto'),
                                                    ).marginOnly(
                                                      top: 12.0,
                                                      bottom: 12.0,
                                                      //left: 5,
                                                      //right: 5
                                                    )
                                              : _.addDataList(
                                                          _.searchcompanyUser[i]
                                                              ['id']) ==
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
                                                          color:
                                                              Color(0xff34f68a),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Roboto'),
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
  Future<void> showClipInformation(context, VideoController _) async {
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
                  'A clip is a 5 - 60 second part of a video or a live stream. With the clip feature, you can clip videos and share them or save them in your library.',
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
                    color: CommonColor.newButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text(
                      "GOT IT",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    minWidth: 80,
                    height: 30,
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

  Future<void> shareDialougebox(context, VideoController _) async {
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
                        print("check ${_.sharingUser.toString()}");
                        Get.back();
                        _.searchContact.clear();
                        _.update();
                        await _.sharing();
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

  //---------------------------Comment Box---------------

  Future<void> showCommentDialouge(context, VideoController _) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff131C3A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: Text(
            'Description',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
          content: Text(
            '${_.comment}',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
        );
      },
    );
  }
}
