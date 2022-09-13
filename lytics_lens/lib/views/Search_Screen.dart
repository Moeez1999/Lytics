import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lytics_lens/Views/player_Screen.dart';
import 'package:lytics_lens/widget/textFields/searchfield.dart';
import '../Constants/app_strrings.dart';
import '../Constants/common_color.dart';
import '../Controllers/playerController.dart';
import '../Controllers/searchScreen_controller.dart';
import '../Controllers/searchbar_controller.dart';
import '../Models/channel.dart';
import '../widget/common_containers/common_container.dart';
import '../widget/common_containers/trendingkeyword_container.dart';
import '../widget/snackbar/common_snackbar.dart';
import '../widget/internet_connectivity/internetconnectivity_screen.dart';
import '../widget/multiselectDropdown/multi_select_bottom_sheet.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchBarController contrl = Get.find<SearchBarController>();
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (_) {
        print("lenght in view " + _.searchjob.length.toString());
        final mqData = MediaQuery.of(context);
        final mqDataNew = mqData.copyWith(
            textScaleFactor:
                mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

        return Obx(() {
          return MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: CommonColor.appBarColor,
              // drawer: GlobalDrawer(),
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xff000425),
                titleSpacing: 0,
                leading: GestureDetector(
                  onTap: () {
                    contrl.searchText.clear();
                    Get.back();
                  },
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (_.job.length == 0 &&
                          _.searchjob.length == 0 &&
                          _.searchdata.value.text == '') {
                        // CustomSnackBar.showSnackBar(
                        //   title: AppStrings.enterSomeText,
                        //   message: "",
                        //   backgroundColor: CommonColor.snackbarColour,
                        //   isWarning: true,
                        // );
                      } else if (_.isLoading.value != true) {
                        showbottomsheet(context, _);
                      }
                    },
                    icon: Image.asset(
                      "assets/images/filter-green.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
                flexibleSpace: SafeArea(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 55.0, top: 0.0, right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          SearchField(
                            _.searchdata.value,
                            (c) {},
                            _.searchjob.length == 0
                                ? "Searching"
                                : "${_.searchjob.length} Results",
                            (v) async {
                              // _.channellist.forEach((element) {
                              //   element.check.value = false;
                              // });
                              // _.programType.forEach((element) {
                              //   element.check.value = false;
                              // });
                              // _.filterChannelList.clear();
                              // _.filterProgramType.clear();
                              // _.filterlist.clear();
                              // _.filterGuests.clear();
                              // _.filterHost.clear();
                              print('Search Text $v');
                              if (v != '') {
                                await _.getFilterJobs(v, 1);
                              }
                            },
                            () async {
                              if (_.searchdata.value.text != '') {
                                await _.getFilterJobs(
                                    _.searchdata.value.text, 1);
                              }
                            },
                            () {
                              _.searchdata.value.clear();
                            },
                            () async {
                              print(
                                  "searh icon pressed ${_.searchdata.value.text}");
                              if (_.searchdata.value.text != '') {
                                await _.getFilterJobs(
                                    _.searchdata.value.text, 1);
                              }
                            },
                          ).marginOnly(right: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // bottomNavigationBar: GlobalBottomNav(),
              body: _.isSocketError.value
                  ? InterConnectivity(
                      onPressed: () async {
                        _.isLoading.value = true;
                        await _.getFilterJobs(_.searchdata.value.text, 1);
                        _.isLoading.value = false;
                      },
                    )
                  : _.isLoading.value
                      ? Center(
                          child: Image.asset(
                            "assets/images/gif.gif",
                            height: 300.0,
                            width: 300.0,
                          ),
                        )
                      : Container(
                          height: Get.height,
                          width: Get.width,
                          // decoration: BoxDecoration(
                          //   gradient: RadialGradient(
                          //     colors: [
                          //       Color(0xff1b1d28).withOpacity(.95),
                          //       Color(0xff1b1d28),
                          //     ],
                          //   ),
                          // ),
                          color: Color(0xff000425),

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
                            child: _.job.length == 0 && _.searchjob.length == 0
                                ? TrendingKeyword(
                                    controller: _,
                                    title: 'No Matches Found for',
                                    searchText: _.searchdata.value.text,
                                    subTitle:
                                        'Please check your spelling or try different keywords',
                                    heading: 'Trending Topics',
                                  )
                                : Column(
                                    children: [
                                      // SizedBox(
                                      //   height: 6.0,
                                      // ),
                                      // Container(
                                      //   height: 90,
                                      //   width: Get.width,
                                      //   child: ListView.builder(
                                      //     shrinkWrap: true,
                                      //     itemCount: _.headlinelist.length >= 10
                                      //         ? 10
                                      //         : _.headlinelist.length,
                                      //     scrollDirection: Axis.horizontal,
                                      //     itemBuilder: (BuildContext context,
                                      //         int index) {
                                      //       return HeadlineContainer(
                                      //         isHeadline: _.isHeadline.value,
                                      //         colorCode: _.headlinelist[index]
                                      //             ['color'],
                                      //         channelName: _.headlinelist[index]
                                      //             ['channel'],
                                      //         headlinetype:
                                      //             _.headlinelist[index]
                                      //                 ['headlinetype'],
                                      //         title: _.headlinelist[index]
                                      //             ['title'],
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 7.0,
                                      // ),
                                      Expanded(
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
                                            print('Job Index ${index + 1}');
                                            print(
                                                'Job total Index ${_.job.length}');
                                            print(
                                                'Job Index ${_.tpageno.value}');
                                            if (_.job.length != 0) {
                                              if (_.job.length == index + 1) {
                                                _.tpageno.value =
                                                    _.tpageno.value + 1;
                                                _.getFilterJobs(
                                                    _.searchdata.value.text,
                                                    _.tpageno.value);
                                              } else {
                                                _.isMore.value = false;
                                              }
                                            } else if (_.searchjob.length !=
                                                0) {
                                              if (_.searchjob.length ==
                                                  index + 1) {
                                                _.tpageno.value =
                                                    _.tpageno.value + 1;
                                                _.getFilterJobs(
                                                    _.searchdata.value.text,
                                                    _.tpageno.value);
                                              } else {
                                                print(
                                                    'Search More is Work now');
                                                _.isMore.value = false;
                                              }
                                            }
                                            return Column(
                                              children: [
                                                CommonContainer(
                                                  onPressed: () {
                                                    _.isMore.value = false;
                                                    if (_.searchjob.length ==
                                                        0) {
                                                      if (_
                                                              .escalationsJob(_
                                                                          .job[
                                                                      index][
                                                                  'escalations'])
                                                              .toString() ==
                                                          'false') {
                                                        _.jobStatus(
                                                            _.job[index]['id'],
                                                            _.searchjob.length ==
                                                                    0
                                                                ? _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.job[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/' + _.job[index]['thumbnailPath']}"
                                                                : _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.searchjob[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/' + _.searchjob[index]['thumbnailPath']}");
                                                      } else {
                                                        Get.delete<VideoController>();
                                                        Get.to(
                                                          () => PlayerScreen(),
                                                          arguments: {
                                                            "id": _.searchjob
                                                                        .length ==
                                                                    0
                                                                ? _.job[index]
                                                                    ['id']
                                                                : _.searchjob[
                                                                        index]
                                                                    ['id'],
                                                            "image": _.searchjob
                                                                        .length ==
                                                                    0
                                                                ? _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.job[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/' + _.job[index]['thumbnailPath']}"
                                                                : _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.searchjob[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/'+ _.searchjob[index]['thumbnailPath']}",
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      if (_
                                                              .escalationsJob(
                                                                  _.searchjob[
                                                                          index]
                                                                      [
                                                                      'escalations'])
                                                              .toString() ==
                                                          'false') {
                                                        _.jobStatus(
                                                            _.searchjob[index]
                                                                ['id'],
                                                            _.searchjob.length ==
                                                                    0
                                                                ? _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.job[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/' + _.job[index]['thumbnailPath']}"
                                                                : _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.searchjob[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/' + _.searchjob[index]['thumbnailPath']}");
                                                      } else {
                                                        Get.delete<VideoController>();
                                                        Get.to(
                                                          () => PlayerScreen(),
                                                          arguments: {
                                                            "id": _.searchjob
                                                                        .length ==
                                                                    0
                                                                ? _.job[index]
                                                                    ['id']
                                                                : _.searchjob[
                                                                        index]
                                                                    ['id'],
                                                            "image": _.searchjob
                                                                        .length ==
                                                                    0
                                                                ? _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.job[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/' + _.job[index]['thumbnailPath']}"
                                                                : _.storage
                                                                        .hasData(
                                                                            "Url")
                                                                    ? "${_.storage.read("Url").toString()}/uploads/${_.searchjob[index]['thumbnailPath']}"
                                                                    : "${_.baseUrlService.baseUrl + '/uploads/' + _.searchjob[index]['thumbnailPath']}",
                                                          },
                                                        );
                                                      }
                                                    }
                                                  },
                                                  isRead: _.searchjob.length ==
                                                          0
                                                      ? _
                                                                  .escalationsJob(_
                                                                              .job[
                                                                          index]
                                                                      [
                                                                      'escalations'])
                                                                  .toString() ==
                                                              'false'
                                                          ? false
                                                          : true
                                                      : _
                                                                  .escalationsJob(
                                                                      _.searchjob[
                                                                              index]
                                                                          [
                                                                          'escalations'])
                                                                  .toString() ==
                                                              'false'
                                                          ? false
                                                          : true,
                                                  imgUrl: _.searchjob.length ==
                                                          0
                                                      ? _.storage.hasData("Url")
                                                          ? "${_.storage.read("Url").toString()}/uploads/${_.job[index]['thumbnailPath']}"
                                                          : "${_.baseUrlService.baseUrl + '/uploads/' + _.job[index]['thumbnailPath']}"
                                                      : _.storage.hasData("Url")
                                                          ? "${_.storage.read("Url").toString()}/uploads/${_.searchjob[index]['thumbnailPath']}"
                                                          : "${_.baseUrlService.baseUrl + '/uploads/' + _.searchjob[index]['thumbnailPath']}",
                                                  title: _.searchjob.length == 0
                                                      ? _.job[index]
                                                          ['programName']
                                                      : _.searchjob[index]
                                                          ['programName'],
                                                  anchor: _.searchjob.length ==
                                                          0
                                                      ? _.job[index]['anchor']
                                                      : _.searchjob[index]
                                                          ['anchor'],
                                                  segments:
                                                      _.searchjob.length == 0
                                                          ? _.getTopicString(
                                                              _.job[index]
                                                                  ['segments'])
                                                          : _.getTopicString(
                                                              _.searchjob[index]
                                                                  ['segments']),
                                                  guests:
                                                      _.searchjob.length == 0
                                                          ? _.getGuestsString(
                                                              _.job[index]
                                                                  ['guests'])
                                                          : _.getGuestsString(
                                                              _.searchjob[index]
                                                                  ['guests']),
                                                  source: _.searchjob.length ==
                                                          0
                                                      ? _.job[index]['source']
                                                      : _.searchjob[index]
                                                          ['source'],
                                                  channelName:
                                                      _.searchjob.length == 0
                                                          ? _.job[index]
                                                              ['channel']
                                                          : _.searchjob[index]
                                                              ['channel'],
                                                  channelLogo: _.searchjob
                                                              .length ==
                                                          0
                                                      ? _.storage.hasData("Url")
                                                          ? _.job[index]['channelLogoPath']
                                                                  .toString()
                                                                  .contains(
                                                                      'http')
                                                              ? _.job[index][
                                                                  'channelLogoPath']
                                                              : "${_.storage.read("Url").toString()}/uploads//${_.job[index]['channelLogoPath']}"
                                                          : _.job[index]['channelLogoPath']
                                                                  .toString()
                                                                  .contains(
                                                                      'http')
                                                              ? _.job[index][
                                                                  'channelLogoPath']
                                                              : "${_.baseUrlService.baseUrl + '/uploads//' + _.job[index]['channelLogoPath']}"
                                                      : _.storage.hasData("Url")
                                                          ? _.searchjob[index]['channelLogoPath']
                                                                  .toString()
                                                                  .contains(
                                                                      'http')
                                                              ? _.searchjob[index]
                                                                  ['channelLogoPath']
                                                              : "${_.storage.read("Url").toString()}/uploads//${_.searchjob[index]['channelLogoPath']}"
                                                          : _.searchjob[index]['channelLogoPath'].toString().contains('http')
                                                              ? _.searchjob[index]['channelLogoPath']
                                                              : "${_.baseUrlService.baseUrl + '/uploads//' + _.searchjob[index]['channelLogoPath']}",
                                                  date: _.searchjob.length == 0
                                                      ? _.convertDateUtc(
                                                          _.job[index]
                                                              ['programDate'])
                                                      : _.convertDateUtc(
                                                          _.searchjob[index]
                                                              ['programDate']),
                                                  time: _.searchjob.length == 0
                                                      ? _.convertTime(
                                                          _.job[index]
                                                              ['programTime'])
                                                      : _.convertTime(
                                                          _.searchjob[index]
                                                              ['programTime']),
                                                  isProgress: true,
                                                  progressValue:
                                                      _.generateRandomNumber(
                                                          index),
                                                ),
                                                _.isMore.value
                                                    ? Center(
                                                        child:
                                                        Image.asset(
                                                          "assets/images/gif.gif",
                                                          height: 120.0,
                                                          width: 120.0,
                                                        ),

                                                      )
                                                    : SizedBox()
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
            ),
          );
        });
      },
    );
  }

  void showbottomsheet(BuildContext ctx, SearchController _) {
    showModalBottomSheet(
      elevation: 0,
      backgroundColor: CommonColor.bottomSheetBackgroundColour,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: ctx,
      builder: (ctx) => StatefulBuilder(builder: (ctx, setState) {
        final mqData = MediaQuery.of(ctx);
        final mqDataNew = mqData.copyWith(
            textScaleFactor:
                mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

        return MediaQuery(
          data: mqDataNew,
          child: SizedBox(
            width: Get.width,
            height: Get.height / 1.09,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Filters',
                              style: TextStyle(
                                letterSpacing: 0.4,
                                fontSize: 18.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Get.back();
                                setState(() {
                                  _.startDate.text =
                                      '${DateTime.now().year}/${DateTime.now().month - 1}/${DateTime.now().day}';
                                  _.endDate.text =
                                      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
                                  _.filterChannelList.clear();
                                  _.filterProgramType.clear();
                                  _.filterHost.clear();
                                  _.filterGuests.clear();
                                  _.selectedchannel.clear();
                                  _.selectformDate.value = DateTime.now();
                                  _.selecttoDate.value = DateTime.now();
                                  _.filterlist.clear();
                                  _.filterlist.add('All Channels');
                                  _.selectedchannel.add('All Channels');
                                  _.filterlist.forEach((element) {
                                    if (element == 'All Channels') {
                                      _.channellist.forEach((e) {
                                        if (e.name != 'All Channels') {
                                          _.filterChannelList.add(e.name);
                                        }
                                      });
                                    }
                                  });
                                  _.channellist.forEach((e) {
                                    if (e.name == 'All Channels') {
                                      print('All Channel is true');
                                      e.check.value = true;
                                    } else {
                                      e.check.value = false;
                                    }
                                  });

                                  _.programType.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.startTime.clear();
                                  _.endTime.clear();
                                  _.hostselect.value.clear();
                                });
                                _.update();
                              },
                              child: Text(
                                'Clear All',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  letterSpacing: 0.4,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffb7b7b7),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _.startDate.text =
                                      '${DateTime.now().year}/${DateTime.now().month - 1}/${DateTime.now().day}';
                                  _.endDate.text =
                                      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
                                  _.filterChannelList.clear();
                                  _.filterProgramType.clear();
                                  _.filterHost.clear();
                                  _.filterGuests.clear();
                                  _.selectedchannel.clear();
                                  _.selectformDate.value = DateTime.now();
                                  _.selecttoDate.value = DateTime.now();
                                  _.filterlist.clear();
                                  _.filterlist.add('All Channels');
                                  _.selectedchannel.add('All Channels');
                                  _.filterlist.forEach((element) {
                                    if (element == 'All Channels') {
                                      _.channellist.forEach((e) {
                                        if (e.name != 'All Channels') {
                                          _.filterChannelList.add(e.name);
                                        }
                                      });
                                    }
                                  });
                                  _.channellist.forEach((e) {
                                    if (e.name == 'All Channels') {
                                      print('All Channel is true');
                                      e.check.value = true;
                                    } else {
                                      e.check.value = false;
                                    }
                                  });

                                  _.programType.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.startTime.clear();
                                  _.endTime.clear();
                                  _.hostselect.value.clear();
                                });
                                _.update();
                              },
                              child: Image.asset("assets/images/trash_full.png").marginOnly(left: 5,bottom: 2),

                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                            width: Get.width,
                            child: Obx(() => Wrap(
                                  children: <Widget>[
                                    for (int index = 0;
                                        index < _.filterlist.length;
                                        index++)
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: GestureDetector(
                                          onTap: () {
                                            // setState(() {
                                            //   _.filterGuests.removeWhere(
                                            //       (item) =>
                                            //           item ==
                                            //           _.filterlist[index]);
                                            //   _.filterHost.removeWhere((item) =>
                                            //       item == _.filterlist[index]);
                                            // });
                                            // _.deleteData(_.filterlist[index]);
                                            // _.filterlist.removeWhere((item) =>
                                            //     item == _.filterlist[index]);
                                            // _.filterProgramType
                                            //     .removeWhere((item) => _.filterlist[index]);
                                            // _.filterChannelList
                                            //     .removeWhere((item) => _.filterlist[index]);

                                            // _.update();

                                            setState(() {
                                              _.filterGuests.removeWhere(
                                                  (item) =>
                                                      item ==
                                                      _.filterlist[index]);
                                              _.filterHost.removeWhere((item) =>
                                                  item == _.filterlist[index]);

                                              // _.selectedchannel.removeWhere(
                                              //     (item) =>
                                              //         item ==
                                              //         _.filterlist[index]);
                                              _.update();
                                            });
                                            _.hostList.forEach((element) {
                                              if (element.name ==
                                                  _.filterlist[index]) {
                                                element.check.value = false;
                                              }
                                            });
                                            _.filterHost.removeWhere(
                                                (element) =>
                                                    element ==
                                                    _.filterlist[index]);

                                            _.guestModelList.forEach((element) {
                                              if (element.name ==
                                                  _.filterlist[index]) {
                                                element.check.value = false;
                                              }
                                            });

                                            _.filterGuests.removeWhere(
                                                (element) =>
                                                    element ==
                                                    _.filterlist[index]);

                                            _.selectedChannels.removeWhere(
                                                (element) =>
                                                    element.name ==
                                                    _.filterlist[index]);
                                            _.deleteData(_.filterlist[index]);
                                            _.filterProgramType.removeWhere(
                                                (item) =>
                                                    item ==
                                                    _.filterlist[index]);

                                            _.filterChannelList.removeWhere(
                                                (item) =>
                                                    item ==
                                                    _.filterlist[index]);

                                            _.filterlist.removeWhere((item) =>
                                                item == _.filterlist[index]);

                                            if (_.selectedchannel.length == 0) {
                                              setState(() {
                                                _.selectedchannel
                                                    .add('All Channels');
                                              });
                                              _.filterlist.add('All Channels');
                                            }

                                            _.update();
                                          },
                                          child: Container(
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: CommonColor.greenColor,
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              border: Border.all(
                                                  color:
                                                      CommonColor.greenColor),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${_.filterlist[index]}",
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    letterSpacing: 0.4,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Container(
                                                  height: 12.0,
                                                  width: 12.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color:
                                                        CommonColor.greenColor,
                                                    size: 10.0,
                                                  ),
                                                )
                                              ],
                                            ).marginOnly(left: 5.0, right: 5.0),
                                          ),
                                        ).marginOnly(right: 5.0, bottom: 5.0),
                                      )
                                  ],
                                ))),

                        // Container(
                        //   width: Get.width,
                        //   child: showFilter(_),
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Channel',
                            style: TextStyle(
                              letterSpacing: 0.4,
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              // channelSheet(ctx, _);
                              channelBottomSheet(_);
                            },
                            child: Container(
                              height: 30.0,
                              width: Get.width / 2.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: CommonColor.filterColor,
                                ),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Obx(
                                () => Center(
                                  child: Text(
                                    _.filterChannelList.length == 0
                                        ? 'All Channel'
                                        : "${_.listToString(_.filterChannelList)}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: CommonColor.filterColor,
                                        fontSize: 12.0),
                                  ).marginOnly(left: 5.0, right: 5.0),
                                ),
                              ),

                              //       DropDownMultiSelect(
                              //     filterlist: _.filterlist,
                              //     onChanged: (List<String> x) {
                              //       setState(() {
                              //         _.selectedchannel = x;
                              //         print('Length is ${x.length}');
                              //         if (x.length >= 2) {
                              //           if (x.last == 'All Channels') {
                              //             x.forEach((element) {
                              //               _.filterlist.removeWhere((item) =>
                              //                   item.toString() == element);
                              //             });
                              //             x.clear();
                              //             _.selectedchannel.clear();
                              //             _.update();
                              //             _.selectedchannel.add('All Channels');
                              //             _.update();
                              //             _.filterlist.add('All Channels');
                              //           } else {
                              //             x.removeWhere(
                              //                 (item) => item == 'All Channels');
                              //             _.selectedchannel.removeWhere(
                              //                 (item) => item == 'All Channels');
                              //             _.update();
                              //             _.filterlist.removeWhere(
                              //                 (item) => item == 'All Channels');
                              //           }
                              //           _.selectedchannel.forEach((element) {
                              //             print(
                              //                 'Check All Channel in List $element');
                              //           });
                              //           // x.forEach((element) {

                              //           //   print('Channel All Channel $element');
                              //           //   print("CHeck Data is Last Node ${x.last}");
                              //           // });
                              //         } else if (x.length == 0) {
                              //           _.selectedchannel.add('All Channels');
                              //           _.update();
                              //           _.filterlist.add('All Channels');
                              //         }
                              //       });
                              //     },
                              //     options: _.channellistonly,
                              //     selectedValues: _.selectedchannel,
                              //     whenEmpty: 'Select Channel',
                              //   ),
                            ),
                          ),
                        ),

                        // Container(
                        //   width: Get.width,
                        //   child: showchannel(_),
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Date',
                            style: TextStyle(
                              letterSpacing: 0.4,
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: Get.width / 3.0,
                                  child: Text(
                                    'From',
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                      fontSize: 12.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CommonColor.filterColor),
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    width: Get.width / 3.0,
                                    child: _.startDate.text.isEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                                Text("Start Date",
                                                    style: TextStyle(
                                                      letterSpacing: 0.4,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 13.0,
                                                      color: CommonColor
                                                          .filterColor,
                                                    )),
                                                Icon(Icons.keyboard_arrow_down,
                                                    color:
                                                        CommonColor.filterColor)
                                              ])
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${_.startDate.value.text}",
                                                style: TextStyle(
                                                  letterSpacing: 0.4,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 13.0,
                                                  color:
                                                      CommonColor.filterColor,
                                                ),
                                              ),
                                              Icon(Icons.keyboard_arrow_down,
                                                  color:
                                                      CommonColor.filterColor)
                                            ],
                                          ),
                                  ).marginOnly(left: 5),
                                  onTap: () {
                                    showDatePicker(
                                      context: ctx,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.dark(),
                                          child: child!,
                                        );
                                      },
                                    ).then(
                                      (DateTime? date) {
                                        if (date != null) {
                                          setState(
                                            () {
                                              _.selectformDate.value = date;
                                              _.startDate.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(date);
                                            },
                                          );
                                          print(
                                              'Selected Date is ${_.selectformDate}');
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 9.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: Get.width / 3.0,
                                  child: Text(
                                    'To',
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto',
                                      fontSize: 12.0,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CommonColor.filterColor),
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    width: Get.width / 3.0,
                                    child: _.endDate.text.isEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                                Text(
                                                  "End Date",
                                                  style: TextStyle(
                                                    letterSpacing: 0.4,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 13.0,
                                                    color:
                                                        CommonColor.filterColor,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color:
                                                      CommonColor.filterColor,
                                                ),
                                              ])
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${_.endDate.value.text}",
                                                style: TextStyle(
                                                    letterSpacing: 0.4,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 13.0,
                                                    color: CommonColor
                                                        .filterColor),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                color: CommonColor.filterColor,
                                              ),
                                            ],
                                          ),
                                  ).marginOnly(left: 5),
                                  onTap: () {
                                    showDatePicker(
                                      context: ctx,
                                      initialDate: DateTime.now(),
                                      // firstDate: DateTime.now()
                                      //     .subtract(Duration(days: 180)),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.dark(),
                                          child: child!,
                                        );
                                      },
                                    ).then((DateTime? date) {
                                      if (date != null) {
                                        setState(() {
                                          _.selecttoDate.value = date;
                                          _.endDate.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(date);
                                          _.filterlist.removeWhere((i) =>
                                              i.toString().substring(0, 2) ==
                                              '20');
                                          _.filterlist.add(
                                              '${_.startDate.text} - ${_.endDate.text}');
                                          print(
                                              'Selected Date is ${_.startDate.text} - ${_.endDate.text}');
                                        });
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        // <-------- Time ------->

                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     'Time',
                        //     style: TextStyle(
                        //       letterSpacing: 0.4,
                        //       fontWeight: FontWeight.w500,
                        //       fontFamily: 'Roboto',
                        //       color: Color(0xffffffff),
                        //       fontSize: 13.0,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Container(
                        //           width: Get.width / 3.5,
                        //           child: Text(
                        //             'From',
                        //             style: TextStyle(
                        //                 letterSpacing: 0.4,
                        //                 fontWeight: FontWeight.w400,
                        //                 fontFamily: 'Roboto',
                        //                 fontSize: 13.0,
                        //                 color: Color(0xffffffff)),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: 10.0,
                        //         ),
                        //         GestureDetector(
                        //           child: Container(
                        //             height: 25,
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(color: Colors.white),
                        //                 borderRadius:
                        //                     BorderRadius.circular(3.0)),
                        //             width: Get.width / 3.5,
                        //             child: _.startTime.text.isEmpty
                        //                 ? Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceAround,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.center,
                        //                     children: [
                        //                         Text("From Time",
                        //                             style: TextStyle(
                        //                                 letterSpacing: 0.4,
                        //                                 fontWeight:
                        //                                     FontWeight.w300,
                        //                                 fontFamily: 'Roboto',
                        //                                 fontSize: 13.0,
                        //                                 color:
                        //                                     Color(0xffffffff))),
                        //                         Icon(Icons.keyboard_arrow_down,
                        //                             color: Color(0xffabb4bd))
                        //                       ])
                        //                 : Center(
                        //                     child: Text(
                        //                       "${_.startTime.text}",
                        //                       style: TextStyle(
                        //                           letterSpacing: 0.4,
                        //                           fontSize: 15.0,
                        //                           color: Colors.white),
                        //                     ),
                        //                   ),
                        //           ).marginOnly(left: 5),
                        //           onTap: () {
                        //             showTimePicker(
                        //               context: ctx,
                        //               initialTime: TimeOfDay.now(),
                        //               builder: (BuildContext context,
                        //                   Widget? child) {
                        //                 return Theme(
                        //                   data: ThemeData.dark(),
                        //                   child: child!,
                        //                 );
                        //               },
                        //             ).then((TimeOfDay? value) {
                        //               setState(() {
                        //                 DateTime tempDate = DateFormat("hh:mm")
                        //                     .parse(value!.hour.toString() +
                        //                         ":" +
                        //                         value.minute.toString());
                        //                 _.startTime.text =
                        //                     _.dateFormat.format(tempDate);
                        //                 _.filterlist.add(_.startTime.text);
                        //               });
                        //             });
                        //           },
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       width: 9.0,
                        //     ),
                        //     Column(
                        //       children: [
                        //         Container(
                        //           width: Get.width / 3.5,
                        //           child: Text('To',
                        //               style: TextStyle(
                        //                 letterSpacing: 0.4,
                        //                 fontWeight: FontWeight.w300,
                        //                 fontSize: 13.0,
                        //                 color: Color(0xffffffff),
                        //               )),
                        //         ),
                        //         SizedBox(
                        //           height: 10.0,
                        //         ),
                        //         GestureDetector(
                        //           child: Container(
                        //             height: 25,
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(color: Colors.white),
                        //                 borderRadius:
                        //                     BorderRadius.circular(3.0)),
                        //             width: Get.width / 3.5,
                        //             child: _.endTime.text.isEmpty
                        //                 ? Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceAround,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.center,
                        //                     children: [
                        //                         Text("To Time",
                        //                             style: TextStyle(
                        //                                 letterSpacing: 0.4,
                        //                                 fontWeight:
                        //                                     FontWeight.w300,
                        //                                 fontSize: 13.0,
                        //                                 color:
                        //                                     Color(0xffffffff))),
                        //                         Icon(Icons.keyboard_arrow_down,
                        //                             color: Color(0xffabb4bd))
                        //                       ])
                        //                 : Center(
                        //                     child: Text(
                        //                       "${_.endTime.text}",
                        //                       style: TextStyle(
                        //                           letterSpacing: 0.4,
                        //                           fontSize: 15.0,
                        //                           color: Colors.white),
                        //                     ),
                        //                   ),
                        //           ).marginOnly(left: 5),
                        //           onTap: () {
                        //             showTimePicker(
                        //               context: ctx,
                        //               initialTime: TimeOfDay.now(),
                        //               builder: (BuildContext context,
                        //                   Widget? child) {
                        //                 return Theme(
                        //                   data: ThemeData.dark(),
                        //                   child: child!,
                        //                 );
                        //               },
                        //             ).then((TimeOfDay? value) {
                        //               setState(() {
                        //                 DateTime tempDate = DateFormat("hh:mm")
                        //                     .parse(value!.hour.toString() +
                        //                         ":" +
                        //                         value.minute.toString());
                        //                 _.endTime.text =
                        //                     _.dateFormat.format(tempDate);
                        //                 _.filterlist.add(_.endTime.text);
                        //               });
                        //             });
                        //           },
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // <----------------- Program Type ----------------->
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Program Type',
                            style: TextStyle(
                              letterSpacing: 0.4,
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: Get.width,
                          child: showProgramType(_),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // <----------------- Host And Guests Type ----------------->
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width / 2.25,
                                  child: Text(
                                    'Host',
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _.hostList.length == 0
                                    ? Text(
                                        'No Host Available',
                                        style: TextStyle(
                                            letterSpacing: 0.4,
                                            color: Colors.white),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          hostBottomSheet(_);
                                        },
                                        child: Container(
                                          height: 30.0,
                                          width: Get.width / 2.5,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: CommonColor.filterColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                          ),
                                          child: Obx(
                                            () => Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Center(
                                                    child: Text(
                                                      _.filterHost.length == 0
                                                          ? 'Select Host'
                                                          : "${_.listToString(_.filterHost)}",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              CommonColor.filterColor,
                                                          fontSize: 12.0),
                                                    ).marginOnly(
                                                        left: 5.0, right: 5.0),
                                                  ),
                                                ),
                                                Image.asset(
                                                    "assets/images/Vector.png")
                                                    .marginOnly(right: 8),
                                              ],
                                            ),
                                          ),
                                          // DropDownMultiSelect(
                                          //   filterlist: _.filterlist,
                                          //   onChanged: (List<String> x) {
                                          //     setState(() {
                                          //       _.filterHost = x;
                                          //       // _.filterHost.forEach((element) {
                                          //       //   _.filterlist.removeWhere(
                                          //       //       (e) => e == element);
                                          //       // });
                                          //       // _.filterHost.forEach((element) {
                                          //       //   _.filterlist.add(element);
                                          //       // });
                                          //     });
                                          //   },
                                          //   options: _.anchorList,
                                          //   selectedValues: _.filterHost,
                                          //   whenEmpty: 'Select Host',
                                          // ),

                                          // CommonDropDownField(
                                          //   screenController: _,
                                          //   controller: _.hostselect.value,
                                          //   values: _.anchorList,
                                          //   checkedvalue: _.hostselect.value,
                                          //   placeholder: "",
                                          //   doCallback: _.addhostdata,
                                          // ),
                                        ),

                                      )

                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width / 2.25,
                                  child: Text(
                                    'Guest',
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _.guestModelList.length == 0
                                    ? Text(
                                        'No Guests Available',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          guestBottomSheet(_);
                                        },
                                        child: Container(
                                          height: 30.0,
                                          width: Get.width / 2.5,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: CommonColor.filterColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                          ),
                                          child: Obx(
                                            () => Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Center(
                                                    child: Text(
                                                      _.filterGuests.length == 0
                                                          ? 'Select Guest'
                                                          : "${_.listToString(_.filterGuests)}",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              CommonColor.filterColor,
                                                          fontSize: 12.0),
                                                    ).marginOnly(
                                                        left: 5.0, right: 5.0),
                                                  ),
                                                ),
                                                Image.asset(
                                                    "assets/images/Vector.png")
                                                    .marginOnly(right: 8),
                                              ],
                                            ),
                                          ),
                                          // DropDownMultiSelect(
                                          //   filterlist: _.filterlist,
                                          //   onChanged: (List<String> x) {
                                          //     setState(() {
                                          //       _.filterGuests = x;
                                          //       // _.filterlist(x);
                                          //       _.update();
                                          //     });
                                          //     _.filterGuests.forEach((element) {
                                          //       _.filterlist.removeWhere(
                                          //           (e) => e == element);
                                          //     });
                                          //     _.filterGuests.forEach((element) {
                                          //       _.filterlist.add(element);
                                          //     });
                                          //   },
                                          //   options: _.guestsList,
                                          //   selectedValues: _.filterGuests,
                                          //   whenEmpty: 'Select Guests',
                                          // )

                                          // CommonDropDownField(
                                          //   screenController: _,
                                          //   controller: _.guestselect.value,
                                          //   values: _.guestsList,
                                          //   checkedvalue: _.guestselect.value,
                                          //   placeholder: "",
                                          //   doCallback: _.addGuestsdata,
                                          // ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width / 3,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              letterSpacing: 0.4,
                              color: CommonColor.cancelButtonColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        minWidth: 120,
                        height: 38,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: CommonColor.greenBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(5.0)),
                        onPressed: () async {
                          var diff = _.selecttoDate.value
                              .difference(_.selectformDate.value)
                              .inDays;
                          print('Date Difference is $diff');
                          print('Search data is ${_.searchdata.value.text}');
                          if (_.searchdata.value.text != '' ||
                              _.searchdata.value.text.isNotEmpty) {
                            // _.searchdata.value.text = _.lastSearchText.value.text;
                            _.filterChannelList.forEach((e) {
                              print("Filter Channel in list $e");
                            });

                            print(
                                "Search Text String is if ${_.searchdata.value.text}");
                            print(
                                "Search Text String is if ${_.lastSearchText.value.text}");
                            _.update();
                            if (diff >= 0 && diff <= 183) {
                              Get.back();
                              // _.filterChannelList.clear();
                              // _.update();
                              // _.selectedchannel.forEach((e) {
                              //   if (e == 'All Channels') {
                              //     _.channellistonly.forEach((element) {
                              //       _.filterChannelList.add(element);
                              //       _.update();
                              //     });
                              //   } else {
                              //     _.filterChannelList.add(e);
                              //     _.update();
                              //   }
                              //   print('Check All Channel in List $e');
                              // });

                              await _.getFilterJobs(_.searchdata.value.text, 1);
                              _.filterChannelList.forEach((element) {
                                print('Filter Channel List $element');
                              });
                              _.filterProgramType.forEach((element) {
                                print('Program Type List $element');
                              });
                            } else if (diff < 0) {
                              CustomSnackBar.showSnackBar(
                                  title: AppStrings.dateerror,
                                  message: "",
                                  backgroundColor: CommonColor.snackbarColour,
                                  isWarning: true);
                            } else {
                              CustomSnackBar.showSnackBar(
                                  title: AppStrings.difference,
                                  message: "",
                                  backgroundColor: CommonColor.snackbarColour,
                                  isWarning: true);
                            }
                          } else {
                            _.searchdata.value.text =
                                _.lastSearchText.value.text;
                            print(
                                "Search Text String is ${_.searchdata.value.text}");
                            print(
                                "Search Text String is ${_.lastSearchText.value.text}");
                            if (diff >= 0 && diff <= 183) {
                              Get.back();
                              // _.filterChannelList.clear();
                              // _.update();
                              // _.selectedchannel.forEach((e) {
                              //   if (e == 'All Channels') {
                              //     _.channellistonly.forEach((element) {
                              //       _.filterChannelList.add(element);
                              //       _.update();
                              //     });
                              //   } else {
                              //     _.filterChannelList.add(e);
                              //     _.update();
                              //   }
                              //   print('Check All Channel in List $e');
                              // });
                              await _.getFilterJobs(_.searchdata.value.text, 1);
                              _.filterChannelList.forEach((element) {
                                print('Filter Channel List $element');
                              });
                              _.filterProgramType.forEach((element) {
                                print('Program Type List $element');
                              });
                            } else if (diff < 0) {
                              CustomSnackBar.showSnackBar(
                                  title: AppStrings.dateerror,
                                  message: "",
                                  backgroundColor: CommonColor.snackbarColour,
                                  isWarning: true);
                            } else {
                              CustomSnackBar.showSnackBar(
                                  title: AppStrings.difference,
                                  message: "",
                                  backgroundColor: CommonColor.snackbarColour,
                                  isWarning: true);
                            }
                          }
                        },
                        child: Text(
                          "APPLY FILTER",
                          style: TextStyle(
                              letterSpacing: 0.4,
                              color: CommonColor.greenColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500),
                        ),
                        minWidth: 120,
                        height: 38,
                        color: CommonColor.greenColorWithOpacity,
                      ),
                    ),
                  ],
                ).marginOnly(top: 10.0, bottom: 10.0),
              ],
            ).marginOnly(left: 15.0, right: 15.0),
          ),
        );
      }),
    );
  }

  // <--------- Channel Widget ---------------->

  Widget showchannel(SearchController _) {
    print("check ${_.channellist.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.channellist.length; i++) {
      g.add(
        SizedBox(
          width: Get.width / 3.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Theme(
                child: Obx(
                  () => Checkbox(
                    visualDensity:
                        VisualDensity(horizontal: -3.5, vertical: -2.5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side:
                        BorderSide(width: 1.0, color: CommonColor.filterColor),
                    activeColor: CommonColor.greenColor,
                    focusColor: CommonColor.filterColor,
                    hoverColor: CommonColor.filterColor,
                    value: _.channellist[i].check.value,
                    onChanged: (val) {
                      if (_.channellist[i].check.value == false) {
                        _.channellist[i].check.value = true;
                        if (_.channellist[i].name == 'All Channels') {
                          _.filterlist.add(_.channellist[i].name.toString());
                          _.channellist[i].check.value = true;
                          _.channellist.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.filterlist
                                  .removeWhere((item) => item == element.name);
                              _.filterChannelList.add(element.name);
                              element.check.value = false;
                              _.update();
                            }
                          });
                        } else if (_.channellist[i].name != 'All Channels') {
                          for (int i = 0; i < _.filterlist.length; i++) {
                            if (_.filterlist[i] == 'All Channels') {
                              _.filterlist.removeWhere(
                                  (item) => item == 'All Channels');
                              _.filterChannelList.clear();
                              _.channellist.forEach((element) {
                                if (element.name == 'All Channels') {
                                  element.check.value = false;
                                }
                              });
                            }
                          }
                          _.filterlist.add(_.channellist[i].name);
                          _.filterChannelList.add(_.channellist[i].name);
                          _.update();
                        }
                      } else {
                        _.channellist[i].check.value = false;
                        if (_.channellist[i].name == 'All Channels') {
                          _.filterChannelList.clear();
                          _.filterlist.removeWhere(
                              (item) => item == _.channellist[i].name);
                          _.channellist.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.filterChannelList
                                  .removeWhere((i) => i == element.name);
                              element.check.value = false;
                              _.update();
                            }
                          });
                        } else if (_.channellist[i].name != 'All Channels') {
                          for (int i = 0; i < _.filterlist.length; i++) {
                            if (_.filterlist[i] == 'All Channels') {
                              _.filterChannelList.clear();
                            }
                          }
                        }
                        _.filterlist.removeWhere(
                            (item) => item == _.channellist[i].name);
                        print('Channelsa Name is ${_.channellist[i].name}');
                        _.filterChannelList.removeWhere(
                            (item) => item == _.channellist[i].name);
                        _.filterChannelList.forEach((element) {
                          print('Filter Channel is $element');
                        });
                        _.update();
                      }
                    },
                  ),
                ),
                data: ThemeData(unselectedWidgetColor: Colors.white),
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Text(
                  "${_.channellist[i].name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.4,
                    color: CommonColor.filterColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Wrap(
      children: g,
    );
  }

  void channelSheet(BuildContext context, SearchController _) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: CommonColor.backgroundColour,
        builder: (ctx) {
          return MultiSelectBottomSheet(
            items: _.item,
            initialValue: _.selectedChannels,
            selectedColor: CommonColor.greenColor,
            itemsTextStyle: TextStyle(
              fontSize: 13,
              fontFamily: 'Roboto',
              color: CommonColor.filterColor,
              fontWeight: FontWeight.w300,
            ),
            unselectedColor: Colors.white,
            selectedItemsTextStyle: TextStyle(
              fontSize: 13,
              fontFamily: 'Roboto',
              color: CommonColor.whiteColor,
              fontWeight: FontWeight.w300,
            ),
            onSelectionChanged: (List<Channel?> values) {
              _.channels.forEach((e) {
                _.filterlist.removeWhere((element) => element == e.name);
              });

              values.forEach((element) {
                _.filterlist.add(element!.name);
                print("Select Values ${element.name}");
              });
            },
            maxChildSize: 0.8,
          );
        });
  }

  //<------------------------ All Bottom Sheets ------------------------>

  void channelBottomSheet(SearchController _) {
    Get.bottomSheet(
      Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 5.0,
              width: 60.0,
              decoration: BoxDecoration(
                  color: CommonColor.filterColor,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _.channellist.length,
              shrinkWrap: true,
              separatorBuilder: (c, e) {
                return const SizedBox(
                  width: 20.0,
                );
              },
              itemBuilder: (c, i) {
                return InkWell(
                  splashColor: Color(0xff22B161),
                  hoverColor: Color(0xff22B161),
                  focusColor: Color(0xff22B161),
                  onTap: () {
                    // if(_.channellist[i].check.value == false)
                    // {
                    //   _.channellist[i].check.value = true;
                    //   if(_.channellist[i].name == 'All Channels')
                    //   {
                    //     _.filterlist.add(_.channellist[i].name.toString());
                    //     _.channellist.forEach((element) {
                    //       if(element.name != 'All Channel')
                    //       {
                    //         element.check.value = false;
                    //         _.filterChannelList.add(element.name);
                    //         _.filterlist.removeWhere((e) => e == element.name);
                    //       }
                    //     });
                    //   }
                    //   else if(_.channellist[i].name != 'All Channels')
                    //   {
                    //     for (int i = 0; i < _.filterlist.length; i++)
                    //     {
                    //       if (_.filterlist[i] == 'All Channels') {
                    //         _.filterlist.removeWhere((item) => item == 'All Channels');
                    //         _.filterChannelList.clear();
                    //       }
                    //     }
                    //   }
                    //   else
                    //   {
                    //     _.filterlist.add(_.channellist[i].name);
                    //     _.filterChannelList.add(_.channellist[i].name);
                    //   }
                    // }
                    // else{
                    //   _.channellist[i].check.value = false;
                    //   if(_.channellist[i].name == 'All Channels')
                    //   {
                    //     _.channellist[i].check.value = true;
                    //     _.filterlist.add(_.channellist[i].name.toString());
                    //     _.channellist.forEach((element) {
                    //       if(element.name != 'All Channel')
                    //       {
                    //         element.check.value = false;
                    //         _.filterChannelList.add(element.name);
                    //         _.filterlist.removeWhere((e) => e == element.name);
                    //       }
                    //     });
                    //   }
                    //   else
                    //   {
                    //     _.filterlist.removeWhere((e) => e == _.channellist[i].name);
                    //     _.filterChannelList.removeWhere((e) => e == _.channellist[i].name);
                    //   }**
                    // }
                    if (_.channellist[i].check.value == false) {
                      _.channellist[i].check.value = true;
                      if (_.channellist[i].name == 'All Channels') {
                        _.filterlist.add(_.channellist[i].name.toString());
                        _.channellist[i].check.value = true;
                        _.channellist.forEach((element) {
                          if (element.name != 'All Channels') {
                            _.filterlist
                                .removeWhere((item) => item == element.name);
                            _.filterChannelList.add(element.name);
                            element.check.value = false;
                            _.update();
                          }
                        });
                      } else if (_.channellist[i].name != 'All Channels') {
                        for (int i = 0; i < _.filterlist.length; i++) {
                          if (_.filterlist[i] == 'All Channels') {
                            _.filterlist
                                .removeWhere((item) => item == 'All Channels');
                            _.filterChannelList.clear();
                            _.channellist.forEach((element) {
                              if (element.name == 'All Channels') {
                                element.check.value = false;
                              }
                            });
                          }
                        }
                        _.filterlist.add(_.channellist[i].name);
                        _.filterChannelList.add(_.channellist[i].name);
                        _.update();
                      }
                    } else {
                      _.channellist[i].check.value = false;
                      if (_.channellist[i].name == 'All Channels') {
                        _.filterChannelList.clear();
                        // _.filterlist.removeWhere(
                        //     (item) => item == _.channellist[i].name);
                        _.channellist.forEach((element) {
                          if (element.name != 'All Channels') {
                            _.filterChannelList
                                .removeWhere((i) => i == element.name);
                            element.check.value = false;
                            _.update();
                          }
                        });
                      } else if (_.channellist[i].name != 'All Channels') {
                        for (int i = 0; i < _.filterlist.length; i++) {
                          if (_.filterlist[i] == 'All Channels') {
                            _.filterChannelList.clear();
                          }
                        }
                      }
                      _.filterlist
                          .removeWhere((item) => item == _.channellist[i].name);
                      print('Channelsa Name is ${_.channellist[i].name}');
                      _.filterChannelList
                          .removeWhere((item) => item == _.channellist[i].name);
                      _.filterChannelList.forEach((element) {
                        print('Filter Channel is $element');
                      });
                      _.update();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        child: Obx(
                          () => Checkbox(
                            visualDensity:
                                VisualDensity(horizontal: -3.5, vertical: -2.5),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            side: BorderSide(
                                width: 1.0, color: CommonColor.filterColor),
                            activeColor: CommonColor.greenColor,
                            focusColor: CommonColor.filterColor,
                            hoverColor: CommonColor.filterColor,
                            value: _.channellist[i].check.value,
                            onChanged: (val) {
                              if (_.channellist[i].check.value == false) {
                                _.channellist[i].check.value = true;
                                if (_.channellist[i].name == 'All Channels') {
                                  _.filterlist
                                      .add(_.channellist[i].name.toString());
                                  _.channellist[i].check.value = true;
                                  _.channellist.forEach((element) {
                                    if (element.name != 'All Channels') {
                                      _.filterlist.removeWhere(
                                          (item) => item == element.name);
                                      _.filterChannelList.add(element.name);
                                      element.check.value = false;
                                      _.update();
                                    }
                                  });
                                } else if (_.channellist[i].name !=
                                    'All Channels') {
                                  for (int i = 0;
                                      i < _.filterlist.length;
                                      i++) {
                                    if (_.filterlist[i] == 'All Channels') {
                                      _.filterlist.removeWhere(
                                          (item) => item == 'All Channels');
                                      _.filterChannelList.clear();
                                      _.channellist.forEach((element) {
                                        if (element.name == 'All Channels') {
                                          element.check.value = false;
                                        }
                                      });
                                    }
                                  }
                                  _.filterlist.add(_.channellist[i].name);
                                  _.filterChannelList
                                      .add(_.channellist[i].name);
                                  _.update();
                                }
                              } else {
                                _.channellist[i].check.value = false;
                                if (_.channellist[i].name == 'All Channels') {
                                  _.filterChannelList.clear();
                                  _.filterlist.removeWhere(
                                      (item) => item == _.channellist[i].name);
                                  _.channellist.forEach((element) {
                                    if (element.name != 'All Channels') {
                                      _.filterChannelList.removeWhere(
                                          (i) => i == element.name);
                                      element.check.value = false;
                                      _.update();
                                    }
                                  });
                                } else if (_.channellist[i].name !=
                                    'All Channels') {
                                  for (int i = 0;
                                      i < _.filterlist.length;
                                      i++) {
                                    if (_.filterlist[i] == 'All Channels') {
                                      _.filterChannelList.clear();
                                    }
                                  }
                                }
                                _.filterlist.removeWhere(
                                    (item) => item == _.channellist[i].name);
                                print(
                                    'Channelsa Name is ${_.channellist[i].name}');
                                _.filterChannelList.removeWhere(
                                    (item) => item == _.channellist[i].name);
                                _.filterChannelList.forEach((element) {
                                  print('Filter Channel is $element');
                                });
                                _.update();
                              }
                            },
                          ),
                        ),
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          "${_.channellist[i].name}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.4,
                            color: CommonColor.filterColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).marginOnly(left: 20.0, right: 20.0),
          ),
        ],
      ),
      backgroundColor: CommonColor.backgroundColour,
    );
  }

  void hostBottomSheet(SearchController _) {
    Get.bottomSheet(
      Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 5.0,
              width: 60.0,
              decoration: BoxDecoration(
                  color: CommonColor.filterColor,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _.hostList.length,
              shrinkWrap: true,
              separatorBuilder: (c, e) {
                return const SizedBox(
                  width: 20.0,
                );
              },
              itemBuilder: (c, i) {
                return InkWell(
                  splashColor: Color(0xff22B161),
                  hoverColor: Color(0xff22B161),
                  focusColor: Color(0xff22B161),
                  onTap: () {
                    _.hostList[i].check.value = !_.hostList[i].check.value;
                    if (_.hostList[i].check.value == true) {
                      _.filterlist.add(_.hostList[i].name.toString());
                      _.filterHost.add(_.hostList[i].name.toString());
                    } else {
                      _.filterlist.removeWhere(
                          (element) => element == _.hostList[i].name);
                      _.filterHost.removeWhere(
                          (element) => element == _.hostList[i].name);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        child: Obx(
                          () => Checkbox(
                            visualDensity:
                                VisualDensity(horizontal: -3.5, vertical: -2.5),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            side: BorderSide(
                                width: 1.0, color: CommonColor.filterColor),
                            activeColor: CommonColor.greenColor,
                            focusColor: CommonColor.filterColor,
                            hoverColor: CommonColor.filterColor,
                            value: _.hostList[i].check.value,
                            onChanged: (val) {
                              _.hostList[i].check.value =
                                  !_.hostList[i].check.value;
                              if (_.hostList[i].check.value == true) {
                                _.filterlist.add(_.hostList[i].name.toString());
                                _.filterHost.add(_.hostList[i].name.toString());
                              } else {
                                _.filterlist.removeWhere(
                                    (element) => element == _.hostList[i].name);
                                _.filterHost.removeWhere(
                                    (element) => element == _.hostList[i].name);
                              }
                            },
                          ),
                        ),
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          "${_.hostList[i].name}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.4,
                            color: CommonColor.filterColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).marginOnly(left: 20.0, right: 20.0),
          ),
        ],
      ),
      backgroundColor: CommonColor.backgroundColour,
    );
  }

  void guestBottomSheet(SearchController _) {
    Get.bottomSheet(
      Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 5.0,
              width: 60.0,
              decoration: BoxDecoration(
                  color: CommonColor.filterColor,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _.guestModelList.length,
              shrinkWrap: true,
              separatorBuilder: (c, e) {
                return const SizedBox(
                  width: 20.0,
                );
              },
              itemBuilder: (c, i) {
                return InkWell(
                  splashColor: Color(0xff22B161),
                  hoverColor: Color(0xff22B161),
                  focusColor: Color(0xff22B161),
                  onTap: () {
                    _.guestModelList[i].check.value =
                        !_.guestModelList[i].check.value;
                    if (_.guestModelList[i].check.value == true) {
                      _.filterlist.add(_.guestModelList[i].name.toString());
                      _.filterGuests.add(_.guestModelList[i].name.toString());
                    } else {
                      _.filterlist.removeWhere(
                          (element) => element == _.guestModelList[i].name);
                      _.filterGuests.removeWhere(
                          (element) => element == _.guestModelList[i].name);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        child: Obx(
                          () => Checkbox(
                            visualDensity:
                                VisualDensity(horizontal: -3.5, vertical: -2.5),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            side: BorderSide(
                                width: 1.0, color: CommonColor.filterColor),
                            activeColor: CommonColor.greenColor,
                            focusColor: CommonColor.filterColor,
                            hoverColor: CommonColor.filterColor,
                            value: _.guestModelList[i].check.value,
                            onChanged: (val) {
                              _.guestModelList[i].check.value =
                                  !_.guestModelList[i].check.value;
                              if (_.guestModelList[i].check.value == true) {
                                _.filterlist
                                    .add(_.guestModelList[i].name.toString());
                                _.filterGuests
                                    .add(_.guestModelList[i].name.toString());
                              } else {
                                _.filterlist.removeWhere((element) =>
                                    element == _.guestModelList[i].name);
                                _.filterGuests.removeWhere((element) =>
                                    element == _.guestModelList[i].name);
                              }
                            },
                          ),
                        ),
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          "${_.guestModelList[i].name}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.4,
                            color: CommonColor.filterColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).marginOnly(left: 20.0, right: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
      backgroundColor: CommonColor.backgroundColour,
    );
  }

  //<--------- Program Type Widget ---------------->

  Widget showProgramType(SearchController _) {
    print("check ${_.programType.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.programType.length; i++) {
      print('All Program list is ${_.programType[i]}');
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: Obx(
          () => GestureDetector(
            onTap: () {
              // _.programType.forEach((e) {
              //   e.check.value = false;
              // });
              if (_.programType[i].check.value == false) {
                _.programType[i].check.value = true;
                _.filterlist.add(_.programType[i].name);
                _.filterProgramType.add(_.programType[i].name);
                _.update();
              } else {
                _.programType[i].check.value = false;
                _.filterlist
                    .removeWhere((item) => item == _.programType[i].name);
                _.filterProgramType
                    .removeWhere((item) => item == _.programType[i].name);
                _.update();
              }
            },
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                  color: _.programType[i].check.value == true
                      ? CommonColor.greenColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      color: _.programType[i].check.value == true
                          ? CommonColor.greenColor
                          : CommonColor.filterColor)),
              child: Center(
                child: Text(
                  "${_.programType[i].name}",
                  style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.4,
                      fontWeight: _.programType[i].check.value == true
                          ? FontWeight.w500
                          : FontWeight.w300,
                      color: CommonColor.filterColor),
                ).marginOnly(left: 10.0, right: 10.0),
              ),
            ),
          ),
        ),
      ).marginOnly(right: 5.0, bottom: 10.0));
    }
    return Wrap(
      children: g,
    );
  }

  //<--------- Filter List Widget ---------------->

  Widget showFilter(SearchController _) {
    return StatefulBuilder(builder: (ctx, setState) {
      return Obx(() => Wrap(
            children: <Widget>[
              for (int index = 0; index < _.filterlist.length; index++)
                FittedBox(
                  fit: BoxFit.fill,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _.filterGuests
                            .removeWhere((item) => item == _.filterlist[index]);
                        _.filterHost
                            .removeWhere((item) => item == _.filterlist[index]);
                      });
                      _.deleteData(_.filterlist[index]);
                      _.filterlist
                          .removeWhere((item) => item == _.filterlist[index]);
                      // _.filterProgramType
                      //     .removeWhere((item) => _.filterlist[index]);
                      // _.filterChannelList
                      //     .removeWhere((item) => _.filterlist[index]);

                      _.update();
                    },
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: CommonColor.greenColor,
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(color: CommonColor.greenColor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${_.filterlist[index]}",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.4,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            height: 12.0,
                            width: 12.0,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.clear,
                              color: CommonColor.greenColor,
                              size: 10.0,
                            ),
                          )
                        ],
                      ).marginOnly(left: 5.0, right: 5.0),
                    ),
                  ).marginOnly(right: 5.0, bottom: 5.0),
                )
            ],
          ));
    });
  }
}




//--------------------------------------------------------------
//channellist2=channellist4
// filterlist1=filterlist
// channellist=channellist3
//channelsearchlist=channelsearchlist1