import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Controllers/selectvideo_controller.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/utils/commoncolor.dart';
import 'package:lottie/lottie.dart';
import '../player_Screen.dart';
import 'Global_BottmNav.dart';
import 'package:resize/resize.dart';

class SelectVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        ),
        bottomNavigationBar: GlobalBottomNav(),
        body: bodyData(context));
  }

  Widget bodyData(context) {
    return GetBuilder<SelectVideoController>(
      init: SelectVideoController(),
      builder: (_) {
        return _.isLoading
            ? Center(
                child: Image.asset(
                  "assets/images/gif.gif",
                  height: 300.0,
                  width: 300.0,
                ),
              )
            : Obx(() {
                return _.networkController.networkStatus.value == false
                    ? noInternetConnection()
                    : SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          //height: MediaQuery.of(context).size.height,
                          color: Color(
                            0xFF2D2F3A,
                          ),
                          //color: Colors.white,

                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 145,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          //color: Color(0xFF2D2F3A,),
                                          // color: Colors.white,
                                          child: CachedNetworkImage(
                                            imageUrl: _.storage.hasData("Url")
                                                ? "${_.storage.read("Url").toString()}/thumbnails/${_.thumbnailpath}"
                                                : "${ApiData.thumbnailPath + _.thumbnailpath}",
                                            placeholder: (c, e) => Lottie.asset(
                                              "assets/images/imgload.json",
                                            ),
                                            errorWidget: (c, e, r) =>
                                                Lottie.asset(
                                              "assets/images/imgload.json",
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: VerticalDivider(
                                          width: 2.0,
                                          color: Color(0xFFD3D3D3),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Container(
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        color: Color(
                                          0xFF2D2F3A,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6, top: 8),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      _.storage.hasData("Url")
                                                          ? "${_.channelLogo}"
                                                          : "${_.channelLogo}",

                                                  // _.searchjob[index]['thumbnailPath'],
                                                  placeholder: (c, e) =>
                                                      Lottie.asset(
                                                          "assets/images/imgload.json",
                                                          fit: BoxFit.cover),
                                                  errorWidget: (c, e, r) =>
                                                      Lottie.asset(
                                                          "assets/images/imgload.json",
                                                          fit: BoxFit.cover),
                                                  width: 15.w,
                                                  height: 15.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6.0,
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(
                                                  "${_.event}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                )),
                                            SizedBox(
                                              height: 6.0,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 6.0,
                                                ),
                                                Image.asset(
                                                  "assets/images/clock1.png",
                                                  height: 8,
                                                  width: 8,
                                                ),
                                                SizedBox(
                                                  width: 2.0,
                                                ),
                                                Text("${_.arrg['date']}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11.0)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: Image.asset(
                                                    "assets/images/dot.png",
                                                    height: 3,
                                                    width: 3,
                                                  ),
                                                ),
                                                Text("${_.arrg['time']}",
                                                    style: TextStyle(
                                                        color:
                                                            // ignore: deprecated_member_use
                                                            CommonColor
                                                                .orangeColor,
                                                        fontSize: 11.0)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: MaterialButton(
                                                height: 30,
                                                onPressed: () {
                                                  print(_.videoPath);
                                                  Get.to(() => PlayerScreen(),
                                                      arguments: {
                                                        "videoLink":
                                                            _.videoPath,
                                                        "programType": _.event,
                                                        "date": _.arrg['date'],
                                                        "time": _.arrg['time'],
                                                        "transcription": _.arrg[
                                                            'transcription'],
                                                        "translation": _.arrg[
                                                            'translation'],
                                                        "channeLogoPath":
                                                            _.channelLogo,
                                                      });
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                9.0))),
                                                color: Color.fromRGBO(
                                                    72, 190, 235, 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.play_arrow,
                                                      size: 20.0,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      "PLAY",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:5.0),
                              //   child: Divider(color: Colors.white24,thickness: 1.0,),
                              // ),

                              //(height: 10.0,),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 1.7,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0.0)),
                                  color: Color.fromRGBO(27, 29, 40, 1),
                                ),
                                child: Container(
                                  height: 523,
                                  width: 370,
                                  margin: EdgeInsets.only(
                                      top: 19.0,
                                      right: 19.0,
                                      left: 22.0,
                                      bottom: 17.0),
                                  color: Color(
                                    0xFF2D2F3A,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            "Media Information",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 31.0,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 31.0),
                                                child: Text(
                                                  "Event:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 60.0,
                                            ),
                                            Text(
                                              "${_.event}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 31.0),
                                              child: Text(
                                                "Topic:",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 61.0,
                                            ),
                                            _.topic.toString().length == 2
                                                ? Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    "${_.topic}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 31.0),
                                              child: Text(
                                                "Sub-Topic:",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 28.0,
                                            ),
                                            _.subTopic.length == 0
                                                ? Text("")
                                                : showSubTopic(_.subTopic)
                                            // Container(
                                            //         width: Get.width / 2,
                                            //         height: 50.0,
                                            //         child: ListView.separated(
                                            //           scrollDirection: Axis.horizontal,
                                            //           shrinkWrap: true,
                                            //           itemCount: _.subTopic.length,
                                            //           separatorBuilder: (c ,e ){
                                            //             return Text(',');
                                            //           },
                                            //           itemBuilder: (c , index){
                                            //             return Text(
                                            //               "${_.subTopic[index]}",
                                            //               style: TextStyle(
                                            //                   fontSize: 14, color: Colors.white),
                                            //             );
                                            //           },
                                            //         )
                                            //       ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 31.0),
                                              child: Text(
                                                "Source:",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 48.0,
                                            ),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6.0,
                                                        vertical: 2.0),
                                                child: Text(
                                                  "TV",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10.0),
                                                ),
                                              ),
                                              color: Color(0xFF48BEEB),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 31.0),
                                                child: Text(
                                                  "Anchor:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 44.0,
                                            ),
                                            _.anchor.length == 0
                                                ? Text("")
                                                : showAnchor(_.anchor),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 31.0),
                                                child: Text(
                                                  "Guests:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 44.0,
                                            ),
                                            _.guest.length == 0
                                                ? Text("")
                                                : showGuests(_.guest),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 32.0),
                                                child: Text(
                                                  "Statement:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 27.0,
                                            ),
                                            Container(
                                              height: Get.height / 6.5,
                                              width: Get.width / 2.2,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Text(
                                                        "${_.statment}",
                                                        //     maxLines: 2,
                                                        // overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              });
      },
    );
  }

  Widget noInternetConnection() {
    return Center(
      child: Container(
        width: Get.width / 3,
        height: Get.height / 1.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/wifi.png',
            ),
          ),
        ),
      ),
    );
  }

  Widget showSubTopic(List subtopic) {
    List<Widget> g = [];
    for (var i = 0; i < subtopic.length; i++) {
      g.add(Text(
        '${subtopic[i]} ',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ));
    }
    return Expanded(
      child: Wrap(
        children: g,
      ),
    );
  }

  Widget showAnchor(List anchor) {
    List<Widget> g = [];
    for (var i = 0; i < anchor.length; i++) {
      g.add(Text(
        '${anchor[i]} ',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ));
    }
    return Expanded(
      child: Wrap(
        children: g,
      ),
    );
  }

  Widget showGuests(List guests) {
    List<Widget> g = [];
    for (var i = 0; i < guests.length; i++) {
      g.add(Text(
        '${guests[i]['name']}, ',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ));
    }
    return Expanded(
      child: Wrap(
        children: g,
      ),
    );
  }

  Widget infoContainer() {
    return Container(
      width: 370.0,
      height: 523.0,
      color: Color(0x2D2F3A),
    );
  }

// Widget segmentAnalysisContainer() {
//   return Container(
//     width: 155,
//     height: 220,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       color: Color.fromRGBO(90, 92, 105, 1),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 5.0),
//           Center(
//               child: Text(
//             "Segment Analysis",
//             style: TextStyle(
//                 fontSize: 12.0,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           )),
//           SizedBox(
//             height: 10.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Overall Segment Analysis",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold),
//                 ),
//
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.green[400],
//                       borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 4.0, horizontal: 8.0),
//                     child: Text(
//                       "Positive",
//                       style: TextStyle(color: Colors.white, fontSize: 10.0),
//                     ),
//                   ),
//                 ),
//
//                 //SizedBox(height: 0.0,),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 4.0),
//                   child: Divider(
//                     thickness: 3.0,
//                     color: Color.fromRGBO(45, 47, 58, 1),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 0.0,
//                 ),
//                 Text("Segment Anchor Particulars",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 11.0,
//                         fontWeight: FontWeight.bold)),
//
//                 SizedBox(
//                   height: 7.0,
//                 ),
//                 Text("Hamid Mir",
//                     style: TextStyle(
//                         color: Theme.of(context).cursorColor,
//                         fontSize: 11.0)),
//
//                 SizedBox(
//                   height: 4.0,
//                 ),
//                 Row(
//                   children: [
//                     Text("Sentiments:  ",
//                         style:
//                             TextStyle(color: Colors.white54, fontSize: 11.0)),
//                     Card(
//                       color: Colors.blue[400],
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 3.0, horizontal: 8.0),
//                         child: Text(
//                           "Balanced",
//                           style: TextStyle(
//                             fontSize: 10.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(
//                   height: 1,
//                 ),
//                 RichText(
//                   text: TextSpan(children: <TextSpan>[
//                     TextSpan(
//                         text: "Scale:  ",
//                         style:
//                             TextStyle(fontSize: 11.0, color: Colors.white54)),
//                     TextSpan(
//                       text: "Normal",
//                       style: TextStyle(
//                           fontSize: 11.0,
//                           color: Theme.of(context).cursorColor),
//                     ),
//                   ]),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget programInfoContainer() {
//   return Container(
//     width: 155,
//     height: 220,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       color: Color.fromRGBO(90, 92, 105, 1),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 5.0),
//           Center(
//               child: Text(
//             "Program Info",
//             style: TextStyle(
//                 fontSize: 12.0,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           )),
//           SizedBox(
//             height: 15.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: "Clipped By:  ",
//                           style: TextStyle(
//                               color: Colors.white60, fontSize: 11.0)),
//                       TextSpan(
//                           text: "Sheikh Ali",
//                           style: TextStyle(
//                               color: Theme.of(context).cursorColor,
//                               fontSize: 11.0)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: "QC By:  ",
//                           style: TextStyle(
//                               color: Colors.white60, fontSize: 11.0)),
//                       TextSpan(
//                           text: "Ahsan Khan",
//                           style: TextStyle(
//                               color: Colors.blue[300], fontSize: 11.0)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: "Marked By:  ",
//                           style: TextStyle(
//                               color: Colors.white60, fontSize: 11.0)),
//                       TextSpan(
//                           text: "Ghyas Salim",
//                           style:
//                               TextStyle(color: Colors.green, fontSize: 11.0)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: "Main Theme:  ",
//                           style: TextStyle(
//                               color: Colors.white60, fontSize: 11.0)),
//                       TextSpan(
//                           text: "1. Economy",
//                           style: TextStyle(
//                               color: Theme.of(context).cursorColor,
//                               fontSize: 11.0)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: "Sub Theme(s):  ",
//                           style: TextStyle(
//                               color: Colors.white60, fontSize: 11.0)),
//                       TextSpan(
//                           text: "1. Budget",
//                           style: TextStyle(
//                               color: Theme.of(context).cursorColor,
//                               fontSize: 11.0)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
