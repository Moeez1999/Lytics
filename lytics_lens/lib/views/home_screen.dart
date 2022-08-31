import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/home_controller.dart';

// import 'package:lytics_lens/Views/Components/SearchBarTextField.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/views/player_Screen.dart';
import 'package:lytics_lens/widget/common_container.dart';
import 'package:lytics_lens/widget/taptoLoad.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../Controllers/playerController.dart';
import '../widget/internetconnectivity_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (_) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            // backgroundColor: Color(0xFF2D2F3A),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                bottom: TabBar(
                  isScrollable: false,
                  physics: NeverScrollableScrollPhysics(),
                  indicatorColor: Color(0xff22B161),
                  tabs: [
                    Tab(
                      text: "Alerts",
                    ),
                    Tab(
                      text: "Shared",
                    ),
                  ],
                ),
                elevation: 0.0,
                backgroundColor: Color(0xff000425),
                titleSpacing: 0.0,
              ),
            ),
            // bottomNavigationBar: GlobalBottomNav(),
            // drawer: Drawer(),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [bodyData(context, _), bodyData1(context, _)],
            ),
          ),
        );
      },
    );
  }

  Widget bodyData(context, HomeScreenController _) {
    return Container(
        height: Get.height,
        width: Get.width,
        color: Color(0xff000425),
        // decoration: BoxDecoration(
        //   gradient: RadialGradient(
        //     colors: [
        //       Color(0xff1b1d28).withOpacity(.95),
        //       Color(0xff1b1d28),
        //     ],
        //   ),
        // ),
        child: Obx(() {
          return _.isLoading.value
              ? Center(
                  child: Image.asset(
                    "assets/images/gif.gif",
                    height: 300.0,
                    width: 300.0,
                  ),
                ).marginOnly(bottom: 50.0)
              : _.isSocketError.value
                  ? InterConnectivity(
                      onPressed: () async {
                        await _.getJobs(1);
                        await _.getReceiveJob();
                      },
                    )
                  : _.isDataFailed.value
                      ? TapToLoad(onPressed: () {
                          _.getJobs(1);
                        })
                      : _.isSearchData.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   height: 20.0,
                                // ),
                                Container(
                                  width: Get.width / 4.0,
                                  height: Get.height / 4.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/searchjob.png",
                                        ),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                Text(
                                  'No Result Found',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.4,
                                      color: Colors.white),
                                )
                              ],
                            )
                          : DefaultTabController(
                              length: 5,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      },
                                      onVerticalDragCancel: () {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      },
                                      child: RefreshIndicator(
                                          onRefresh: () => _.getJobs(1),
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: _.searchjob.length == 0
                                                  ? _.job.length
                                                  : _.searchjob.length,
                                              separatorBuilder: (c, e) {
                                                return SizedBox(
                                                  height: 5.0,
                                                );
                                              },
                                              itemBuilder: (ctx, index) {
                                                // print('Job Index ${index + 1}');
                                                // print('Created At Date ${_.job[index]['programDate']}');
                                                // print('UTC Date ${_.convertDateUtc(_.job[index]['programDate'])}');
                                                print(
                                                    'Job Index ${_.tpageno.value}');
                                                if (_.job.length != 0) {
                                                  if (_.job.length ==
                                                      index + 1) {
                                                    _.tpageno.value =
                                                        _.tpageno.value + 1;
                                                    _.getJobs(_.tpageno.value);
                                                  } else {
                                                    _.isMore.value = false;
                                                  }
                                                } else if (_.searchjob.length !=
                                                    0) {
                                                  if (_.searchjob.length ==
                                                      index + 1) {
                                                    _.tpageno.value =
                                                        _.tpageno.value + 1;
                                                    _.getJobs(_.tpageno.value);
                                                  } else {
                                                    print(
                                                        'Search More is Work now');
                                                    _.isMore.value = false;
                                                  }
                                                }
                                                return SwipeActionCell(
                                                  key: ObjectKey(_.job[index]),
                                                  trailingActions: <
                                                      SwipeAction>[
                                                    SwipeAction(
                                                      title: "Delete",
                                                      onTap: (CompletionHandler
                                                          handler) async {
                                                        _.getSingleJob(
                                                            _.job[index]['id']);
                                                      },
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                  child: Column(
                                                    children: [
                                                      CommonContainer(
                                                        onPressed: () {
                                                          _.isMore.value =
                                                              false;
                                                          if (_.searchjob
                                                                  .length ==
                                                              0) {
                                                            if (_
                                                                    .escalationsJob(
                                                                        _.job[index]
                                                                            [
                                                                            'escalations'])
                                                                    .toString() ==
                                                                'false') {
                                                              _.jobStatus(
                                                                _.job[index]
                                                                    ['id'],
                                                              );
                                                            } else {
                                                              Get.delete<
                                                                  VideoController>();
                                                              Get.to(
                                                                () =>
                                                                    PlayerScreen(),
                                                                arguments: {
                                                                  "id": _.searchjob
                                                                              .length ==
                                                                          0
                                                                      ? _.job[index]
                                                                          ['id']
                                                                      : _.searchjob[
                                                                              index]
                                                                          [
                                                                          'id'],
                                                                },
                                                              );
                                                            }
                                                          } else {
                                                            if (_
                                                                    .escalationsJob(
                                                                        _.searchjob[index]
                                                                            [
                                                                            'escalations'])
                                                                    .toString() ==
                                                                'false') {
                                                              _.jobStatus(
                                                                _.searchjob[
                                                                        index]
                                                                    ['id'],
                                                              );
                                                            } else {
                                                              Get.delete<
                                                                  VideoController>();
                                                              Get.to(
                                                                () =>
                                                                    PlayerScreen(),
                                                                arguments: {
                                                                  "id": _.searchjob
                                                                              .length ==
                                                                          0
                                                                      ? _.job[index]
                                                                          ['id']
                                                                      : _.searchjob[
                                                                              index]
                                                                          [
                                                                          'id'],
                                                                },
                                                              );
                                                            }
                                                          }
                                                        },
                                                        id: _.id,
                                                        isClipped: false,
                                                        isAudio: false,
                                                        isRead: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _
                                                                        .escalationsJob(_.job[index]
                                                                            [
                                                                            'escalations'])
                                                                        .toString() ==
                                                                    'false'
                                                                ? false
                                                                : true
                                                            : _
                                                                        .escalationsJob(_.searchjob[index]
                                                                            [
                                                                            'escalations'])
                                                                        .toString() ==
                                                                    'false'
                                                                ? false
                                                                : true,
                                                        imgUrl: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.storage.hasData(
                                                                    "Url")
                                                                ? "${_.storage.read("Url").toString()}/uploads/${_.job[index]['thumbnailPath']}"
                                                                : "${ApiData.thumbnailPath + _.job[index]['thumbnailPath']}"
                                                            : _.storage.hasData(
                                                                    "Url")
                                                                ? "${_.storage.read("Url").toString()}/uploads/${_.searchjob[index]['thumbnailPath']}"
                                                                : "${ApiData.thumbnailPath + _.searchjob[index]['thumbnailPath']}",
                                                        title: _.job[index]
                                                            ['programName'],
                                                        anchor: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.job[index]
                                                                ['anchor']
                                                            : _.searchjob[index]
                                                                ['anchor'],
                                                        segments: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.getTopicString(_
                                                                    .job[index]
                                                                ['segments'])
                                                            : _.getTopicString(
                                                                _.searchjob[
                                                                        index][
                                                                    'segments']),
                                                        guests: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.getGuestsString(
                                                                _.job[index]
                                                                    ['guests'])
                                                            : _.getGuestsString(
                                                                _.searchjob[
                                                                        index]
                                                                    ['guests']),
                                                        source: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.job[index]
                                                                ['source']
                                                            : _.searchjob[index]
                                                                ['source'],
                                                        channelName: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.job[index]
                                                                ['channel']
                                                            : _.searchjob[index]
                                                                ['channel'],
                                                        channelLogo: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.storage.hasData(
                                                                    "Url")
                                                                ? _.job[index]['channelLogoPath']
                                                                        .toString()
                                                                        .contains(
                                                                            'http')
                                                                    ? _.job[index]
                                                                        [
                                                                        'channelLogoPath']
                                                                    : "${_.storage.read("Url").toString()}/uploads//${_.job[index]['channelLogoPath']}"
                                                                : _.job[index][
                                                                            'channelLogoPath']
                                                                        .toString()
                                                                        .contains(
                                                                            'http')
                                                                    ? _.job[index]
                                                                        ['channelLogoPath']
                                                                    : "${ApiData.channelLogoPath + _.job[index]['channelLogoPath']}"
                                                            : _.storage.hasData("Url")
                                                                ? _.searchjob[index]['channelLogoPath'].toString().contains('http')
                                                                    ? _.searchjob[index]['channelLogoPath']
                                                                    : "${_.storage.read("Url").toString()}/uploads//${_.searchjob[index]['channelLogoPath']}"
                                                                : _.searchjob[index]['channelLogoPath'].toString().contains('http')
                                                                    ? _.searchjob[index]['channelLogoPath']
                                                                    : "${ApiData.channelLogoPath + _.searchjob[index]['channelLogoPath']}",
                                                        date: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.convertDateUtc(_
                                                                .job[index][
                                                                    'programDate']
                                                                .toString())
                                                            : _.convertDateUtc(_
                                                                .searchjob[
                                                                    index][
                                                                    'programDate']
                                                                .toString()),
                                                        time: _.searchjob
                                                                    .length ==
                                                                0
                                                            ? _.convertTime(_
                                                                    .job[index]
                                                                ['programTime'])
                                                            : _.convertTime(_
                                                                        .searchjob[
                                                                    index][
                                                                'programTime']),
                                                      ),
                                                      _.isMore.value
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator()
                                                                      .marginOnly(
                                                                top: 10.0,
                                                                bottom: 10.0,
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                );
                                              })),
                                    ),
                                  )
                                ],
                              ),
                            );
        }));
  }

  Widget bodyData1(context, HomeScreenController _) {
    return Container(
      height: Get.height,
      width: Get.width,
      // color: Color(0xff000425),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xff000425),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              bottom: TabBar(
                isScrollable: false,
                physics: NeverScrollableScrollPhysics(),
                indicatorColor: Colors.transparent,
                labelColor: CommonColor.greenBorderColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "Received",
                  ),
                  Tab(
                    text: "Sent",
                  ),
                ],
              ),
              elevation: 0.0,
              backgroundColor: Color(0xff000425),
              titleSpacing: 0.0,
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [receivedList(_), sentList(_)],
          ),
        ),
      ),
    );
  }

  Widget sentList(HomeScreenController _) {
    return Obx(
      () {
        return _.isSendLoading.value
            ? Center(
                child: Image.asset(
                  "assets/images/gif.gif",
                  height: 300.0,
                  width: 300.0,
                ),
              ).marginOnly(bottom: 50.0)
            : _.isSocketError.value
                ? InterConnectivity(
                    onPressed: () {
                      _.getSentJobs();
                    },
                  )
                : _.isDataFailed.value
                    ? TapToLoad(onPressed: () {
                        _.getSentJobs();
                      })
                    : DefaultTabController(
                        length: 5,
                        child: Column(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: RefreshIndicator(
                                    onRefresh: () => _.getSentJobs(),
                                    child: _.sentjob.length == 0
                                        ? Center(
                                            child: Text(
                                              "No Job Shared",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  letterSpacing: 1.0),
                                            ),
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: _.sentjob.length,
                                            separatorBuilder: (c, e) {
                                              return SizedBox(
                                                height: 5.0,
                                              );
                                            },
                                            itemBuilder: (ctx, index) {
                                              return Column(
                                                children: [
                                                  CommonContainer(
                                                    onPressed: () {
                                                      Get.to(
                                                        () => PlayerScreen(),
                                                        arguments: {
                                                          "id": _.sentjob[index]
                                                              ['id'],
                                                        },
                                                      );
                                                    },
                                                    isRead: _
                                                                .escalationsJob(_
                                                                            .sentjob[
                                                                        index][
                                                                    'escalations'])
                                                                .toString() ==
                                                            'false'
                                                        ? false
                                                        : true,
                                                    imgUrl: _.storage
                                                            .hasData("Url")
                                                        ? "${_.storage.read("Url").toString()}/uploads/${_.sentjob[index]['thumbnailPath']}"
                                                        : "${ApiData.thumbnailPath + _.sentjob[index]['thumbnailPath']}",
                                                    isShare: _.getSharePerson(_
                                                                        .sentjob[
                                                                    index]
                                                                ['sharing']) ==
                                                            ''
                                                        ? false
                                                        : true,
                                                    receiverName: "",
                                                    title: _.sentjob[index]
                                                                    ['share'] !=
                                                                null ||
                                                            _.sentjob[index]
                                                                    ['audio'] !=
                                                                null
                                                        ? _.sentjob[index]
                                                            ['title']
                                                        : _.sentjob[index]
                                                            ['programName'],
                                                    anchor: _.sentjob[index]
                                                        ['anchor'],
                                                    segments: _.getTopicString(
                                                        _.sentjob[index]
                                                            ['segments']),
                                                    isClipped: _.sentjob[index]
                                                                ['share'] !=
                                                            null
                                                        ? true
                                                        : false,
                                                    isAudio: _.sentjob[index]
                                                                ['audio'] ==
                                                            null
                                                        ? false
                                                        : true,
                                                    guests: _.getGuestsString(
                                                        _.sentjob[index]
                                                            ['guests']),
                                                    source: _.sentjob[index]
                                                        ['source'],
                                                    channelName:
                                                        _.sentjob[index]
                                                            ['channel'],
                                                    channelLogo: _.storage
                                                            .hasData("Url")
                                                        ? _.sentjob[index][
                                                                    'channelLogoPath']
                                                                .toString()
                                                                .contains(
                                                                    'http')
                                                            ? _.sentjob[index][
                                                                'channelLogoPath']
                                                            : "${_.storage.read("Url").toString()}/uploads//${_.sentjob[index]['channelLogoPath']}"
                                                        : _.sentjob[index][
                                                                    'channelLogoPath']
                                                                .toString()
                                                                .contains(
                                                                    'http')
                                                            ? _.sentjob[index][
                                                                'channelLogoPath']
                                                            : "${ApiData.channelLogoPath + _.sentjob[index]['channelLogoPath']}",
                                                    date: _.convertDateUtc(_
                                                        .sentjob[index]
                                                            ['programDate']
                                                        .toString()),
                                                    time: _.convertTime(
                                                        _.sentjob[index]
                                                            ['programTime']),
                                                  ),
                                                  _.isMore.value
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator()
                                                                  .marginOnly(
                                                            top: 10.0,
                                                            bottom: 10.0,
                                                          ),
                                                        )
                                                      : SizedBox()
                                                ],
                                              );
                                            })),
                              ),
                            )
                          ],
                        ),
                      );
      },
    );
  }

  Widget receivedList(HomeScreenController _) {
    return Obx(
      () {
        return _.isLoading1.value
            ? Center(
                child: Image.asset(
                  "assets/images/gif.gif",
                  height: 300.0,
                  width: 300.0,
                ),
              ).marginOnly(bottom: 50.0)
            : _.isSocketError.value
                ? InterConnectivity(
                    onPressed: () {
                      _.getReceiveJob();
                    },
                  )
                : _.isDataFailed.value
                    ? TapToLoad(onPressed: () {
                        _.getReceiveJob();
                      })
                    : _.isSearchData.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 20.0,
                              // ),
                              Container(
                                width: Get.width / 4.0,
                                height: Get.height / 4.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/searchjob.png",
                                      ),
                                      fit: BoxFit.contain),
                                ),
                              ),

                              Text(
                                'No Result Found',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.4,
                                    color: Colors.white),
                              )
                            ],
                          )
                        : DefaultTabController(
                            length: 5,
                            child: Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: RefreshIndicator(
                                        onRefresh: () => _.getReceiveJob(),
                                        child: _.receivedJobsList.length == 0
                                            ? Center(
                                                child: Text(
                                                  "No Job Received",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      letterSpacing: 1.0),
                                                ),
                                              )
                                            : ListView.separated(
                                                shrinkWrap: true,
                                                itemCount:
                                                    _.receivedJobsList.length,
                                                separatorBuilder: (c, e) {
                                                  return SizedBox(
                                                    height: 5.0,
                                                  );
                                                },
                                                itemBuilder: (ctx, index) {
                                                  return Column(
                                                    children: [
                                                      CommonContainer(
                                                        onPressed: () {
                                                          Get.to(
                                                            () =>
                                                                PlayerScreen(),
                                                            arguments: {
                                                              "id":
                                                                  _.receivedJobsList[
                                                                          index]
                                                                      ['id'],
                                                            },
                                                          );
                                                        },
                                                        isRead: _
                                                                    .escalationsJob(
                                                                        _.receivedJobsList[index]
                                                                            [
                                                                            'escalations'])
                                                                    .toString() ==
                                                                'false'
                                                            ? false
                                                            : true,
                                                        imgUrl: _.storage
                                                                .hasData("Url")
                                                            ? "${_.storage.read("Url").toString()}/uploads/${_.receivedJobsList[index]['thumbnailPath']}"
                                                            : "${ApiData.thumbnailPath + _.receivedJobsList[index]['thumbnailPath']}",
                                                        isShare: _.getSharePerson(
                                                                    _.receivedJobsList[
                                                                            index]
                                                                        [
                                                                        'sharing']) ==
                                                                ''
                                                            ? false
                                                            : true,
                                                        receiverName: _
                                                            .getSharePerson(
                                                                _.receivedJobsList[
                                                                        index][
                                                                    'sharing']),
                                                        title: _.receivedJobsList[
                                                                            index]
                                                                        [
                                                                        'share'] !=
                                                                    null ||
                                                                _.receivedJobsList[
                                                                            index]
                                                                        [
                                                                        'audio'] !=
                                                                    null
                                                            ? _.receivedJobsList[
                                                                index]['title']
                                                            : _.receivedJobsList[
                                                                    index]
                                                                ['programName'],
                                                        anchor:
                                                            _.receivedJobsList[
                                                                    index]
                                                                ['anchor'],
                                                        segments: _.getTopicString(
                                                            _.receivedJobsList[
                                                                    index]
                                                                ['segments']),
                                                        isClipped:
                                                            _.receivedJobsList[
                                                                            index]
                                                                        [
                                                                        'share'] !=
                                                                    null
                                                                ? true
                                                                : false,
                                                        isAudio: _.receivedJobsList[
                                                                        index]
                                                                    ['audio'] ==
                                                                null
                                                            ? false
                                                            : true,
                                                        guests: _.getGuestsString(
                                                            _.receivedJobsList[
                                                                    index]
                                                                ['guests']),
                                                        source:
                                                            _.receivedJobsList[
                                                                    index]
                                                                ['source'],
                                                        channelName:
                                                            _.receivedJobsList[
                                                                    index]
                                                                ['channel'],
                                                        channelLogo: _.storage
                                                                .hasData("Url")
                                                            ? _.receivedJobsList[index]
                                                                        [
                                                                        'channelLogoPath']
                                                                    .toString()
                                                                    .contains(
                                                                        'http')
                                                                ? _.receivedJobsList[index]
                                                                    [
                                                                    'channelLogoPath']
                                                                : "${_.storage.read("Url").toString()}/uploads//${_.receivedJobsList[index]['channelLogoPath']}"
                                                            : _.receivedJobsList[
                                                                        index][
                                                                        'channelLogoPath']
                                                                    .toString()
                                                                    .contains(
                                                                        'http')
                                                                ? _.receivedJobsList[index]
                                                                    ['channelLogoPath']
                                                                : "${ApiData.channelLogoPath + _.receivedJobsList[index]['channelLogoPath']}",
                                                        date: _.convertDateUtc(_
                                                            .receivedJobsList[
                                                                index]
                                                                ['programDate']
                                                            .toString()),
                                                        time: _.convertTime(
                                                            _.receivedJobsList[
                                                                    index][
                                                                'programTime']),
                                                      ),
                                                      _.isMore.value
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator()
                                                                      .marginOnly(
                                                                top: 10.0,
                                                                bottom: 10.0,
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  );
                                                })),
                                  ),
                                )
                              ],
                            ),
                          );
      },
    );
  }

  Widget getGuestList(HomeScreenController _, List guestlist) {
    return Container(
      width: Get.width / 2.8,
      height: 17.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: guestlist.length,
        separatorBuilder: (c, v) {
          return SizedBox(
            width: 10.0,
          );
        },
        itemBuilder: (c, i) {
          return Text(
            '${guestlist[i]['name']}',
            style: TextStyle(
                fontSize: 12.0, fontFamily: 'Roboto', color: Colors.white60),
          );
        },
      ),
    );
  }

  Widget showSubTopic(List subtopic) {
    List c = [];
    print('Sub Topic ${subtopic[0]['topics']['topic2']}');
    c.add(subtopic[0]['topics']['topic2']);
    List<Widget> g = [];
    if (c.length == 0) {
      g.add(Text(''));
    } else {
      for (var i = 0; i < 1; i++) {
        g.add(Text(
          '${c[i]} ',
          style: TextStyle(
              fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
        ));
      }
    }
    return Expanded(
      child: Wrap(
        children: g,
      ),
    );
  }
}
