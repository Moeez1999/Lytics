import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


// import 'package:lens_app/views/Components/searchtextfield.dart';

import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/views/Search_Screen.dart';
import 'package:lytics_lens/widget/headline_container.dart';


import '../Controllers/searchbar_controller.dart';
import '../widget/internetconnectivity_screen.dart';

// import 'Components/Global_BottmNav.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: GlobalBottomNav(),
      body: SafeArea(child: bodyData(context)),
    );
  }

  Widget bodyData(context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return GetBuilder<SearchBarController>(
      init: SearchBarController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Container(
            // decoration: BoxDecoration(
            //   gradient: RadialGradient(
            //     colors: [
            //       Color(0xff1b1d28).withOpacity(.95),
            //       Color(0xff1b1d28),
            //     ],
            //   ),
            color: Color(0xff000425),

            // color: Color.fromRGBO(27, 29, 40, 1),
            height: Get.height,
            width: Get.width,
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                  // _.isShowList = false;
                  // _.update();
                }
              },
              onVerticalDragCancel: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                  // _.isShowList = false;
                  // _.update();
                }
              },
              child: _.isSocket
                  ? InterConnectivity(
                      onPressed: () async {
                        await _.gettopic();
                       // _.getHeadlines();
                      },
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: 50,
                          // ),
                          //
                          //
                          //
                          // Container(
                          //   height: 94,
                          //   width: Get.width,
                          //   child: ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: _.headlinelist.length >= 10
                          //         ? 10
                          //         : _.headlinelist.length,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return HeadlineContainer(
                          //         isHeadline: _.isHeadline,
                          //         colorCode: _.headlinelist[index]['color'],
                          //         channelName: _.headlinelist[index]['channel'],
                          //         headlinetype: _.headlinelist[index]
                          //             ['headlinetype'],
                          //         title: _.headlinelist[index]['title'],
                          //       );
                          //     },
                          //   ),
                          // ),
                          _.isLoading
                              ? Center(
                                  child: Image.asset(
                                    "assets/images/gif.gif",
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: GestureDetector(
                                    onTap: () {
                                      _.isShowList = false;
                                      _.update();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 90,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/new_logo.png"),
                                            ),
                                          ),
                                        ).marginOnly(
                                            left: 88, right: 88, top: 200),
                                        Container(
                                          height: 250,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(13.0),
                                              topLeft: Radius.circular(13.0),
                                            ),
                                            color: _.isShowList
                                                ? Color(0xff131c3a)
                                                : Colors.transparent,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 42,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(13.0),
                                                    bottomLeft:
                                                        Radius.circular(13.0),
                                                    topLeft:
                                                        Radius.circular(13.0),
                                                    bottomRight:
                                                        Radius.circular(13.0),
                                                  ),
                                                  color: Color(0xff455177),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                            onTap: () {
                                                              if (_
                                                                      .searchText
                                                                      .text
                                                                      .isEmpty &&
                                                                  _.searchText
                                                                          .text ==
                                                                      '') {
                                                              } else {
                                                                _.isShowList =
                                                                    false;
                                                                _.update();
                                                                Get.to(
                                                                    () =>
                                                                        SearchScreen(),
                                                                    arguments: _
                                                                        .searchText
                                                                        .text);
                                                              }
                                                            },
                                                            child: Image.asset(
                                                              "assets/images/search-green.png",
                                                              height: 20,
                                                              width:20,
                                                              fit: BoxFit.fill,
                                                            ))
                                                        .marginOnly(
                                                            left: 20.0,
                                                            top: 9,
                                                            bottom: 10,
                                                            right: 3.0),
                                                    Expanded(
                                                      child: TextFormField(

                                                        cursorColor: CommonColor
                                                            .greenColor,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            _.searchText,
                                                        onFieldSubmitted:
                                                            (String c) {
                                                          if (_.searchText.text
                                                              .isEmpty) {
                                                            // CustomSnackBar.showSnackBar(
                                                            //     title:
                                                            //         AppStrings.enterSomeText,
                                                            //     message: "",
                                                            //     backgroundColor:
                                                            //         Color(0xff48beeb),
                                                            //     isWarning: true);
                                                          } else {
                                                            _.isShowList =
                                                                false;
                                                            _.update();
                                                            Get.to(
                                                                () =>
                                                                    SearchScreen(),
                                                                arguments: _
                                                                    .searchText
                                                                    .text);
                                                          }
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        onTap: () {
                                                          _.isShowList = true;
                                                          _.update();
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          // prefixIcon: Icon(Icons.search),
                                                          // prefixIcon: Image.asset(
                                                          // "assets/images/search-green.png",
                                                          //
                                                          // //fit: BoxFit.none,
                                                          // ).marginOnly(),

                                                          // ).marginOnly(left: 20,top: 9,bottom: 9,right: 11),
                                                          hintText: "Search",
                                                          fillColor:
                                                              Color(0xff455177),
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          hintStyle: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xffD3D3D3),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xff455177),
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  6),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xff455177),
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  6),
                                                            ),
                                                          ),
                                                          filled: true,
                                                        ),
                                                        onChanged: (v) {
                                                          _.searchFunction(v);
                                                        },
                                                      ).marginOnly(left: 10.0),
                                                    ),
                                                    // GestureDetector(
                                                    //     onTap: () {
                                                    //       if (_.searchText.text
                                                    //               .isEmpty &&
                                                    //           _.searchText.text ==
                                                    //               '') {
                                                    //       } else {
                                                    //         _.isShowList = false;
                                                    //         _.update();
                                                    //         Get.to(
                                                    //             () =>
                                                    //                 SearchScreen(),
                                                    //             arguments: _
                                                    //                 .searchText
                                                    //                 .text);
                                                    //       }
                                                    //     },
                                                    //     child: Image.asset(
                                                    //       "assets/images/search-green.png",
                                                    //       height: 25,
                                                    //       width: 25,
                                                    //       fit: BoxFit.fill,
                                                    //     )).marginOnly(right: 10.0)
                                                    GestureDetector(
                                                            onTap: () {
                                                              _.searchText
                                                                  .clear();
                                                              _.update();
                                                            },
                                                            child: Image.asset(
                                                              "assets/images/cross-green.png",
                                                              height: 12,
                                                              width: 12,
                                                              fit: BoxFit.fill,
                                                            ))
                                                        .marginOnly(
                                                            left: 20.0,
                                                            top: 9,
                                                            bottom: 10,
                                                            right: 15.0),
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //   width: double.infinity,
                                              //   height: 50,
                                              //   decoration: BoxDecoration(
                                              //     borderRadius: BorderRadius.all(
                                              //         Radius.circular(13.0)),
                                              //     color: Color(0xff3e404b),
                                              //   ),
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.only(
                                              //         top: 0.0,
                                              //         bottom: 0.0,
                                              //         right: 10.0,
                                              //         left: 10.0),
                                              //     child: Stack(
                                              //       alignment:
                                              //           Alignment.centerRight,
                                              //       children: [
                                              //         TextFormField(
                                              //           textAlignVertical:
                                              //               TextAlignVertical
                                              //                   .center,
                                              //           controller: _.searchText,
                                              //           style: TextStyle(
                                              //               color: Colors.white,
                                              //               fontSize: 17.0),
                                              //           cursorColor: CommonColor
                                              //               .orangeColor,
                                              //           keyboardType:
                                              //               TextInputType.text,
                                              //           onTap: () {
                                              //             _.isShowList = true;
                                              //             _.update();
                                              //           },
                                              //           cursorHeight: 24,
                                              //           onFieldSubmitted:
                                              //               (String c) {
                                              //             if (_.searchText.text
                                              //                 .isEmpty) {
                                              //             } else {
                                              //               _.isShowList = false;
                                              //               _.update();
                                              //               Get.to(
                                              //                   () =>
                                              //                       SearchScreen(),
                                              //                   arguments: _
                                              //                       .searchText
                                              //                       .text);
                                              //             }
                                              //           },
                                              //           onChanged: (v) {
                                              //             _.searchFunction(v);
                                              //           },
                                              //           decoration:
                                              //               InputDecoration(
                                              //             // contentPadding:
                                              //             //     EdgeInsets
                                              //             //         .symmetric(
                                              //             //             horizontal:
                                              //             //                 45.0),
                                              //             hintText: "Search",
                                              //             isDense: true,
                                              //             hintStyle: TextStyle(
                                              //                 color: Color(
                                              //                     0xFFD3D3D3),
                                              //                 fontSize: 16),
                                              //             border:
                                              //                 InputBorder.none,
                                              //           ),
                                              //         ),
                                              //         GestureDetector(
                                              //           onTap: () {
                                              //             _.searchText.clear();
                                              //             _.update();
                                              //           },
                                              //           child: Icon(
                                              //             Icons.clear,
                                              //             size: 15,
                                              //             color: Colors.white,
                                              //           ),
                                              //         ),
                                              //         GestureDetector(
                                              //             onTap: () {
                                              //               if (_.searchText.text
                                              //                       .isEmpty &&
                                              //                   _.searchText
                                              //                           .text ==
                                              //                       '') {
                                              //               } else {
                                              //                 _.isShowList =
                                              //                     false;
                                              //                 _.update();
                                              //                 Get.to(
                                              //                     () =>
                                              //                         SearchScreen(),
                                              //                     arguments: _
                                              //                         .searchText
                                              //                         .text);
                                              //               }
                                              //             },
                                              //             child: Image.asset(
                                              //               "assets/images/search.png",
                                              //               height: 25,
                                              //               width: 25,
                                              //               fit: BoxFit.fill,
                                              //             ))
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),

                                              _.isShowList
                                                  ? Expanded(
                                                      child: Container(
                                                        width: Get.width,
                                                        child: ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          itemCount: _.searchtopiclist.length ==
                                                                  0
                                                              ? _.topiclist
                                                                  .length
                                                              : _.searchtopiclist
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                _.searchtopiclist
                                                                            .length ==
                                                                        0
                                                                    ? _.searchText
                                                                        .text = _
                                                                            .topiclist[index]
                                                                        ['name']
                                                                    : _.searchText
                                                                        .text = _
                                                                            .searchtopiclist[index]
                                                                        [
                                                                        'name'];
                                                                _.isShowList =
                                                                    false;
                                                                _.update();
                                                                Get.to(
                                                                    () =>
                                                                        SearchScreen(),
                                                                    arguments: _
                                                                        .searchText
                                                                        .text);
                                                                _.searchtopiclist.clear();
                                                                _.update();
                                                              },
                                                              child: Container(
                                                                height: 40.0,
                                                                child: _.searchtopiclist
                                                                            .length ==
                                                                        0
                                                                    ? Text(
                                                                        "${_.topiclist[index]['name']}",
                                                                        textScaleFactor:
                                                                            1.0,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          letterSpacing:
                                                                              0.4,
                                                                          color:
                                                                              Color(0xffFFFFFF),
                                                                        ),
                                                                      ).marginOnly(
                                                                        left:
                                                                            20,
                                                                        top:
                                                                            10.0)
                                                                    : Text(
                                                                        "${_.searchtopiclist[index]['name']}",
                                                                        textScaleFactor:
                                                                            1.0,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          letterSpacing:
                                                                              0.4,
                                                                          color:
                                                                              Color(0xffFFFFFF),
                                                                        )).marginOnly(left: 20, top: 10.0),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ).marginOnly(
                                            left: 30, right: 30, top: 22),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
