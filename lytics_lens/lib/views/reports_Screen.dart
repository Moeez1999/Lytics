import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lytics_lens/Views/barCharts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Constants/app_strrings.dart';
import '../Constants/common_color.dart';
import '../Controllers/reports_controller.dart';
import '../Models/simplechartmodel.dart';
import '../widget/snackbar/common_snackbar.dart';
import '../widget/internet_connectivity/internetconnectivity_screen.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return GetBuilder<ReportsController>(
      init: ReportsController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
              // backgroundColor: Theme.of(context).primaryColor,
              // appBar: AppBar(
              //   backgroundColor: Color.fromRGBO(27, 29, 40, 1),
              //   title: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         "Trending Topics",
              //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              //       )).marginOnly(left: 15.0),
              //   centerTitle: true,
              //   elevation: 0.0,
              //   automaticallyImplyLeading: false,
              // ),
              // bottomNavigationBar: GlobalBottomNav(),
              // drawer: GlobalDrawer(),
              body: Container(
            width: Get.width,
            height: Get.height,
            color: CommonColor.appBarColor,
            child: _.isSocket
                ? InterConnectivity(
                    onPressed: () async {
                      _.isLoading = true;
                      _.channellist2.clear();
                      _.channellist.clear();
                      _.update();
                      await _.getAllHost();
                      await _.getChannels();
                      await _.getProgram();
                      await _.getProgramType();
                      await _.getTopic();
                      await _.firstTimeGraphData('Top 10');
                      await _.firstTimePieChartData();
                      _.getdates();
                      _.isLoading = false;
                      _.update();
                    },
                  )
                : _.isSocketFirstGraph1
                    ? InterConnectivity(
                        onPressed: () async {
                          _.getGraphData();
                        },
                      )
                    : _.isSocketFirstGraph2
                        ? InterConnectivity(
                            onPressed: () async {
                              _.getPieChartData();
                            },
                          )
                        : _.isSocketFirstGraph1 || _.isSocketFirstGraph2
                            ? InterConnectivity(
                                onPressed: () async {
                                  _.getGraphData();
                                  _.getPieChartData();
                                },
                              )
                            : _.isDefaultGraph
                                ? InterConnectivity(
                                    onPressed: () async {
                                      _.firstTimeGraphData('Top 10');
                                    },
                                  )
                                : _.isLoading
                                    ? Center(
                                        child: Image.asset(
                                          "assets/images/gif.gif",
                                          height: 300.0,
                                          width: 300.0,
                                        ),
                                      ).marginOnly(bottom: 50.0)
                                    : GestureDetector(
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
                                        child: SafeArea(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                // <---------------- Trending Heading --------->
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Trending Topics',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          letterSpacing: 0.4,
                                                          fontFamily: 'Roboto'),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        showbottomsheet1(
                                                            context, _);
                                                      },
                                                      icon: Image.asset(
                                                        "assets/images/filter-green.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  ],
                                                ).marginOnly(
                                                    left: 16,
                                                    right: 6,
                                                    bottom: 0),
                                                // <------------- Graph 1st COntainer ---------->
                                                Container(
                                                  width: double.infinity,
                                                  height: 280,
                                                  decoration: BoxDecoration(
                                                    color: CommonColor
                                                        .textFieldBackgrounfColour,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: firstContainer(
                                                      _, context),
                                                ).marginOnly(left: 5, right: 5),

                                                // <---------------- 2nd Graph ----------->
                                                Container(
                                                  color: CommonColor
                                                      .textFieldBackgrounfColour,
                                                  //color: Color(0xff2d2f3a),
                                                  width: double.infinity,
                                                  //previously its 260
                                                  // height: 260,
                                                  child: Column(
                                                    children: [
                                                      //<------------- Heading ----------->
                                                      Container(
                                                        height: 50,
                                                        color: CommonColor
                                                            .appBarColor,
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Top 5 Guests',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      24.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              IconButton(
                                                                onPressed: () {
                                                                  showbottomsheet(
                                                                      context,
                                                                      _);
                                                                },
                                                                icon:
                                                                    Image.asset(
                                                                  "assets/images/filter-green.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ).marginOnly(
                                                          left: 16,
                                                          right: 0,
                                                        ),
                                                      ),
                                                      // Todo Comment code 2nd graph
                                                      seconContainer(
                                                          _, context),
                                                    ],
                                                  ),
                                                ).marginOnly(left: 5, right: 5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
          )),
        );
      },
    );
  }

  //<----------- Graph One Filter -------------->

  void showbottomsheet1(BuildContext ctx, ReportsController _) {
    showModalBottomSheet(
      elevation: 10,
      backgroundColor: CommonColor.textFieldBackgrounfColour,
      isScrollControlled: true,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(10.0),
      //     topRight: Radius.circular(10.0),
      //   ),
      // ),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Filters',
                              style: TextStyle(
                                letterSpacing: 0.4,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Get.back();
                                setState(() {
                                  _.filterlist1.clear();
                                  _.selectedchannel.clear();
                                  _.channelsearchlist.clear();
                                  _.channellist2.forEach((e) {
                                    if (e.name != 'All Channels') {
                                      e.check.value = false;
                                      _.channelsearchlist.add(e.name);
                                    } else {
                                      e.check.value = true;
                                    }
                                  });
                                  _.programslist.clear();
                                  _.programType1.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programtypegraph.clear();
                                  _.alldatelist1.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.filterlist1.add('All Channels');
                                  _.selectedchannel.add('All Channels');

                                  // _.hostselect.value.clear();
                                });
                                _.update();
                              },
                              child: Text(
                                'Clear All',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.back();
                                setState(() {
                                  _.filterlist1.clear();
                                  _.selectedchannel.clear();
                                  _.channelsearchlist.clear();
                                  _.channellist2.forEach((e) {
                                    if (e.name != 'All Channels') {
                                      e.check.value = false;
                                      _.channelsearchlist.add(e.name);
                                    } else {
                                      e.check.value = true;
                                    }
                                  });
                                  _.channellist2.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programslist.clear();
                                  _.programType1.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programtypegraph.clear();
                                  _.alldatelist1.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.filterlist1.add('All Channels');
                                  // _.hostselect.value.clear();
                                });
                                _.update();
                              },
                              child: Image.asset("assets/images/trash_full.png")
                                  .marginOnly(left: 5, bottom: 5),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _.filterlist1.clear();
                                  _.selectedchannel.clear();
                                  _.channelsearchlist.clear();
                                  _.channellist2.forEach((e) {
                                    if (e.name != 'All Channels') {
                                      e.check.value = false;
                                      _.channelsearchlist.add(e.name);
                                    } else {
                                      e.check.value = true;
                                    }
                                  });
                                  _.programType1.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programtypegraph.clear();
                                  _.programslist.clear();
                                  _.alldatelist1.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.filterlist1.add('All Channels');
                                  _.selectedchannel.add('All Channels');
                                  // _.hostselect.value.clear();
                                });
                                _.update();
                                Get.back();
                                await _.firstTimeGraphData('Top 5');
                                // setState(() {
                                //   _.filterlist1.clear();
                                //   _.channellist2.forEach((e) {
                                //     e.check.value = false;
                                //   });
                                //   _.programslist.clear();
                                //   _.programType1.forEach((e) {
                                //     e.check.value = false;
                                //   });
                                //   _.programtypegraph.clear();
                                //   _.alldatelist1.forEach((element) {
                                //     element.check.value = false;
                                //   });
                                //   // _.hostselect.value.clear();
                                // });
                                // _.update();
                              },
                              child: Container(
                                height: 30.0,
                                width: 99,
                                decoration: BoxDecoration(
                                    color: Color(0xff48beeb),
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        CommonColor.gradientColor,
                                        CommonColor.gradientColor2,
                                      ],
                                    )),
                                child: Center(
                                  child: Text(
                                    'Top 5 Topics',
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.4),
                                  ),
                                ),
                              ).marginOnly(top: 15, bottom: 10),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _.filterlist1.clear();
                                  _.selectedchannel.clear();
                                  _.channelsearchlist.clear();
                                  _.channellist2.forEach((e) {
                                    if (e.name != 'All Channels') {
                                      e.check.value = false;
                                      _.channelsearchlist.add(e.name);
                                    } else {
                                      e.check.value = true;
                                    }
                                  });
                                  _.programType1.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programtypegraph.clear();
                                  _.programslist.clear();
                                  _.alldatelist1.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.filterlist1.add('All Channels');
                                  _.selectedchannel.add('All Channels');
                                  // _.hostselect.value.clear();
                                });
                                _.update();
                                Get.back();
                                await _.firstTimeGraphData('Top 10');
                                // setState(() {
                                //   _.filterlist1.clear();
                                //   _.channellist2.forEach((e) {
                                //     e.check.value = false;
                                //   });
                                //   _.programslist.clear();
                                //   _.programType1.forEach((e) {
                                //     e.check.value = false;
                                //   });
                                //   _.programtypegraph.clear();
                                //   _.alldatelist1.forEach((element) {
                                //     element.check.value = false;
                                //   });
                                //   // _.hostselect.value.clear();
                                // });
                                // _.update();
                              },
                              child: Container(
                                height: 30.0,
                                width: 99,
                                decoration: BoxDecoration(
                                    color: Color(0xff48beeb),
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        CommonColor.gradientColor,
                                        CommonColor.gradientColor2,
                                      ],
                                    )),
                                child: Center(
                                  child: Text(
                                    'Top 10 Topics',
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.4),
                                  ),
                                ),
                              ).marginOnly(top: 15, bottom: 10, left: 5.3),
                            ),
                          ],
                        ),
                        Obx(
                          () => Wrap(
                            children: <Widget>[
                              for (int index = 0;
                                  index < _.filterlist1.length;
                                  index++)
                                FittedBox(
                                    fit: BoxFit.fill,
                                    child: GestureDetector(
                                      onTap: () {
                                        _.programType1.forEach((element) {
                                          if (element.name ==
                                              _.filterlist1[index]) {
                                            print('Check If Exist');
                                            element.check.value = false;
                                          }
                                        });

                                        _.programtypegraph.removeWhere(
                                            (element) =>
                                                element ==
                                                _.filterlist1[index]);
                                        _.deleteData(_.filterlist1[index]);

                                        setState(() {
                                          _.selectedchannel.removeWhere(
                                              (item) =>
                                                  item == _.filterlist1[index]);
                                        });
                                        _.filterlist1.removeWhere((item) =>
                                            item == _.filterlist1[index]);

                                        if (_.selectedchannel.length == 0) {
                                          setState(() {
                                            _.selectedchannel
                                                .add('All Channels');
                                          });
                                          _.channellist2.forEach((element) {
                                            if (element.name !=
                                                'All Channels') {
                                              _.channelsearchlist
                                                  .add(element.name);
                                            }
                                          });
                                          _.filterlist1.add('All Channels');
                                        }

                                        // _.deleteSearchChannelProgram(_.filterlist1[index]!);
                                        // if (_.filterlist1[index] !=
                                        //     'All Channels') {
                                        //   _.filterlist1.removeWhere((item) =>
                                        //       item == _.filterlist1[index]);
                                        // }
                                        // if (_.selectedchannel.length == 0) {
                                        //   setState(() {
                                        //     _.selectedchannel
                                        //         .add('All Channels');
                                        //   });
                                        //   _.filterlist1.add('All Channels');
                                        // }
                                      },
                                      child: Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: CommonColor.greenColor,
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                          border: Border.all(
                                            color: CommonColor.greenColor,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${_.filterlist1[index]}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
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
                                                color: CommonColor.greenColor,
                                                size: 10.0,
                                              ),
                                            )
                                          ],
                                        ).marginOnly(left: 5.0, right: 5.0),
                                      ),
                                    ).marginAll(5.0))
                            ],
                          ),
                        ),

                        // Container(
                        //   width: Get.width,
                        //   child: showFilter1(_),
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
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ).marginOnly(bottom: 7),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
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
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: Get.width / 3.5,
                                      child: Text(
                                        _.channelsearchlist.length ==
                                                _.channellist2.length - 1
                                            ? 'All Channels'
                                            : "${_.listToString(_.channelsearchlist)}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: CommonColor.filterColor,
                                            fontSize: 12.0),
                                      ).marginOnly(left: 5.0, right: 5.0),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              // DropDownMultiSelect(
                              //   filterlist: _.filterlist1,
                              //   onChanged: (List<String> x) {
                              //     setState(() {
                              //       _.selectedchannel = x;
                              //       print('Length is ${x.length}');
                              //       if (x.length >= 2) {
                              //         if (x.last == 'All Channels') {
                              //           x.forEach((element) {
                              //             _.filterlist1.removeWhere((item) =>
                              //                 item.toString() == element);
                              //           });
                              //           x.clear();
                              //           _.selectedchannel.clear();
                              //           _.update();
                              //           _.selectedchannel.add('All Channels');
                              //           _.update();
                              //           _.filterlist1.add('All Channels');
                              //         } else {
                              //           x.removeWhere(
                              //               (item) => item == 'All Channels');
                              //           _.selectedchannel.removeWhere(
                              //               (item) => item == 'All Channels');
                              //           _.update();
                              //           _.filterlist1.removeWhere(
                              //               (item) => item == 'All Channels');
                              //         }
                              //         _.selectedchannel.forEach((element) {
                              //           print(
                              //               'Check All Channel in List $element');
                              //         });
                              //         // x.forEach((element) {

                              //         //   print('Channel All Channel $element');
                              //         //   print("CHeck Data is Last Node ${x.last}");
                              //         // });
                              //       } else if (x.length == 0) {
                              //         _.selectedchannel.add('All Channels');
                              //         _.update();
                              //         _.filterlist1.add('All Channels');
                              //       }
                              //     });
                              //   },
                              //   options: _.channellistonly,
                              //   selectedValues: _.selectedchannel,
                              //   whenEmpty: 'Select Channel',
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // <----------------- Dates ----------------->
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Date',
                            style: TextStyle(
                              letterSpacing: 0.4,
                              fontSize: 13.0,
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
                          child: showDates1(_),
                        ),
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
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        showProgramTypeFilter1(_),
                        SizedBox(
                          height: 20.0,
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
                              fontWeight: FontWeight.w700),
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
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: CommonColor.greenBorderColor,
                          ),
                        ),
                        onPressed: () async {
                          // _.viewFilterData();
                          if (_.startSearchDate.text == '' &&
                              _.endpaichartSearchDate.text == '') {
                            CustomSnackBar.showSnackBar(
                                title: AppStrings.selectdate,
                                message: "",
                                backgroundColor: CommonColor.snackbarColour,
                                isWarning: true);
                          } else if (_.selectedchannel.length == 0) {
                            CustomSnackBar.showSnackBar(
                                title: AppStrings.channellist,
                                message: "",
                                backgroundColor: CommonColor.snackbarColour,
                                isWarning: true);
                          } else if (_.programtypegraph.length == 0) {
                            CustomSnackBar.showSnackBar(
                                title: AppStrings.programlist,
                                message: "",
                                backgroundColor: CommonColor.snackbarColour,
                                isWarning: true);
                          } else {
                            Get.back();
                            // _.selectedchannel.forEach((e) {
                            //   if (e == 'All Channels') {
                            //     _.channellistonly.forEach((element) {
                            //       _.channelsearchlist.add(element);
                            //       _.update();
                            //     });
                            //   } else {
                            //     _.channelsearchlist.add(e);
                            //     _.update();
                            //   }
                            //   print('Check All Channel in List $e');
                            // });
                            // _.isPieChartData = false;
                            // _.update();
                            await _.getGraphData();
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
                ).marginOnly(top: 20.0, bottom: 15.0),
              ],
            ).marginOnly(left: 15.0, right: 15.0),
          ),
        );
      }),
    );
  }

  void channelBottomSheet(ReportsController _) {
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
              itemCount: _.channellist2.length,
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
                    if (_.channellist2[i].check.value == false) {
                      _.channellist2[i].check.value = true;
                      if (_.channellist2[i].name == 'All Channels') {
                        _.filterlist1.clear();
                        if (_.endSearchDate.text != '' &&
                            _.startSearchDate.text != '') {
                          _.filterlist1.add(
                              '${_.endSearchDate.text} - ${_.startSearchDate.text}');
                        }
                        // _.searchFunction(_.channellist2[i].name!);
                        _.channellist2[i].check.value = true;
                        _.filterlist1.add(_.channellist2[i].name);
                        _.channellist2.forEach((element) {
                          if (element.name != 'All Channels') {
                            _.filterlist1
                                .removeWhere((item) => item == element.name);
                            _.channelsearchlist
                                .removeWhere((item) => item == element.name);
                            _.channelsearchlist.add(element.name);
                            element.check.value = false;
                            _.update();
                          }
                        }); // Idhr tk Function Bilkul Perfect Hai
                      } else if (_.channellist2[i].name != 'All Channels') {
                        for (int i = 0; i < _.filterlist1.length; i++) {
                          if (_.filterlist1[i] == 'All Channels') {
                            _.filterlist1
                                .removeWhere((item) => item == 'All Channels');
                            _.filterlist1.removeWhere(
                                (item) => item == 'All Programs Name');
                            _.programslist.clear();
                            _.channelsearchlist.clear();
                            _.programsearchlist.clear();
                          }
                        }
                        // _.searchFunction(_.channellist2[i].name!);
                        _.channellist2.forEach((element) {
                          if (element.name == 'All Channels') {
                            element.check.value = false;
                          }
                        });
                        _.filterlist1.add(_.channellist[i].name);
                        _.channelsearchlist.add(_.channellist[i].name);
                        _.update();
                      } // YeAh Function b iDhr tk Bilkul Perfect Hai
                    } else {
                      _.channellist2[i].check.value = false;
                      if (_.channellist2[i].name == 'All Channels') {
                        _.filterlist1.removeWhere(
                            (item) => item == _.channellist2[i].name);
                        _.filterlist1
                            .removeWhere((item) => item == 'All Programs Name');
                        _.programslist.clear();
                        _.channellist2.forEach((element) {
                          if (element.name != 'All Channels') {
                            _.channelsearchlist
                                .removeWhere((item) => item == element.name);
                            element.check.value = false;
                            _.update();
                          }
                        }); // Idhr Tk If ki Condition Bilkul Perfect Hai
                      } else {
                        _.deleteSearchChannelProgram(_.channellist[i].name!);
                        _.filterlist1.removeWhere(
                            (item) => item == _.channellist[i].name);
                        _.channelsearchlist.removeWhere(
                            (item) => item == _.channellist[i].name);
                        _.update();
                      }
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
                            value: _.channellist2[i].check.value,
                            onChanged: (val) {
                              if (_.channellist2[i].check.value == false) {
                                _.channellist2[i].check.value = true;
                                if (_.channellist2[i].name == 'All Channels') {
                                  _.filterlist1.clear();
                                  if (_.endSearchDate.text != '' &&
                                      _.startSearchDate.text != '') {
                                    _.filterlist1.add(
                                        '${_.endSearchDate.text} - ${_.startSearchDate.text}');
                                  }
                                  // _.searchFunction(_.channellist2[i].name!);
                                  _.channellist2[i].check.value = true;
                                  _.filterlist1.add(_.channellist2[i].name);
                                  _.channellist2.forEach((element) {
                                    if (element.name != 'All Channels') {
                                      _.filterlist1.removeWhere(
                                          (item) => item == element.name);
                                      _.channelsearchlist.removeWhere(
                                          (item) => item == element.name);
                                      _.channelsearchlist.add(element.name);
                                      element.check.value = false;
                                      _.update();
                                    }
                                  }); // Idhr tk Function Bilkul Perfect Hai
                                } else if (_.channellist2[i].name !=
                                    'All Channels') {
                                  for (int i = 0;
                                      i < _.filterlist1.length;
                                      i++) {
                                    if (_.filterlist1[i] == 'All Channels') {
                                      _.filterlist1.removeWhere(
                                          (item) => item == 'All Channels');
                                      _.filterlist1.removeWhere((item) =>
                                          item == 'All Programs Name');
                                      _.programslist.clear();
                                      _.channelsearchlist.clear();
                                      _.programsearchlist.clear();
                                    }
                                  }
                                  // _.searchFunction(_.channellist2[i].name!);
                                  _.channellist2.forEach((element) {
                                    if (element.name == 'All Channels') {
                                      element.check.value = false;
                                    }
                                  });
                                  _.filterlist1.add(_.channellist[i].name);
                                  _.channelsearchlist
                                      .add(_.channellist[i].name);
                                  _.update();
                                } // YeAh Function b iDhr tk Bilkul Perfect Hai
                              } else {
                                _.channellist2[i].check.value = false;
                                if (_.channellist2[i].name == 'All Channels') {
                                  _.filterlist1.removeWhere(
                                      (item) => item == _.channellist2[i].name);
                                  _.filterlist1.removeWhere(
                                      (item) => item == 'All Programs Name');
                                  _.programslist.clear();
                                  _.channellist2.forEach((element) {
                                    if (element.name != 'All Channels') {
                                      _.channelsearchlist.removeWhere(
                                          (item) => item == element.name);
                                      element.check.value = false;
                                      _.update();
                                    }
                                  }); // Idhr Tk If ki Condition Bilkul Perfect Hai
                                } else {
                                  _.deleteSearchChannelProgram(
                                      _.channellist[i].name!);
                                  _.filterlist1.removeWhere(
                                      (item) => item == _.channellist[i].name);
                                  _.channelsearchlist.removeWhere(
                                      (item) => item == _.channellist[i].name);
                                  _.update();
                                }
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
                          "${_.channellist2[i].name}",
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

  void channelBottomSheetPieChart(ReportsController _) {
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
                    if (_.channellist[i].check.value == false) {
                      _.channellist[i].check.value = true;
                      if (_.channellist[i].name == 'All Channels') {
                        _.filterlist.clear();
                        if (_.endSearchDate.text != '' &&
                            _.startSearchDate.text != '') {
                          _.filterlist.add(
                              '${_.endSearchDate.text} - ${_.startSearchDate.text}');
                        }
                        // _.searchFunction(_.channellist2[i].name!);
                        _.channellist[i].check.value = true;
                        _.filterlist.add(_.channellist[i].name);
                        _.channellist.forEach((element) {
                          if (element.name != 'All Channels') {
                            _.filterlist
                                .removeWhere((item) => item == element.name);
                            _.channelsearchlist
                                .removeWhere((item) => item == element.name);
                            _.channelsearchlist.add(element.name);
                            element.check.value = false;
                            _.update();
                          }
                        }); // Idhr tk Function Bilkul Perfect Hai
                      } else if (_.channellist[i].name != 'All Channels') {
                        for (int i = 0; i < _.filterlist.length; i++) {
                          if (_.filterlist[i] == 'All Channels') {
                            _.filterlist
                                .removeWhere((item) => item == 'All Channels');
                            _.filterlist.removeWhere(
                                (item) => item == 'All Programs Name');
                            _.programslist.clear();
                            _.channelsearchlist.clear();
                            _.programsearchlist.clear();
                          }
                        }
                        // _.searchFunction(_.channellist2[i].name!);
                        _.channellist.forEach((element) {
                          if (element.name == 'All Channels') {
                            element.check.value = false;
                          }
                        });
                        _.filterlist.add(_.channellist[i].name);
                        _.channelsearchlist.add(_.channellist[i].name);
                        _.update();
                      } // YeAh Function b iDhr tk Bilkul Perfect Hai
                    } else {
                      _.channellist[i].check.value = false;
                      if (_.channellist[i].name == 'All Channels') {
                        _.filterlist.removeWhere(
                            (item) => item == _.channellist[i].name);
                        _.filterlist
                            .removeWhere((item) => item == 'All Programs Name');
                        _.programslist.clear();
                        _.channellist.forEach((element) {
                          if (element.name != 'All Channels') {
                            _.channelsearchlist
                                .removeWhere((item) => item == element.name);
                            element.check.value = false;
                            _.update();
                          }
                        }); // Idhr Tk If ki Condition Bilkul Perfect Hai
                      } else {
                        _.deleteSearchChannelProgram(_.channellist[i].name!);
                        _.filterlist.removeWhere(
                            (item) => item == _.channellist3[i].name);
                        _.channelsearchlist.removeWhere(
                            (item) => item == _.channellist3[i].name);
                        _.update();
                      }
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
                                  _.filterlist.clear();
                                  if (_.endSearchDate.text != '' &&
                                      _.startSearchDate.text != '') {
                                    _.filterlist.add(
                                        '${_.endSearchDate.text} - ${_.startSearchDate.text}');
                                  }
                                  // _.searchFunction(_.channellist2[i].name!);
                                  _.channellist[i].check.value = true;
                                  _.filterlist.add(_.channellist[i].name);
                                  _.channellist.forEach((element) {
                                    if (element.name != 'All Channels') {
                                      _.filterlist.removeWhere(
                                          (item) => item == element.name);
                                      _.channelsearchlist.removeWhere(
                                          (item) => item == element.name);
                                      _.channelsearchlist.add(element.name);
                                      element.check.value = false;
                                      _.update();
                                    }
                                  }); // Idhr tk Function Bilkul Perfect Hai
                                } else if (_.channellist[i].name !=
                                    'All Channels') {
                                  for (int i = 0;
                                      i < _.filterlist.length;
                                      i++) {
                                    if (_.filterlist[i] == 'All Channels') {
                                      _.filterlist.removeWhere(
                                          (item) => item == 'All Channels');
                                      _.filterlist.removeWhere((item) =>
                                          item == 'All Programs Name');
                                      _.programslist.clear();
                                      _.channelsearchlist.clear();
                                      _.programsearchlist.clear();
                                    }
                                  }
                                  // _.searchFunction(_.channellist2[i].name!);
                                  _.channellist.forEach((element) {
                                    if (element.name == 'All Channels') {
                                      element.check.value = false;
                                    }
                                  });
                                  _.filterlist.add(_.channellist[i].name);
                                  _.channelsearchlist
                                      .add(_.channellist[i].name);
                                  _.update();
                                } // YeAh Function b iDhr tk Bilkul Perfect Hai
                              } else {
                                _.channellist[i].check.value = false;
                                if (_.channellist[i].name == 'All Channels') {
                                  _.filterlist.removeWhere(
                                      (item) => item == _.channellist[i].name);
                                  _.filterlist.removeWhere(
                                      (item) => item == 'All Programs Name');
                                  _.programslist.clear();
                                  _.channellist.forEach((element) {
                                    if (element.name != 'All Channels') {
                                      _.channelsearchlist.removeWhere(
                                          (item) => item == element.name);
                                      element.check.value = false;
                                      _.update();
                                    }
                                  }); // Idhr Tk If ki Condition Bilkul Perfect Hai
                                } else {
                                  _.deleteSearchChannelProgram(
                                      _.channellist[i].name!);
                                  _.filterlist.removeWhere(
                                      (item) => item == _.channellist[i].name);
                                  _.channelsearchlist.removeWhere(
                                      (item) => item == _.channellist[i].name);
                                  _.update();
                                }
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

  Widget showDates1(ReportsController _) {
    print("check ${_.alldatelist1.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.alldatelist1.length; i++) {
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: Obx(() => GestureDetector(
              onTap: () {
                _.alldatelist1.forEach((e) {
                  e.check.value = false;
                  _.filterlist1.removeWhere((item) => item == e.startDate);
                  _.startSearchDate.clear();
                  _.endSearchDate.clear();
                  _.filterlist1.removeWhere((item) => item == e.endDate);
                });
                if (_.alldatelist1[i].check.value == false) {
                  _.alldatelist1[i].check.value = true;
                  _.startSearchDate.text = _.alldatelist1[i].startDate!;
                  _.endSearchDate.text = _.alldatelist1[i].endDate!;
                  _.filterlist1
                      .removeWhere((i) => i.toString().substring(0, 2) == '20');
                  _.filterlist1.add(
                      '${_.alldatelist1[i].endDate} - ${_.alldatelist1[i].startDate}');
                  _.update();
                  print('Start Date is ${_.startSearchDate.text}');
                }
              },
              child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: _.alldatelist1[i].check.value == true
                          ? CommonColor.greenColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: _.alldatelist1[i].check.value == true
                              ? CommonColor.greenColor
                              : CommonColor.filterColor)),
                  child: Center(
                    child: Text(
                      "${_.alldatelist1[i].name}",
                      style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: _.alldatelist1[i].check.value == true
                              ? FontWeight.w500
                              : FontWeight.w300,
                          color: CommonColor.filterColor),
                    ).marginOnly(left: 20.0, right: 20.0),
                  )),
            )),
      ).marginOnly(left: 0.0, right: 5.0, bottom: 8.62));
    }
    return Wrap(
      children: g,
    );
  }

  Widget showchannel1(ReportsController _) {
    print("check ${_.channellist2.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.channellist2.length; i++) {
      g.add(
        SizedBox(
          width: Get.width / 3.5,
          child: Row(
            children: [
              Theme(
                child: Obx(
                  () => Checkbox(
                    visualDensity:
                        VisualDensity(horizontal: -3.5, vertical: -2.5),
                    side:
                        BorderSide(width: 1.0, color: CommonColor.filterColor),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: CommonColor.greenColor,
                    focusColor: CommonColor.filterColor,
                    hoverColor: CommonColor.filterColor,
                    value: _.channellist2[i].check.value,
                    onChanged: (val) {
                      if (_.channellist2[i].check.value == false) {
                        _.channellist2[i].check.value = true;
                        if (_.channellist2[i].name == 'All Channels') {
                          _.filterlist1.clear();
                          if (_.endSearchDate.text != '' &&
                              _.startSearchDate.text != '') {
                            _.filterlist1.add(
                                '${_.endSearchDate.text} - ${_.startSearchDate.text}');
                          }
                          // _.searchFunction(_.channellist2[i].name!);
                          _.channellist2[i].check.value = true;
                          _.filterlist1.add(_.channellist2[i].name);
                          _.channellist2.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.filterlist1
                                  .removeWhere((item) => item == element.name);
                              _.channelsearchlist
                                  .removeWhere((item) => item == element.name);
                              _.channelsearchlist.add(element.name);
                              element.check.value = false;
                              _.update();
                            }
                          }); // Idhr tk Function Bilkul Perfect Hai
                        } else if (_.channellist2[i].name != 'All Channels') {
                          for (int i = 0; i < _.filterlist1.length; i++) {
                            if (_.filterlist1[i] == 'All Channels') {
                              _.filterlist1.removeWhere(
                                  (item) => item == 'All Channels');
                              _.filterlist1.removeWhere(
                                  (item) => item == 'All Programs Name');
                              _.programslist.clear();
                              _.channelsearchlist.clear();
                              _.programsearchlist.clear();
                            }
                          }
                          // _.searchFunction(_.channellist2[i].name!);
                          _.channellist2.forEach((element) {
                            if (element.name == 'All Channels') {
                              element.check.value = false;
                            }
                          });
                          _.filterlist1.add(_.channellist[i].name);
                          _.channelsearchlist.add(_.channellist[i].name);
                          _.update();
                        } // YeAh Function b iDhr tk Bilkul Perfect Hai
                      } else {
                        _.channellist2[i].check.value = false;
                        if (_.channellist2[i].name == 'All Channels') {
                          _.filterlist1.removeWhere(
                              (item) => item == _.channellist2[i].name);
                          _.filterlist1.removeWhere(
                              (item) => item == 'All Programs Name');
                          _.programslist.clear();
                          _.channellist2.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.channelsearchlist
                                  .removeWhere((item) => item == element.name);
                              element.check.value = false;
                              _.update();
                            }
                          }); // Idhr Tk If ki Condition Bilkul Perfect Hai
                        } else {
                          _.deleteSearchChannelProgram(_.channellist[i].name!);
                          _.filterlist1.removeWhere(
                              (item) => item == _.channellist[i].name);
                          _.channelsearchlist.removeWhere(
                              (item) => item == _.channellist[i].name);
                          _.update();
                        }
                      }
                    },
                  ),
                ),
                data: ThemeData(unselectedWidgetColor: Colors.white),
              ),
              SizedBox(
                width: 2.0,
              ),
              Flexible(
                child: Text(
                  "${_.channellist2[i].name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: CommonColor.filterColor),
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

  Widget showFilter1(ReportsController _) {
    return Obx(
      () => Wrap(
        children: <Widget>[
          for (int index = 0; index < _.filterlist1.length; index++)
            FittedBox(
                fit: BoxFit.fill,
                child: GestureDetector(
                  onTap: () {
                    _.programType1.forEach((element) {
                      if (element.name == _.filterlist1[index]) {
                        print('Check If Exist');
                        element.check.value = false;
                      }
                    });
                    _.programtypegraph.removeWhere(
                        (element) => element == _.filterlist1[index]);
                    _.deleteData(_.filterlist1[index]);
                    // _.deleteSearchChannelProgram(_.filterlist1[index]!);
                    _.filterlist1
                        .removeWhere((item) => item == _.filterlist1[index]);
                  },
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: CommonColor.greenColor,
                      borderRadius: BorderRadius.circular(2.0),
                      border: Border.all(
                        color: CommonColor.greenColor,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${_.filterlist1[index]}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                ).marginAll(5.0))
        ],
      ),
    );
  }

  Widget showProgramName(ReportsController _, ctx) {
    return StatefulBuilder(builder: (ctx, setstate) {
      return Obx(() {
        return GridView.builder(
          itemCount: _.programslist.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 5.5 / 1.7,
          ),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: Get.width / 3.25,
              child: GestureDetector(
                onTap: () {
                  setstate(() {
                    if (_.programslist[index].check.value == false) {
                      _.programslist[index].check.value = true;
                      if (_.programslist[index].name == 'All Programs Name') {
                        _.searchFunction('All Channels');
                      } else {
                        _.programsearchlist.add(_.programslist[index].name);
                        _.filterlist1.add(_.programslist[index].name);
                        _.update();
                      }
                    } else {
                      _.programslist[index].check.value = false;
                      if (_.programslist[index].name == 'All Programs Name') {
                        _.filterlist1.removeWhere(
                            (item) => item == _.programslist[index].name);
                        _.programsearchlist.clear();
                      } else {
                        _.filterlist1.removeWhere(
                            (item) => item == _.programslist[index].name);
                        _.programsearchlist.removeWhere(
                            (item) => item == _.programslist[index].name);
                      }
                      _.update();
                    }
                    print('All Value Is ${_.programslist[index].check}');
                  });
                },
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: _.programslist[index].check.value == true
                        ? Color(0xff22B161)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        color: _.programslist[index].check.value == true
                            ? Color(0xff22B161)
                            : Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "${_.programslist[index].name}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ).marginOnly(left: 5.0, right: 5.0),
                ),
              ).marginAll(5.0),
            );
          },
        );
      });
    });
  }

  Widget firstContainer(ReportsController _, context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: CommonColor.textFieldBackgrounfColour),
      child: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'Top 10 Topics on All Channels',
          //         style: TextStyle(
          //           fontSize: 14.0,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //       IconButton(
          //         onPressed: () {
          //           showbottomsheet1(context, _);
          //         },
          //         icon: Image.asset(
          //           "assets/images/filter.png",
          //           fit: BoxFit.fill,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Container(
                width: double.infinity,
                height: 330.0,
                child: AbsorbPointer(
                  absorbing: true,
                  child: Charts(_.dataValues),
                ),
              ),
            ),
          ),
        ],
      ).marginOnly(bottom: 10.0, left: 2.0, right: 0),
    ).marginOnly(
      left: 2.0,
      right: 0.0,
    );
  }

  Widget seconContainer(ReportsController _, context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //color: CommonColor.textFieldBackgrounfColour,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Below graph values are in %",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            SizedBox(
              height: Get.height / 3,
              child: AbsorbPointer(
                  absorbing: true, child: buildDefaultDoughnutChart(_)),
            )
          ],
        ),
      ).marginOnly(left: 9, right: 9, top: 10),
    );
  }

  //<---------- Pai Chart Filter ---------->

  void showbottomsheet(BuildContext ctx, ReportsController _) {
    showModalBottomSheet(
      elevation: 10,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                letterSpacing: 0.4,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Get.back();
                                setState(() {
                                  _.startpaichartSearchDate.clear();
                                  _.endpaichartSearchDate.clear();
                                  _.hostList.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.filterlist.clear();
                                  _.filterHost.clear();
                                  _.channellist.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programType.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.alldatelist.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.hostselect.value.clear();
                                  _.filterlist.add('All Channels');
                                });
                                _.update();
                              },
                              child: Text(
                                'Clear All',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _.startpaichartSearchDate.clear();
                                  _.endpaichartSearchDate.clear();
                                  _.hostList.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.filterlist.clear();
                                  _.filterHost.clear();
                                  _.channellist.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programType.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.alldatelist.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.hostselect.value.clear();
                                });
                                _.filterlist.add('All Channels');
                                _.update();
                              },
                              child: Image.asset("assets/images/trash_full.png")
                                  .marginOnly(left: 5, bottom: 5),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _.hostList.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.filterlist.clear();
                                  _.filterHost.clear();
                                  _.channellist.forEach((e) {
                                    e.check.value = false;
                                  });
                                  _.programType.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.alldatelist.forEach((element) {
                                    element.check.value = false;
                                  });
                                  _.hostselect.value.clear();
                                });
                                _.update();
                                Get.back();
                                await _.firstTimePieChartData();
                              },
                              child: Container(
                                height: 30.0,
                                width: 99,
                                decoration: BoxDecoration(
                                    color: Color(0xff48beeb),
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        CommonColor.gradientColor,
                                        CommonColor.gradientColor2,
                                      ],
                                    )),
                                child: Center(
                                  child: Text(
                                    'Top 5 Guests',
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.4),
                                  ),
                                ),
                              ).marginOnly(top: 15, right: 6, bottom: 7),
                            ),
                          ],
                        ),

                        Container(
                          width: Get.width,
                          child: showFilter(_),
                        ),
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
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ).marginOnly(bottom: 7),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                                onTap: () {
                                  channelBottomSheetPieChart(_);
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
                                      () => Row(
                                        children: [
                                          SizedBox(
                                            width: Get.width / 3.5,
                                            child: Text(
                                              _.channelsearchlist.length == _.channellist.length - 1
                                                  ? 'All Channels'
                                                  : "${_.listToString(_.channelsearchlist)}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color:
                                                      CommonColor.filterColor,
                                                  fontSize: 12.0),
                                            ).marginOnly(left: 5.0, right: 5.0),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )))),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: Get.width / 2.5,
                            // child: DropDownMultiSelect(
                            //   filterlist: _.filterlist,
                            //   readOnly: true,
                            //   onChanged: (List<String> x) {
                            //     setState(() {
                            //       _.filterchannellist = x;
                            //       _.update();
                            //       print('Filter Selected is Called');
                            //       _.filterchannellist.forEach((element) {
                            //         _.filterlist.removeWhere((e) =>
                            //         e.toString() ==
                            //             element.toString());
                            //       });
                            //       _.filterchannellist.forEach((element) {
                            //         _.filterchannellist.add(element);
                            //       });
                            //       _.filterchannellist.forEach((element) {});
                            //     });
                            //   },
                            //   options: _.allDropdownChannels,
                            //   selectedValues: _.filterHost,
                            //   whenEmpty: 'All Channels',
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        // <----------------- Dates ----------------->
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Date',
                            style: TextStyle(
                              letterSpacing: 0.4,
                              fontSize: 13.0,
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
                          child: showDates(_),
                        ),
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
                          child: _.programType.length == 0
                              ? Text(
                                  'No Program Type Available',
                                  style: TextStyle(
                                      letterSpacing: 0.4, color: Colors.white),
                                )
                              : showProgramType(_),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // <----------------- Host ----------------->
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                'Host',
                                style: TextStyle(
                                  letterSpacing: 0.4,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        _.hostList.length == 0
                            ? Text(
                                'No Host Available',
                                style: TextStyle(
                                    letterSpacing: 0.4, color: Colors.white),
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
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        Container(
                                          width: Get.width / 2.9,
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
                                          ).marginOnly(left: 5.0, right: 5.0),
                                        ),
                                        Spacer(),
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
                              ),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Container(
                        //     width: Get.width / 2.25,
                        //     child: Text(
                        //       'Host',
                        //       style: TextStyle(
                        //         letterSpacing: 0.4,
                        //         fontSize: 13.0,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // _.anchorList.length == 1 || _.anchorList.length == 0
                        //     ? Align(
                        //         alignment: Alignment.topLeft,
                        //         child: Text(
                        //           'No Host Available',
                        //           style: TextStyle(
                        //               letterSpacing: 0.4, color: Colors.white),
                        //         ),
                        //       )
                        //     : Align(
                        //         alignment: Alignment.topLeft,
                        //         child: Container(
                        //           width: Get.width / 2.5,
                        //           child: DropDownMultiSelect(
                        //             filterlist: _.filterlist,
                        //             readOnly: true,
                        //             onChanged: (List<String> x) {
                        //               setState(() {
                        //                 _.filterHost = x;
                        //                 _.update();
                        //                 print('Filter Selected is Called');
                        //                 _.filterHost.forEach((element) {
                        //                   _.filterlist.removeWhere((e) =>
                        //                       e.toString() ==
                        //                       element.toString());
                        //                 });
                        //                 _.filterHost.forEach((element) {
                        //                   _.filterlist.add(element);
                        //                 });
                        //                 _.filterlist.forEach((element) {});
                        //               });
                        //             },
                        //             options: _.anchorList,
                        //             selectedValues: _.filterHost,
                        //             whenEmpty: 'Select Host',
                        //           ),
                        //         ),
                        //       ),
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
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              letterSpacing: 0.4,
                              color: CommonColor.cancelButtonColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
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
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: CommonColor.greenBorderColor,
                          ),
                        ),
                        onPressed: () async {
                          // Get.back();
                          if (_.startpaichartSearchDate.text == '' &&
                              _.endpaichartSearchDate.text == '') {
                            CustomSnackBar.showSnackBar(
                              title: AppStrings.selectdate,
                              message: "",
                              backgroundColor: CommonColor.snackbarColour,
                              isWarning: true,
                            );
                          } else {
                            Get.back();
                            await _.getPieChartData();
                          }
                        },
                        child: Text(
                          "APPLY FILTER",
                          style: TextStyle(
                              letterSpacing: 0.4,
                              color: CommonColor.greenButtonTextColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                        minWidth: 120,
                        height: 38,
                        color: CommonColor.greenColorWithOpacity,
                      ),
                    ),
                  ],
                ).marginOnly(top: 20.0, bottom: 15.0),
              ],
            ).marginOnly(left: 15.0, right: 15.0),
          ),
        );
      }),
    );
  }

  void hostBottomSheet(ReportsController _) {
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

  Widget showDates(ReportsController _) {
    print("check ${_.alldatelist.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.alldatelist.length; i++) {
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: Obx(() => GestureDetector(
              onTap: () {
                _.alldatelist.forEach((e) {
                  e.check.value = false;
                  _.filterlist.removeWhere((item) => item == e.startDate);
                  _.startpaichartSearchDate.clear();
                  _.endpaichartSearchDate.clear();
                  _.filterlist.removeWhere((item) => item == e.endDate);
                });
                if (_.alldatelist[i].check.value == false) {
                  _.alldatelist[i].check.value = true;
                  _.startpaichartSearchDate.text = _.alldatelist[i].startDate!;
                  _.endpaichartSearchDate.text = _.alldatelist[i].endDate!;
                  _.filterlist
                      .removeWhere((i) => i.toString().substring(0, 2) == '20');
                  _.filterlist.add(
                      '${_.alldatelist[i].endDate} - ${_.alldatelist[i].startDate}');
                  _.update();
                  print('Start Date is ${_.startSearchDate.text}');
                }

                // _.alldatelist.forEach((e) {
                //   e.check.value = false;
                //   _.filterlist.removeWhere((item) => item == e.startDate);
                //   _.startpaichartSearchDate.clear();
                //   _.endpaichartSearchDate.clear();
                //   _.filterlist.removeWhere((item) => item == e.endDate);
                // });
                // if (_.alldatelist[i].check.value == false) {
                //   _.alldatelist[i].check.value = true;
                //   _.startpaichartSearchDate.text = _.alldatelist[i].startDate!;
                //   _.endpaichartSearchDate.text = _.alldatelist[i].endDate!;
                //   _.filterlist.add(_.alldatelist[i].endDate);
                //   _.filterlist.add(_.alldatelist[i].startDate);
                //   _.update();
                //   print('Start Date is ${_.startSearchDate.text}');
                // }
              },
              child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: _.alldatelist[i].check.value == true
                          ? Color(0xff22B161)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: _.alldatelist[i].check.value == true
                              ? Color(0xff22B161)
                              : Colors.white)),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          "${_.alldatelist[i].name}",
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: _.alldatelist[i].check.value == true
                                ? FontWeight.w500
                                : FontWeight.w300,
                            color: Colors.white,
                          ),
                        ).marginOnly(left: 20.0, right: 20.0),
                      ],
                    ),
                  )),
            )),
      ).marginAll(5.0));
    }
    return Wrap(
      children: g,
    );
  }

  // <------- Graph Properties ------------->

  SfCircularChart buildSmartLabelPieChart(ReportsController _) {
    return SfCircularChart(
      series: gettSmartLabelPieSeries(_.chartdata),
      tooltipBehavior: TooltipBehavior(enable: true, header: ''),
    );
  }

  List<PieSeries<ChartSampleData, String>> gettSmartLabelPieSeries(
      List<ChartSampleData>? chartdataSource) {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          dataSource: chartdataSource,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) =>
              data.x + ': ' + (data.y).toString() as String,
          radius: '50%',
          dataLabelSettings: DataLabelSettings(
            margin: EdgeInsets.zero,
            isVisible: true,
            textStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                overflow: TextOverflow.ellipsis,
                fontSize: 10.0,
                fontWeight: FontWeight.w300),
            // labelPosition: ChartDataLabelPosition.outside,
            connectorLineSettings: const ConnectorLineSettings(
                type: ConnectorType.curve, length: '0%'),
            labelIntersectAction: LabelIntersectAction.shift,
          ))
    ];
  }

  SfCircularChart buildDefaultDoughnutChart(ReportsController _) {
    return SfCircularChart(
      enableMultiSelection: false,

      margin: EdgeInsets.all(0),
      legend: Legend(
        toggleSeriesVisibility: false,
        position: LegendPosition.right,
        //iconBorderColor: Colors.transparent,
        isResponsive: true,
        borderWidth: 1,
        //overflowMode: LegendItemOverflowMode.wrap,
        textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 9,
            overflow: TextOverflow.ellipsis),
        isVisible: true,
        // Legend title
        //alignment: ChartAlignment.near,
        padding: 5.0,
        title: LegendTitle(
          alignment: ChartAlignment.center,
          text: "Guests",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900),
        ),
      ),
      // title: ChartTitle(text: isCardView ? '' : 'Composition of ocean water'),
      // legend: Legend(
      //     isVisible: !isCardView, overflowMode: LegendItemOverflowMode.wrap),
      series: _getDefaultDoughnutSeries(_.chartdata),
      //tooltipBehavior: _tooltip,
    );
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries(
      List<ChartSampleData>? chartdataSource) {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '90%',
          explode: false,
          explodeOffset: '10%',
          dataSource: chartdataSource,

          //<ChartSampleData>[

          // ChartSampleDatFa(x: 'Chlorine', y: 55, text: '55%'),
          // ChartSampleData(x: 'Sodium', y: 31, text: '31%'),
          // ChartSampleData(x: 'Magnesium', y: 7.7, text: '7.7%'),
          // ChartSampleData(x: 'Sulfur', y: 3.7, text: '3.7%'),
          // ChartSampleData(x: 'Calcium', y: 1.2, text: '1.2%'),
          // ChartSampleData(x: 'Others', y: 1.4, text: '1.4%'),

          //],
          enableTooltip: true,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData chartdataSource, _) =>
              chartdataSource.text,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)))
    ];
  }

  // <--------- Channel Widget ---------------->

  Widget showchannel(ReportsController _) {
    print("check ${_.channellist.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.channellist.length; i++) {
      print('All Channel is ${_.channellist[i]}');
      g.add(
        SizedBox(
          width: Get.width / 3.4,
          child: Row(
            children: [
              Theme(
                child: Obx(
                  () => Checkbox(
                    visualDensity:
                        VisualDensity(horizontal: -3.5, vertical: -2.5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Color(0xff22B161),
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    value: _.channellist[i].check.value,
                    onChanged: (val) {
                      if (_.channellist[i].check.value == false) {
                        _.channellist[i].check.value = true;
                        if (_.channellist[i].name == 'All Channels') {
                          // _.filterlist.clear();
                          if (_.endpaichartSearchDate.text != '' &&
                              _.startpaichartSearchDate.text != '') {
                            _.filterlist.add(
                                '${_.endpaichartSearchDate.text} - ${_.startpaichartSearchDate.text}');
                          }
                          _.channellist[i].check.value = true;
                          _.filterlist.add(_.channellist[i].name);
                          _.channellist.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.filterlist
                                  .removeWhere((item) => item == element.name);
                              _.paichartchannel
                                  .removeWhere((item) => item == element.name);
                              _.paichartchannel.add(element.name);
                              element.check.value = false;
                              _.update();
                            }
                          }); // Idhr tk Function Bilkul Perfect Hai
                        } else if (_.channellist[i].name != 'All Channels') {
                          for (int i = 0; i < _.filterlist.length; i++) {
                            if (_.filterlist[i] == 'All Channels') {
                              _.filterlist.removeWhere(
                                  (item) => item == 'All Channels');

                              _.paichartchannel.clear();
                            }
                          }
                          _.channellist.forEach((element) {
                            if (element.name == 'All Channels') {
                              element.check.value = false;
                            }
                          });
                          _.filterlist.add(_.channellist[i].name);
                          _.paichartchannel.add(_.channellist[i].name);
                          _.update();
                        } // YeAh Function b iDhr tk Bilkul Perfect Hai
                      } else {
                        _.channellist[i].check.value = false;
                        if (_.channellist[i].name == 'All Channels') {
                          _.filterlist.removeWhere(
                              (item) => item == _.channellist[i].name);
                          _.programslist.clear();
                          _.channellist.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.paichartchannel
                                  .removeWhere((item) => item == element.name);
                              element.check.value = false;
                              _.update();
                            }
                          }); // Idhr Tk If ki Condition Bilkul Perfect Hai
                        } else {
                          _.filterlist.removeWhere(
                              (item) => item == _.channellist[i].name);
                          _.paichartchannel.removeWhere(
                              (item) => item == _.channellist[i].name);
                          _.update();
                        }
                      }

                      // if (_.channellist[i].check.value == false) {
                      //   _.channellist[i].check.value = true;
                      //   if (_.channellist[i].name == 'All Channels') {
                      //     _.channellist[i].check.value = true;
                      //     _.filterlist.add(_.channellist[i].name);
                      //     _.channellist.forEach((element) {
                      //       if (element.name != 'All Channels') {
                      //         _.paichartchannel.add(element.name);
                      //         element.check.value = false;
                      //         _.update();
                      //       }
                      //     });
                      //   } else {
                      //     _.filterlist.add(_.channellist[i].name);
                      //     _.paichartchannel.add(_.channellist[i].name);
                      //     _.update();
                      //   }
                      // }
                      // else {
                      //   _.channellist[i].check.value = false;
                      //   if (_.channellist[i].name == 'All Channels') {
                      //     _.channellist.forEach((element) {
                      //       if (element.name != 'All Channels') {
                      //         _.filterlist.clear();
                      //         _.channelsearchlist.clear();
                      //         _.paichartchannel.clear();
                      //         element.check.value = false;
                      //         _.update();
                      //       }
                      //     });
                      //   }
                      //   _.paichartchannel.removeWhere(
                      //       (item) => item == _.channellist[i].name);
                      //   _.filterlist.removeWhere(
                      //       (item) => item == _.channellist[i].name);
                      //   _.update();
                      // }
                    },
                  ),
                ),
                data: ThemeData(unselectedWidgetColor: Colors.white),
              ),
              SizedBox(
                width: 2.0,
              ),
              Flexible(
                child: Text(
                  "${_.channellist[i].name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
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

  Widget showchannelPieChart(ReportsController _) {
    print("check ${_.channellist.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.channellist3.length; i++) {
      print('All Channel is ${_.channellist[i]}');
      g.add(
        SizedBox(
          width: Get.width / 3.4,
          child: Row(
            children: [
              Theme(
                child: Obx(
                  () => Checkbox(
                    visualDensity:
                        VisualDensity(horizontal: -3.5, vertical: -2.5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Color(0xff22B161),
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    value: _.channellist3[i].check.value,
                    onChanged: (val) {
                      if (_.channellist3[i].check.value == false) {
                        _.channellist3[i].check.value = true;
                        if (_.channellist3[i].name == 'All Channels') {
                          // _.filterlist.clear();
                          if (_.endpaichartSearchDate.text != '' &&
                              _.startpaichartSearchDate.text != '') {
                            _.filterlist.add(
                                '${_.endpaichartSearchDate.text} - ${_.startpaichartSearchDate.text}');
                          }
                          _.channellist3[i].check.value = true;
                          _.filterlist.add(_.channellist[i].name);
                          _.channellist3.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.filterlist
                                  .removeWhere((item) => item == element.name);
                              _.paichartchannel
                                  .removeWhere((item) => item == element.name);
                              _.paichartchannel.add(element.name);
                              element.check.value = false;
                              _.update();
                            }
                          }); // Idhr tk Function Bilkul Perfect Hai
                        } else if (_.channellist3[i].name != 'All Channels') {
                          for (int i = 0; i < _.filterlist.length; i++) {
                            if (_.filterlist[i] == 'All Channels') {
                              _.filterlist.removeWhere(
                                  (item) => item == 'All Channels');

                              _.paichartchannel.clear();
                            }
                          }
                          _.channellist3.forEach((element) {
                            if (element.name == 'All Channels') {
                              element.check.value = false;
                            }
                          });
                          _.filterlist.add(_.channellist3[i].name);
                          _.paichartchannel.add(_.channellist3[i].name);
                          _.update();
                        } // YeAh Function b iDhr tk Bilkul Perfect Hai
                      } else {
                        _.channellist3[i].check.value = false;
                        if (_.channellist[i].name == 'All Channels') {
                          _.filterlist.removeWhere(
                              (item) => item == _.channellist3[i].name);
                          _.programslist.clear();
                          _.channellist3.forEach((element) {
                            if (element.name != 'All Channels') {
                              _.paichartchannel
                                  .removeWhere((item) => item == element.name);
                              element.check.value = false;
                              _.update();
                            }
                          }); // Idhr Tk If ki Condition Bilkul Perfect Hai
                        } else {
                          _.filterlist.removeWhere(
                              (item) => item == _.channellist3[i].name);
                          _.paichartchannel.removeWhere(
                              (item) => item == _.channellist3[i].name);
                          _.update();
                        }
                      }

                      // if (_.channellist[i].check.value == false) {
                      //   _.channellist[i].check.value = true;
                      //   if (_.channellist[i].name == 'All Channels') {
                      //     _.channellist[i].check.value = true;
                      //     _.filterlist.add(_.channellist[i].name);
                      //     _.channellist.forEach((element) {
                      //       if (element.name != 'All Channels') {
                      //         _.paichartchannel.add(element.name);
                      //         element.check.value = false;
                      //         _.update();
                      //       }
                      //     });
                      //   } else {
                      //     _.filterlist.add(_.channellist[i].name);
                      //     _.paichartchannel.add(_.channellist[i].name);
                      //     _.update();
                      //   }
                      // }
                      // else {
                      //   _.channellist[i].check.value = false;
                      //   if (_.channellist[i].name == 'All Channels') {
                      //     _.channellist.forEach((element) {
                      //       if (element.name != 'All Channels') {
                      //         _.filterlist.clear();
                      //         _.channelsearchlist.clear();
                      //         _.paichartchannel.clear();
                      //         element.check.value = false;
                      //         _.update();
                      //       }
                      //     });
                      //   }
                      //   _.paichartchannel.removeWhere(
                      //       (item) => item == _.channellist[i].name);
                      //   _.filterlist.removeWhere(
                      //       (item) => item == _.channellist[i].name);
                      //   _.update();
                      // }
                    },
                  ),
                ),
                data: ThemeData(unselectedWidgetColor: Colors.white),
              ),
              SizedBox(
                width: 2.0,
              ),
              Flexible(
                child: Text(
                  "${_.channellist3[i].name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
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

  //<--------- Program Type Widget ---------------->

  Widget showProgramType(ReportsController _) {
    print("check ${_.programType.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.programType.length; i++) {
      print('All Program list is ${_.programType[i]}');
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: Obx(() => GestureDetector(
              onTap: () {
                // _.programType.forEach((e) {
                //   e.check.value = false;
                // });
                if (_.programType[i].check.value == false) {
                  _.programType[i].check.value = true;
                  _.filterlist.add(_.programType[i].name);
                  _.paichartprogramtype.add(_.programType[i].name);
                } else {
                  _.programType[i].check.value = false;
                  _.paichartprogramtype
                      .removeWhere((item) => item == _.programType[i].name);
                  _.filterlist
                      .removeWhere((item) => item == _.programType[i].name);
                  _.update();
                }
              },
              child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                      color: _.programType[i].check.value == true
                          ? Color(0xff22B161)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: _.programType[i].check.value == true
                              ? Color(0xff22B161)
                              : Colors.white)),
                  child: Center(
                    child: Text(
                      "${_.programType[i].name}",
                      style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: _.programType[i].check.value == true
                              ? FontWeight.w500
                              : FontWeight.w300,
                          color: Colors.white),
                    ).marginOnly(left: 10.0, right: 10.0),
                  )),
            )),
      ).marginOnly(right: 5.0, bottom: 5.0));
    }
    return Wrap(
      children: g,
    );
  }

  Widget showProgramTypeFilter1(ReportsController _) {
    print("check ${_.programType1.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.programType1.length; i++) {
      print('All Program list is ${_.programType1[i]}');
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: Obx(() => GestureDetector(
              onTap: () {
                // _.programType.forEach((e) {
                //   e.check.value = false;
                // });
                if (_.programType1[i].check.value == false) {
                  _.programType1[i].check.value = true;
                  _.filterlist1.add(_.programType1[i].name);
                  _.programtypegraph.add(_.programType1[i].name);
                } else {
                  _.programType1[i].check.value = false;
                  _.programtypegraph
                      .removeWhere((item) => item == _.programType1[i].name);
                  _.filterlist1
                      .removeWhere((item) => item == _.programType1[i].name);
                  _.update();
                }
              },
              child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                      color: _.programType1[i].check.value == true
                          ? CommonColor.greenColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: _.programType1[i].check.value == true
                              ? CommonColor.greenColor
                              : CommonColor.filterColor)),
                  child: Center(
                    child: Text(
                      "${_.programType1[i].name}",
                      style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: _.programType1[i].check.value == true
                              ? FontWeight.w500
                              : FontWeight.w300,
                          color: CommonColor.filterColor),
                    ).marginOnly(left: 10.0, right: 10.0),
                  )),
            )),
      ).marginOnly(right: 5.0, bottom: 10.0));
    }
    return Wrap(
      children: g,
    );
  }

  //<--------- Filter List Widget ---------------->

  Widget showFilter(ReportsController _) {
    return StatefulBuilder(builder: (ctx, setState) {
      return Obx(
        () => Wrap(
          children: <Widget>[
            for (int index = 0; index < _.filterlist.length; index++)
              FittedBox(
                  fit: BoxFit.fill,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _.hostList.forEach((element) {
                          if (element.name == _.filterlist[index]) {
                            element.check.value = false;
                          }
                        });
                        _.programType.forEach((element) {
                          if (element.name == _.filterlist[index]) {
                            element.check.value = false;
                          }
                        });
                        _.paichartprogramtype
                          ..removeWhere(
                              (element) => element == _.filterlist[index]);
                        _.deleteDataFilter(_.filterlist[index]);
                        // _.deleteSearchChannelProgram(_.filterlist[index]!);

                        _.filterHost
                            .removeWhere((item) => item == _.filterlist[index]);
                      });
                      _.anchorList.removeWhere(
                          (element) => element == _.filterlist[index]);
                      _.filterlist
                          .removeWhere((item) => item == _.filterlist[index]);
                    },
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xff22B161),
                        borderRadius: BorderRadius.circular(2.0),
                        border: Border.all(color: Color(0xff22B161)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${_.filterlist[index]}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
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
                              color: Color(0xff22B161),
                              size: 10.0,
                            ),
                          )
                        ],
                      ).marginOnly(left: 5.0, right: 5.0),
                    ),
                  ).marginAll(5.0))
          ],
        ),
      );
    });
  }

  Widget bulletColor({Color? bordercolor, Color? containercolor}) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        border: Border.all(color: bordercolor!),
        borderRadius: BorderRadius.circular(50.0),
        color: containercolor,
      ),
    );
  }
}
