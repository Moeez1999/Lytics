
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Controllers/home_controller.dart';

// import 'package:lytics_lens/Views/Components/SearchBarTextField.dart';
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/views/player_Screen.dart';
import 'package:lytics_lens/widget/common_container.dart';
import 'package:lytics_lens/widget/taptoLoad.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../widget/internetconnectivity_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (_) {
        return DefaultTabController(
          length: 3,
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
                      text: "My Library",
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
              children: [bodyData(context, _),Text("Hello"),bodyData1(context, _)],
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
                        onRefresh: () async {
                          await _.getSharedJobs();
                          await _.getReceiveJob();
                        },
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
                                      if(_.getReceivedPerson(_.job[index]['sharing']) == '')
                                        {
                                          _.getSingleJob(
                                              _.job[index]['id']);
                                        }
                                      else
                                        {
                                          _.getDeleteJob(
                                              _.sharedJobs[index]['sharing'],
                                              _.sharedJobs[index]['id']);
                                        }
                                      //<------------ Shared  JOB ---------->

                                      // _.job.removeAt(index);
                                      // _.update();
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
                                      isShare: _.searchjob
                                          .length ==
                                          0
                                          ? _.getReceivedPerson(_.job[index]['sharing']) == ''
                                          ? false
                                          : true
                                          : _.getReceivedPerson(_.searchjob[index]
                                      ['sharing']) == ''
                                          ? false
                                          : true,
                                      receiverName: _
                                          .searchjob
                                          .length ==
                                          0
                                          ? _.getReceivedPerson(_.job[index]
                                      ['sharing'])
                                          : _.getReceivedPerson(_.searchjob[index]
                                      ['sharing']),
                                      id: _.id,
                                      isClipped: _.searchjob.length == 0
                                          ? _.job[index]['share'] != null ? true : false
                                          : _.searchjob[index]['share'] != null ? true : false,
                                      isAudio: _.searchjob.length == 0
                                          ?
                                      _.job[index]['audio'] == null
                                          ? false
                                          : true :
                                      _.searchjob[index]['audio'] == null
                                          ? false
                                          : true,
                                      isRead: _.searchjob
                                          .length ==
                                          0
                                          ? _.escalationsJob(_.job[index]
                                      [
                                      'escalations'])
                                          .toString() ==
                                          'false'
                                          ? false
                                          : true
                                          : _.escalationsJob(_.searchjob[index]
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
                                          ? _
                                          .job[index]['thumbnailPath']
                                          : _.job[index]['thumbnailPath']
                                          : _.storage.hasData(
                                          "Url")
                                          ? "${_.storage.read("Url")
                                          .toString()}/uploads/${_
                                          .searchjob[index]['thumbnailPath']}"
                                          : "${ApiData.thumbnailPath +
                                          _.searchjob[index]['thumbnailPath']}",
                                      title: _.searchjob
                                          .length ==
                                          0
                                          ? _.job[index]
                                      ['programName']
                                          : _.searchjob[index]
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
                                          : "${_.storage.read("Url")
                                          .toString()}/uploads//${_
                                          .job[index]['channelLogoPath']}"
                                          : _.job[index][
                                      'channelLogoPath']
                                          .toString()
                                          .contains(
                                          'http')
                                          ? _.job[index]
                                      ['channelLogoPath']
                                          : "${ApiData.channelLogoPath +
                                          _.job[index]['channelLogoPath']}"
                                          : _.storage.hasData("Url")
                                          ? _
                                          .searchjob[index]['channelLogoPath']
                                          .toString()
                                          .contains('http')
                                          ? _
                                          .searchjob[index]['channelLogoPath']
                                          : "${_.storage.read("Url")
                                          .toString()}/uploads//${_
                                          .searchjob[index]['channelLogoPath']}"
                                          : _
                                          .searchjob[index]['channelLogoPath']
                                          .toString()
                                          .contains('http')
                                          ? _
                                          .searchjob[index]['channelLogoPath']
                                          : "${ApiData.channelLogoPath + _
                                          .searchjob[index]['channelLogoPath']}",
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
      color: Color(0xff000425),
      child: Obx(
            () {
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
            onPressed: () {
              _.getSharedJobs();
            },
          )
              : _.isDataFailed.value
              ? TapToLoad(onPressed: () {
            _.getSharedJobs();
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
                        onRefresh: () => _.getReceiveJob(),
                        child:
                        _.sharedJobs.length == 0 ? Center(
                          child: Text("No Job Shared", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              letterSpacing: 1.0

                          ),),
                        ) :
                        ListView.separated(
                            shrinkWrap: true,
                            itemCount: _.searchjob.length == 0
                                ? _.sharedJobs.length
                                : _.searchjob.length,
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
                                          "id": _.searchjob.length == 0
                                              ? _.sharedJobs[index]['id']
                                              : _.searchjob[index]['id'],
                                        },
                                      );
                                    },
                                    isRead: _.searchjob
                                        .length ==
                                        0
                                        ? _
                                        .escalationsJob(
                                        _.sharedJobs[index]
                                        [
                                        'escalations'])
                                        .toString() ==
                                        'false'
                                        ? false
                                        : true
                                        : _
                                        .escalationsJob(
                                        _.searchjob[index]
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
                                        ? "${_.storage.read("Url")
                                        .toString()}/uploads/${_
                                        .sharedJobs[index]['thumbnailPath']}"
                                        : "${ApiData.thumbnailPath +
                                        _.sharedJobs[index]['thumbnailPath']}"
                                        : _.storage.hasData(
                                        "Url")
                                        ? "${_.storage.read("Url")
                                        .toString()}/uploads/${_
                                        .searchjob[index]['thumbnailPath']}"
                                        : "${ApiData.thumbnailPath +
                                        _.searchjob[index]['thumbnailPath']}",
                                    isShare: _.searchjob
                                        .length ==
                                        0
                                        ? _.getSharePerson(_.job[index]
                                    ['sharing']) == ''
                                        ? false
                                        : true
                                        : _.getSharePerson(_.searchjob[index]
                                    ['sharing']) == ''
                                        ? false
                                        : true,
                                    receiverName: _
                                        .searchjob
                                        .length ==
                                        0
                                        ? _.getSharePerson(_.job[index]
                                    ['sharing'])
                                        : _.getSharePerson(_.searchjob[index]
                                    ['sharing']),
                                    title: _.searchjob
                                        .length ==
                                        0
                                        ? _.sharedJobs[index]
                                    ['programName']
                                        : _.searchjob[index]
                                    ['programName'],
                                    anchor: _.searchjob
                                        .length ==
                                        0
                                        ? _.sharedJobs[index]
                                    ['anchor']
                                        : _.searchjob[index]
                                    ['anchor'],
                                    segments: _.searchjob
                                        .length ==
                                        0
                                        ? _.getTopicString(
                                        _.sharedJobs[
                                        index]
                                        ['segments'])
                                        : _.getTopicString(
                                        _.searchjob[index]
                                        ['segments']),
                                    isClipped: _.sharedJobs[index]['share'] != null ? true : false,
                                    isAudio: _.sharedJobs[index]['audio'] == null
                                        ? false
                                        : true,
                                    guests: _.searchjob
                                        .length ==
                                        0
                                        ? _.getGuestsString(_
                                        .sharedJobs[
                                    index]['guests'])
                                        : _.getGuestsString(
                                        _.searchjob[index]
                                        ['guests']),
                                    source: _.searchjob
                                        .length ==
                                        0
                                        ? _.sharedJobs[index]
                                    ['source']
                                        : _.searchjob[index]
                                    ['source'],
                                    channelName: _.searchjob
                                        .length ==
                                        0
                                        ? _.sharedJobs[index]
                                    ['channel']
                                        : _.searchjob[index]
                                    ['channel'],
                                    channelLogo: _.searchjob
                                        .length ==
                                        0
                                        ? _.storage.hasData(
                                        "Url")
                                        ? _
                                        .sharedJobs[index]['channelLogoPath']
                                        .toString()
                                        .contains(
                                        'http')
                                        ? _.sharedJobs[index][
                                    'channelLogoPath']
                                        : "${_.storage.read("Url")
                                        .toString()}/uploads//${_
                                        .sharedJobs[index]['channelLogoPath']}"
                                        : _.sharedJobs[index]
                                    [
                                    'channelLogoPath']
                                        .toString()
                                        .contains(
                                        'http')
                                        ? _.sharedJobs[index]
                                    ['channelLogoPath']
                                        : "${ApiData.channelLogoPath + _
                                        .sharedJobs[index]['channelLogoPath']}"
                                        : _.storage.hasData("Url")
                                        ? _
                                        .searchjob[index]['channelLogoPath']
                                        .toString()
                                        .contains('http')
                                        ? _
                                        .searchjob[index]['channelLogoPath']
                                        : "${_.storage.read("Url")
                                        .toString()}/uploads//${_
                                        .searchjob[index]['channelLogoPath']}"
                                        : _
                                        .searchjob[index]['channelLogoPath']
                                        .toString()
                                        .contains('http')
                                        ? _
                                        .searchjob[index]['channelLogoPath']
                                        : "${ApiData.channelLogoPath + _
                                        .searchjob[index]['channelLogoPath']}",
                                    date: _.searchjob
                                        .length ==
                                        0
                                        ? _.convertDateUtc(_
                                        .sharedJobs[index]
                                    [
                                    'programDate']
                                        .toString())
                                        : _.convertDateUtc(_
                                        .searchjob[index][
                                    'programDate']
                                        .toString()),
                                    time: _.searchjob
                                        .length ==
                                        0
                                        ? _.convertTime(
                                        _.sharedJobs[
                                        index][
                                        'programTime'])
                                        : _.convertTime(_
                                        .searchjob[
                                    index]
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
      ),
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

  Widget showTabs() {
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Widget'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),

          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor: Color(0xff0F162E),
              contentPadding:
              EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 12),
              title: Column(
                children: [
                  Text(
                    "The Following Tabs Represent The Source Of Information",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 9),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/images/onboarding1.png"),
                ],
              ),
              content: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text("hi")),
            ));
  }

  // Widget showArchivedJobs(BuildContext context){
  //   return
  //
  // }
}
