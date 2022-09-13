import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lottie/lottie.dart';

class CommonContainer extends StatelessWidget {
  final Function() onPressed;
  final double height;
  // final double? width;
  final String? imgUrl;
  final String? id;
  final String? title;
  final List? anchor;
  final String? segments;
  final String? guests;
  final String? source;
  final String? channelName;
  final String? channelLogo;
  final String? date;
  final String? time;
  final String? receiverName;
  final bool isProgress;
  final bool isRead;
  final bool isShare;
  final bool isSend;
  final bool isReceived;
  final int progressValue;
  final bool isAudio;
  final bool isClipped;

  const CommonContainer({
    Key? key,
    required this.onPressed,
    this.height = 120,
    // this.width,
    this.imgUrl,
    this.id,
    this.title,
    this.anchor,
    this.segments,
    this.guests,
    this.source,
    this.channelName,
    this.channelLogo,
    this.date,
    this.time,
    this.receiverName,
    this.isShare = false,
    this.isSend = false,
    this.isProgress = false,
    this.isRead = true,
    this.isClipped = false,
    this.isReceived = false,
    this.isAudio = false,
    this.progressValue = 1,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        // color: Color(0xff0A0D29),
        decoration: BoxDecoration(
          color: isRead ? Color(0xff0A0D29) : Color(0xff131C3A),
        ),
        // decoration: BoxDecoration(
        //   color: isRead ? Color(0xFF363842) : Color(0xff575968),
        // ),
        child: Row(
          children: [
            // First Column Start here
            SizedBox(
              width: 100,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: MediaQuery.of(context).size.height,
                    //color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl!,
                        placeholder: (c, e) => Lottie.asset(
                            "assets/images/circular_loader_image.json",
                            fit: BoxFit.cover),
                        errorWidget: (c, e, r) => Lottie.asset(
                            "assets/images/circular_loader_image.json",
                            fit: BoxFit.cover),
                        fit: BoxFit.cover,
                      ),
                    ).marginOnly(left: 7.0, top: 7, bottom: 7, right: 9),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isAudio
                      ? Container(
                        height: 20,
                        width: 25,
                        color: Colors.white,
                        child: Center(
                          child: Icon(Icons.mic , size: 15,color: Colors.green,),
                        ),
                      ) : SizedBox(),
                      isClipped ?Container(
                        height: 20,
                        width: 25,
                        color: Colors.green,
                        child: Center(
                          child: Icon(Icons.cut , size: 15,color: Colors.white,),
                        ),
                      ): SizedBox(),
                    ],
                  ).marginOnly(top: 7, right: 9),
                ],
              ),
            ),
            // Second Column Start here
            Container(
              width: Get.width / 2.8,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(
                            text: '$title ',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.4,
                              fontSize: 12.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: Get.width / 2.8,
                        child: Text(
                          "$segments",
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            letterSpacing: 0.4,
                            color: source!.toLowerCase() == 'online'
                                ? Color(0xff76d14b)
                                : source!.toLowerCase() == 'tv'
                                    ? Color(0xff00ffd9)
                                    : source!.toLowerCase() == 'website' ||
                                            source!.toLowerCase() == 'blog'
                                        ? Color(0xffffd76f)
                                        : source!.toLowerCase() == 'print'
                                            ? Color(0xffB48AE8)
                                            : Color(0xffc28df),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: Get.width / 2.8,
                    child: anchor.toString() == '[]'
                        ? Text(
                            "",
                            textScaleFactor: 1.0,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                letterSpacing: 0.4,
                                color: Color(0xffa3a3a4),
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400),
                          ).marginOnly(bottom: 5.0)
                        : Text(
                            "${anchor![0]}",
                            textScaleFactor: 1.0,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                letterSpacing: 0.4,
                                color: Color(0xffa3a3a4),
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400),
                          ).marginOnly(bottom: 5.0),
                  )
                ],
              ),
            ).marginOnly(left: 0.0),
            Spacer(),
            //Third Column start from here.
            Container(
              height: MediaQuery.of(context).size.height,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 2.0,
                    ),
                    isShare
                    ?
                    Row(
                      children: [
                        isSend
                        ?
                        Image.asset(
                          'assets/images/receive.png',
                          width: 15.0,
                        ) :
                        Image.asset(
                          'assets/images/video-share.png',
                          width: 15.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        SizedBox(
                          width:receiverName == '' ? 0 : Get.width / 10,
                          child: Text(
                            '$receiverName',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: CommonColor.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          height: 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                            border: Border.all(
                              color: source!.toLowerCase() == 'online'
                                  ? Color(0xff76d14b)
                                  : source!.toLowerCase() == 'tv'
                                      ? Color(0xff00ffd9)
                                      : source!.toLowerCase() == 'website' ||
                                              source!.toLowerCase() == 'blog'
                                          ? Color(0xffffd76f)
                                          : source!.toLowerCase() == 'print'
                                              ? Color(0xffB48AE8)
                                              : Color(0xffc28df),
                            ),
                            // colors[widget.index],
                          ),
                          child: Center(
                            child: Text(
                              source!.toLowerCase() == 'online'
                                  ? "${source!} Video"
                                  : source!.toLowerCase() == 'website' ||
                                          source!.toLowerCase() == 'blog'
                                      ? "Web"
                                      : "${source!.toUpperCase()}",
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                letterSpacing: 0.4,
                                color: source!.toLowerCase() == 'online'
                                    ? Color(0xff76d14b)
                                    : source!.toLowerCase() == 'tv'
                                        ? Color(0xff00ffd9)
                                        : source!.toLowerCase() == 'website' ||
                                                source!.toLowerCase() == 'blog'
                                            ? Color(0xffffd76f)
                                            : source!.toLowerCase() == 'print'
                                                ? Color(0xffB48AE8)
                                                : Color(0xffc28df),
                                fontSize: 9.0,
                              ),
                            ).marginOnly(left: 5.0, right: 5.0),
                          ),
                        ),
                      ],
                    ) :
                    Container(
                      height: 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                        border: Border.all(
                          color: source!.toLowerCase() == 'online'
                              ? Color(0xff76d14b)
                              : source!.toLowerCase() == 'tv'
                              ? Color(0xff00ffd9)
                              : source!.toLowerCase() == 'website' ||
                              source!.toLowerCase() == 'blog'
                              ? Color(0xffffd76f)
                              : source!.toLowerCase() == 'print'
                              ? Color(0xffB48AE8)
                              : Color(0xffc28df),
                        ),
                        // colors[widget.index],
                      ),
                      child: Center(
                        child: Text(
                          source!.toLowerCase() == 'online'
                              ? "${source!} Video"
                              : source!.toLowerCase() == 'website' ||
                              source!.toLowerCase() == 'blog'
                              ? "Web"
                              : "${source!.toUpperCase()}",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            letterSpacing: 0.4,
                            color: source!.toLowerCase() == 'online'
                                ? Color(0xff76d14b)
                                : source!.toLowerCase() == 'tv'
                                ? Color(0xff00ffd9)
                                : source!.toLowerCase() == 'website' ||
                                source!.toLowerCase() == 'blog'
                                ? Color(0xffffd76f)
                                : source!.toLowerCase() == 'print'
                                ? Color(0xffB48AE8)
                                : Color(0xffc28df),
                            fontSize: 9.0,
                          ),
                        ).marginOnly(left: 5.0, right: 5.0),
                      ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "$channelName",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.0,
                                  letterSpacing: 0.4,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        // CachedNetworkImage(
                        //   imageUrl: channelLogo!,
                        //   placeholder: (c, e) => Lottie.asset(
                        //       "assets/images/imgload.json",
                        //       fit: BoxFit.cover),
                        //   errorWidget: (c, e, r) => Lottie.asset(
                        //       "assets/images/imgload.json",
                        //       fit: BoxFit.cover),
                        //   width: 15,
                        //   height: 15,
                        //   fit: BoxFit.cover,
                        // ),
                      ],
                    ),
                    Spacer(),
                    //  <================ Progressbar code Comment ==============>
                    // isProgress
                    //     ?
                    //     SizedBox()
                    // Container(
                    //     height: 20.0,
                    //     width: 45,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //       gradient: LinearGradient(
                    //         // stops: [0.0, 1.0],
                    //         // tileMode: TileMode.clamp,
                    //         colors: [ Color(0xff22b161),Color(0xff88a5ff)],
                    //         begin: Alignment.bottomLeft,
                    //         end: Alignment.centerRight
                    //         //stops: [0.8, 0.4],
                    //         // begin: Alignment.topLeft,
                    //         // end: Alignment.bottomRight
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.arrow_drop_up,
                    //           size: 18.0,
                    //           color: Color(0xffffffff),
                    //         ),
                    //         Text(
                    //           '${progressValue.toString()}%',
                    //           style: TextStyle(
                    //               fontFamily: 'Roboto',
                    //               color: Colors.white,
                    //               fontSize: 9.0,
                    //               letterSpacing: 0.4,
                    //               fontWeight: FontWeight.w500),
                    //         )
                    //       ],
                    //     ),
                    //   ).marginOnly(right: 5.0)

                    // : source!.toLowerCase() == 'website'
                    //     ? Container(
                    //         height: 20.0,
                    //         width: Get.width / 5,
                    //         color: Colors.transparent,
                    //       )
                    //     : Container(
                    //         height: 20.0,
                    //         width: Get.width / 5,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20.0),
                    //           color: source!.toLowerCase() == 'online'
                    //               ? Color(0xff76d14b)
                    //               : source!.toLowerCase() == 'tv'
                    //                   ? Color(0xff00ffd9)
                    //                   : Color(0xffc28df),
                    //         ),
                    //         child: Center(
                    //           child: RichText(
                    //             text: TextSpan(
                    //               text: source == 'online' ? '1M' : '3.2 ',
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 10.0,
                    //                 fontFamily: 'Roboto',
                    //                 color: Colors.black,
                    //               ),
                    //               children: <TextSpan>[
                    //                 TextSpan(
                    //                   text: source == 'online'
                    //                       ? 'Views'
                    //                       : 'Rating',
                    //                   style: TextStyle(
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: 10.0,
                    //                     fontFamily: 'Roboto',
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ).marginOnly(right: 5.0),

                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 10.0,
                          color: Colors.white,
                        ).marginOnly(bottom: 7),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          "$date",
                          textScaleFactor: 1.0,
                          // showDate[widget.index],
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.4,
                              fontFamily: 'Roboto',
                              fontSize: 9),
                        ).marginOnly(bottom: 5),
                        Container(
                          height: 3.0,
                          width: 3.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ).marginOnly(bottom: 5, left: 4, right: 4),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "$time",
                            textScaleFactor: 1.0,
                            // showTime[widget.index],
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.4,
                              fontSize: 9.0,
                            ),
                          ).marginOnly(bottom: 5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }



}
