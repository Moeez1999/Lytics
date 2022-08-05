// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';

import 'package:lytics_lens/widget/common_snackbar.dart';
import 'package:lytics_lens/Controllers/selectkeyword_controller.dart';

import 'package:lytics_lens/views/Components/widget/common_textfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectKeyWords extends StatelessWidget {
  const SelectKeyWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CommonColor.appBarColor,
      body: bodyData(context),
      appBar: AppBar(
        backgroundColor: CommonColor.appBarColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select Preference",
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              letterSpacing: 0.4,
            ),
          ).marginOnly(top: 10),
        ),
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_backspace_rounded,
          ).marginOnly(left: 26, right: 13, top: 10),
        ),
      ),
    );
  }

  Widget bodyData(context) {
    return GetBuilder<SelectKeyWordController>(
      init: SelectKeyWordController(),
      builder: (_) {
        return _.isLoading
            ? Center(
                child: Image.asset(
                  "assets/images/gif.gif",
                  height: 300.0,
                  width: 300.0,
                ),
              )
            : Obx(
                () {
                  return SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Clear All",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0,
                                          color: Color(0xffB7B7B7)),
                                    ).marginOnly(left: 28, bottom: 12),
                                  ),
                                  Icon(
                                    Icons.delete,
                                    color: Color(0xffb7b7b7),
                                    size: 15,
                                  ).marginOnly(bottom: 12, left: 3, right: 20)
                                ],
                              ),
                              Container(
                                width: Get.width,
                                decoration: new BoxDecoration(
                                  color: Color(0xff131C3A),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 45,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffBDBDBD)),
                                        // color: Color(0xff1E202B),
                                        // color: Colors.white,

                                        // color: Color.fromRGBO(45, 47, 58, 1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: CommonTextField2(
                                              controller: _.keyWord,
                                              fillcolor:
                                                  CommonColor.appBarColor,
                                              hintText: "Search Topics",
                                              readOnly: true,
                                              onTap: () {
                                                if (_.isContainerShown.value ==
                                                    false) {
                                                  _.isContainerShown.value =
                                                      true;
                                                } else {
                                                  _.isContainerShown.value =
                                                      false;
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //--------------------------Submit and cancel button----------------------
                                    _.isContainerShown.value == true
                                        ? Container(
                                            height: Get.height / 2,
                                            width: Get.width,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  topicListView(_),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.center,
                                                  //   children: [
                                                  //     Container(
                                                  //       //color: CommonColor.loginAndSendCodeButtonColor,
                                                  //       width: 140,
                                                  //       height: 38,
                                                  //       child: MaterialButton(
                                                  //         onPressed: () async {
                                                  //           Get.back();
                                                  //         },
                                                  //         child: Text(
                                                  //           "CANCEL",
                                                  //           textScaleFactor: 1.0,
                                                  //           style: TextStyle(
                                                  //               color: CommonColor
                                                  //                   .cancelButtonColor,
                                                  //               fontSize: 16,
                                                  //               fontWeight:
                                                  //                   FontWeight.w700),
                                                  //         ),
                                                  //         minWidth: Get.width / 3.5,
                                                  //         height: 38,
                                                  //       ),
                                                  //     ).marginOnly(
                                                  //         top: 26, bottom: 15, right: 2),
                                                  //     Container(
                                                  //       //color: CommonColor.loginAndSendCodeButtonColor,
                                                  //       width: 140,
                                                  //       height: 38,
                                                  //       child: MaterialButton(
                                                  //         shape: RoundedRectangleBorder(
                                                  //           borderRadius:
                                                  //               BorderRadius.circular(
                                                  //                   9.0),
                                                  //           side: BorderSide(
                                                  //             color: Color(0xff23B662),
                                                  //           ),
                                                  //         ),
                                                  //         onPressed: () async {},
                                                  //         child: Text(
                                                  //           "SUBMIT",
                                                  //           textScaleFactor: 1.0,
                                                  //           style: TextStyle(
                                                  //               color: Color(0xff2CE08E),
                                                  //               letterSpacing: 0.4,
                                                  //               fontSize: 14.0,
                                                  //               fontWeight:
                                                  //                   FontWeight.w700),
                                                  //           maxLines: 2,
                                                  //         ),
                                                  //         minWidth: Get.width / 3,
                                                  //         height: 40,
                                                  //         // color: Color.fromRGBO(72, 190, 235, 1),
                                                  //         color: Color(0xff23B662)
                                                  //             .withOpacity(0.1),
                                                  //       ),
                                                  //     ).marginOnly(
                                                  //         top: 26, bottom: 15, left: 2),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ).marginOnly(top: 18)
                                        : SizedBox(),
                                  ],
                                ),
                              ).marginOnly(top: 10, right: 5, left: 5),
                              const SizedBox(
                                height: 10.0,
                              ),
                              //--------------------Second search field-------------------
                              // Container(
                              //   height: 45,
                              //   width: Get.width,
                              //   decoration: BoxDecoration(
                              //     border: Border.all(color: Color(0xffBDBDBD)),
                              //     // color: Color(0xff1E202B),
                              //     // color: Colors.white,

                              //     // color: Color.fromRGBO(45, 47, 58, 1),
                              //     borderRadius: BorderRadius.circular(4),
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Flexible(
                              //         child: CommonTextField2(
                              //           controller: _.keyWord,
                              //           fillcolor: CommonColor.appBarColor,
                              //           hintText: "Search Topics",
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              autoCompleteTextField(_),
                            ],
                          ).marginOnly(left: 17, right: 18),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

//--------------------PARENT CHILD CHILD TREE-----------------
  Widget topicListView(SelectKeyWordController _) {
    List<TreeNode> n = [];
    for (int i = 0; i < _.topicList.length; i++)
      n.add(
        TreeNode(
            content: Row(
              children: [
                Theme(
                  child: Obx(() => Checkbox(
                      visualDensity:
                          VisualDensity(horizontal: -3.5, vertical: -2.5),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(
                          width: 1.0, color: CommonColor.filterColor),
                      activeColor: CommonColor.greenColor,
                      focusColor: CommonColor.filterColor,
                      hoverColor: CommonColor.filterColor,
                      value: _.topicList[i].topicCheck.value,
                      onChanged: (val) {
                        _.topicList[i].topicCheck.value = val!;
                        if (_.topicList[i].topicCheck.value == true) {
                          for (int j = 0;
                              j < _.topicList[i].topic2!.length;
                              j++) {
                            _.topicList[i].topic2![j].topicCheck2.value = true;
                            for (int k = 0;
                                k < _.topicList[i].topic2![j].topic3!.length;
                                k++) {
                              _.topicList[i].topic2![j].topic3![k].topicCheck3
                                  .value = true;
                            }
                          }
                        } else {
                          for (int j = 0;
                              j < _.topicList[i].topic2!.length;
                              j++) {
                            _.topicList[i].topic2![j].topicCheck2.value = false;
                            for (int k = 0;
                                k < _.topicList[i].topic2![j].topic3!.length;
                                k++) {
                              _.topicList[i].topic2![j].topic3![k].topicCheck3
                                  .value = false;
                            }
                          }
                        }
                      })),
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '${_.topicList[i].name}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            children: [
              for (int j = 0; j < _.topicList[i].topic2!.length; j++)
                TreeNode(
                    content: Row(
                      children: [
                        Theme(
                          child: Obx(() => Checkbox(
                              visualDensity: VisualDensity(
                                  horizontal: -3.5, vertical: -2.5),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              side: BorderSide(
                                  width: 1.0, color: CommonColor.filterColor),
                              activeColor: CommonColor.greenColor,
                              focusColor: CommonColor.filterColor,
                              hoverColor: CommonColor.filterColor,
                              value:
                                  _.topicList[i].topic2![j].topicCheck2.value,
                              onChanged: (val) {
                                _.topicList[i].topic2![j].topicCheck2.value =
                                    val!;
                                if (_.topicList[i].topic2![j].topicCheck2
                                        .value ==
                                    true) {
                                  _.topicList[i].topicCheck.value = true;
                                  for (int k = 0;
                                      k <
                                          _.topicList[i].topic2![j].topic3!
                                              .length;
                                      k++) {
                                    _.topicList[i].topic2![j].topic3![k]
                                        .topicCheck3.value = true;
                                  }
                                } else {
                                  _.topicList[i].topicCheck.value = false;
                                  for (int k = 0;
                                      k <
                                          _.topicList[i].topic2![j].topic3!
                                              .length;
                                      k++) {
                                    _.topicList[i].topic2![j].topic3![k]
                                        .topicCheck3.value = false;
                                  }
                                }
                              })),
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '${_.topicList[i].topic2![j].name}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    children: [
                      for (int k = 0;
                          k < _.topicList[i].topic2![j].topic3!.length;
                          k++)
                        TreeNode(
                          content: Row(
                            children: [
                              Theme(
                                child: Obx(
                                  () => Checkbox(
                                    visualDensity: VisualDensity(
                                        horizontal: -3.5, vertical: -2.5),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    side: BorderSide(
                                        width: 1.0,
                                        color: CommonColor.filterColor),
                                    activeColor: CommonColor.greenColor,
                                    focusColor: CommonColor.filterColor,
                                    hoverColor: CommonColor.filterColor,
                                    value: _.topicList[i].topic2![j].topic3![k]
                                        .topicCheck3.value,
                                    onChanged: (val) {
                                      _.topicList[i].topic2![j].topic3![k]
                                          .topicCheck3.value = val!;
                                      if (_.topicList[i].topic2![j].topic3![k]
                                              .topicCheck3.value ==
                                          true) {
                                        _.topicList[i].topic2![j].topicCheck2
                                            .value = true;
                                        _.topicList[i].topicCheck.value = true;
                                      } else {
                                        var s = '';
                                        for (int z = 0;
                                            z <
                                                _.topicList[i].topic2![j]
                                                    .topic3!.length;
                                            z++) {
                                          if (_
                                                  .topicList[i]
                                                  .topic2![j]
                                                  .topic3![z]
                                                  .topicCheck3
                                                  .value ==
                                              true) {
                                            s = 'contain';
                                          }
                                        }
                                        if (s == 'contain') {
                                          _.topicList[i].topic2![j].topicCheck2
                                              .value = true;
                                          _.topicList[i].topicCheck.value =
                                              true;
                                        } else {
                                          _.topicList[i].topic2![j].topicCheck2
                                              .value = false;
                                          _.topicList[i].topicCheck.value =
                                              false;
                                        }
                                      }
                                    },
                                  ),
                                ),
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '${_.topicList[i].topic2![j].topic3![k].name}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                    ])
            ]),
      );

    return TreeView(
      treeController: _.treeController,
      nodes: n,
      indent: 10.0,
    );
  }

//<---------------------list of topics---------------->
  Widget returnListOfTopics(SelectKeyWordController _) {
    //print("data in variable " + _.keyWord.text);
    return Obx(
      () => Wrap(
        children: <Widget>[
          for (int index = 0; index < _.topicsList.length; index++)
            FittedBox(
              fit: BoxFit.fill,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: CommonColor.greenColorWithOpacity,
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: CommonColor.greenBorderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${_.topicsList[index]}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w400,
                          color: CommonColor.greenTextColor,
                          fontFamily: "Roboto"),
                    ).marginOnly(left: 10, right: 5),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _.currentindex = index;
                        _.topicsList.removeAt(_.currentindex);
                        print('element removed from index ${_.currentindex}');
                        _.counter++;
                      },
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                            color: CommonColor.greenBorderColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 12.0,
                        ),
                      ).marginOnly(right: 6),
                    )
                  ],
                ).marginOnly(left: 5.0, right: 5.0),
              ).marginAll(5.0),
            ),
          Column(
            children: [
              SizedBox(
                width: 8.0,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () async {
                    print("check");
                    // await _.logout();
                  },
                  child: Text(
                    "View All",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  minWidth: Get.width / 3.5,
                  height: 42,
                ),
              ),
              // Center(
              //   child: MaterialButton(
              //     color: CommonColor.greenColorWithOpacity,
              //     shape: RoundedRectangleBorder(
              //         side: BorderSide(
              //           color: Color(0xff23B662),
              //         ),
              //         borderRadius: BorderRadius.circular(9.0)),
              //     onPressed: () async {
              //       print("check");
              //       // await _.logout();
              //     },
              //     child: Text(
              //       "SUBMIT",
              //       textScaleFactor: 1.0,
              //       style: TextStyle(
              //           color: CommonColor.greenButtonTextColor,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     minWidth: Get.width / 3.5,
              //     height: 42,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     _.urduKeyPressed.value = false;
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: 95,
                  //     decoration: BoxDecoration(
                  //       color: Colors.transparent,
                  //       border: Border.all(color: Color(0xffA9AAAB)),
                  //       borderRadius: BorderRadius.circular(3.0),
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //       "English",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 15.0,
                  //           color: Colors.white),
                  //     )),
                  //   ).marginOnly(top: 80),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _.urduKeyPressed.value = true;
                  //     _.englishKeyPressed.value = false;
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: 95,
                  //     decoration: BoxDecoration(
                  //       color: Colors.transparent,
                  //       border: Border.all(color: Color(0xffA9AAAB)),
                  //       borderRadius: BorderRadius.circular(3.0),
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //       "Urdu",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 15.0,
                  //           color: Colors.white),
                  //     )),
                  //   ).marginOnly(top: 80, left: 4),
                  // ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Color(0xffB7B7B7)),
                    ).marginOnly(top: 80, left: 28, bottom: 12),
                  ),
                  Icon(
                    Icons.delete,
                    color: Color(0xffb7b7b7),
                    size: 15,
                  ).marginOnly(bottom: 12, left: 3)
                ],
              ),
              // Center(
              //   child: MaterialButton(
              //     color: CommonColor.greenColorWithOpacity,
              //     shape: RoundedRectangleBorder(
              //         side: BorderSide(
              //           color: Color(0xff23B662),
              //         ),
              //         borderRadius: BorderRadius.circular(9.0)),
              //     onPressed: () async {
              //       print("check");
              //       // await _.logout();
              //     },
              //     child: Text(
              //       "SUBMIT",
              //       textScaleFactor: 1.0,
              //       style: TextStyle(
              //           color: CommonColor.greenButtonTextColor,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     minWidth: Get.width / 3.5,
              //     height: 42,
              //   ),
              // ).marginOnly(top: 100),
            ],
          ).marginOnly(top: 100.0),

          // Container(
          //   height: 45,
          //   //width: Get.width,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Color(0xffBDBDBD)),
          //     color: Color(0xff1E202B),
          //     // color: Colors.white,
          //
          //     // color: Color.fromRGBO(45, 47, 58, 1),
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   child: Row(
          //     children: [
          //       Flexible(
          //         child: CommonTextField2(
          //           controller: _.keyWord,
          //           hintText: "Search New Keywords",
          //         ),
          //       ),
          //       MaterialButton(
          //         onPressed: () {
          //           if (_.counter.value == 0) {
          //             CustomSnackBar.showSnackBar(
          //                 title:
          //                 "You already added 10 key words",
          //                 message: "",
          //                 backgroundColor:
          //                 CommonColor.snackbarColour,
          //                 isWarning: true);
          //           } else if (_.keyWord.text != '') {
          //             _.keyWordList.add(_.keyWord.text);
          //             _.counter.value--;
          //             if (_.counter.value <= 0) {
          //               _.counter.value = 0;
          //             }
          //           }
          //           _.keyWord.clear();
          //         },
          //         child: Text(
          //           "ADD",
          //           style:
          //           TextStyle(color: Color(0xff23B662)),
          //         ),
          //         color: CommonColor.greenColorWithOpacity,
          //         height: 38,
          //         minWidth: 33,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(9.0),
          //           side: BorderSide(
          //             color: Color(0xff23B662),
          //           ),
          //         ),
          //       ).marginOnly(right: 5, top: 4, bottom: 4),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  //<-----------------------list of keywords----------------->
  Widget returnListOfEnglishKeyWords(SelectKeyWordController _) {
    print("data in variable " + _.keyWord.text);
    print("Lenght of English list is " + _.showListOfWords.length.toString());

    return Obx(
      () => Wrap(
        alignment: _.englishKeyPressed.value == true
            ? WrapAlignment.start
            : WrapAlignment.end,
        children: <Widget>[
          for (int index = 0; index < _.showListOfWords.length; index++)
            FittedBox(
              fit: BoxFit.fill,
              child: Container(
                height: 33,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: CommonColor.greenColorWithOpacity,
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: CommonColor.greenBorderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "${_.showListOfWords[index]}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w400,
                            color: CommonColor.greenTextColor,
                            fontFamily: "Roboto"),
                      ).marginOnly(left: 10, right: 5),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _.keywordsCurrentIndex = index;
                        _.showListOfWords.removeAt(_.keywordsCurrentIndex);
                        print(
                            'element removed from index ${_.keywordsCurrentIndex}');
                        _.keywordsCurrentIndex++;
                      },
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                            color: CommonColor.greenBorderColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 12.0,
                        ),
                      ).marginOnly(right: 6),
                    )
                  ],
                ).marginOnly(left: 5.0, right: 5.0),
              ).marginAll(5.0),
            ),
          Column(
            children: [
              SizedBox(
                width: 8.0,
              ),
              // Center(
              //   child: MaterialButton(
              //     color: CommonColor.greenColorWithOpacity,
              //     shape: RoundedRectangleBorder(
              //         side: BorderSide(
              //           color: Color(0xff23B662),
              //         ),
              //         borderRadius: BorderRadius.circular(9.0)),
              //     onPressed: () async {
              //       print("check");
              //       print("check");
              //       _.allKeyword.clear();
              //       _.update();
              //       _.showListOfUrduWords.forEach((element) {
              //         _.allKeyword.add(element);
              //       });
              //       _.showListOfWords.forEach((e) {
              //         _.allKeyword.add(e);
              //       });
              //       _.update();
              //       _.allDataList.add({
              //         "topics": _.selectedtopicList,
              //         "keyWords": _.allKeyword,
              //       });
              //       _.update();

              //       _.show1();
              //       await _.updatekeyword();
              //     },
              //     child: Text(
              //       "SUBMIT",
              //       textScaleFactor: 1.0,
              //       style: TextStyle(
              //           color: CommonColor.greenButtonTextColor,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     minWidth: Get.width / 3.5,
              //     height: 42,
              //   ).marginOnly(top: 60),
              // ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Container(
              //           height: 40,
              //           width: 95,
              //           decoration: BoxDecoration(
              //             color: Colors.transparent,
              //             border: Border.all(color: Color(0xffA9AAAB)),
              //             borderRadius: BorderRadius.circular(3.0),
              //           ),
              //           child: Center(
              //               child: Text(
              //             "English",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 15.0,
              //                 color: Colors.white),
              //           )),
              //         ).marginOnly(top: 80),
              //         Container(
              //           height: 40,
              //           width: 95,
              //           decoration: BoxDecoration(
              //             color: Colors.transparent,
              //             border: Border.all(color: Color(0xffA9AAAB)),
              //             borderRadius: BorderRadius.circular(3.0),
              //           ),
              //           child: Center(
              //               child: Text(
              //             "Urdu",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 15.0,
              //                 color: Colors.white),
              //           )),
              //         ).marginOnly(top: 80, left: 4),
              //         GestureDetector(
              //           onTap: () {},
              //           child: Text(
              //             "Clear All",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w500,
              //                 fontSize: 12.0,
              //                 color: Color(0xffB7B7B7)),
              //           ).marginOnly(top: 80, left: 28, bottom: 12),
              //         ),
              //         Icon(
              //           Icons.delete,
              //           color: Color(0xffb7b7b7),
              //           size: 15,
              //         ).marginOnly(bottom: 12, left: 3)
              //       ],
              //     ),
              //     // Container(
              //     //   height: 45,
              //     //   width: Get.width,
              //     //   decoration: BoxDecoration(
              //     //     border: Border.all(color: Color(0xffBDBDBD)),
              //     //     // color: Color(0xff1E202B),
              //     //     // color: Colors.white,

              //     //     // color: Color.fromRGBO(45, 47, 58, 1),
              //     //     borderRadius: BorderRadius.circular(4),
              //     //   ),
              //     //   child: Row(
              //     //     children: [
              //     //       Flexible(
              //     //         child: CommonTextField2(
              //     //           controller: _.keyWord,
              //     //           fillcolor: CommonColor.appBarColor,
              //     //           hintText: "Search Topics",
              //     //         ),
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),
              //   ],
              // ).marginOnly(top: 100.0),
              // Container(
              //   height: 45,
              //   //width: Get.width,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Color(0xffBDBDBD)),
              //     // color: Color(0xff1E202B),
              //     // color: Colors.white,

              //     // color: Color.fromRGBO(45, 47, 58, 1),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Row(
              //     children: [
              //       Flexible(
              //         child: CommonTextField2(
              //           controller: _.keyWord,
              //           hintText: "Search New Keywords",
              //           onTap: () {},
              //         ),
              //       ),
              //       MaterialButton(
              //         onPressed: () {
              //           if (_.counter.value == 0) {
              //             CustomSnackBar.showSnackBar(
              //                 title: "You already added 10 key words",
              //                 message: "",
              //                 backgroundColor: CommonColor.snackbarColour,
              //                 isWarning: true);
              //           } else if (_.keyWord.text != '') {
              //             _.keyWordsList.add(_.keyWord.text);
              //             _.counter.value--;
              //             if (_.counter.value <= 0) {
              //               _.counter.value = 0;
              //             }
              //           }
              //           _.keyWord.clear();
              //         },
              //         child: Text(
              //           "ADD",
              //           style: TextStyle(color: Color(0xff23B662)),
              //         ),
              //         color: CommonColor.greenColorWithOpacity,
              //         height: 38,
              //         minWidth: 33,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(9.0),
              //           side: BorderSide(
              //             color: Color(0xff23B662),
              //           ),
              //         ),
              //       ).marginOnly(right: 5, top: 4, bottom: 4),
              //     ],
              //   ),
            ],
          ),
        ],
      ),
    );
  }

  //<-----------------Return List of Urdu Keywords---------------->

  Widget returnListOfUrduKeyWords(SelectKeyWordController _) {
    print("data in variable " + _.keyWord.text);
    print("Lenght of Urdu list is " + _.showListOfUrduWords.length.toString());

    return Obx(
      () => Wrap(
        alignment: _.englishKeyPressed.value == true
            ? WrapAlignment.start
            : WrapAlignment.end,
        children: <Widget>[
          for (int index = 0; index < _.showListOfUrduWords.length; index++)
            FittedBox(
              fit: BoxFit.fill,
              child: Container(
                height: 33,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: CommonColor.greenColorWithOpacity,
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: CommonColor.greenBorderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "${_.showListOfUrduWords[index]}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w400,
                            color: CommonColor.greenTextColor,
                            fontFamily: "Roboto"),
                      ).marginOnly(left: 10, right: 5),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _.keywordsCurrentIndex = index;
                        _.showListOfUrduWords.removeAt(_.keywordsCurrentIndex);
                        print(
                            'element removed from index ${_.keywordsCurrentIndex}');
                        _.keywordsCurrentIndex++;
                      },
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                            color: CommonColor.greenBorderColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 12.0,
                        ),
                      ).marginOnly(right: 6),
                    )
                  ],
                ).marginOnly(left: 5.0, right: 5.0),
              ).marginAll(5.0),
            ),
          Column(
            children: [
              SizedBox(
                width: 8.0,
              ),
              // Center(
              //   child: MaterialButton(
              //     color: CommonColor.greenColorWithOpacity,
              //     shape: RoundedRectangleBorder(
              //         side: BorderSide(
              //           color: Color(0xff23B662),
              //         ),
              //         borderRadius: BorderRadius.circular(9.0)),
              //     onPressed: () async {
              //       // await _.logout();
              //     },
              //     child: Text(
              //       "SUBMIT",
              //       textScaleFactor: 1.0,
              //       style: TextStyle(
              //           color: CommonColor.greenButtonTextColor,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     minWidth: Get.width / 3.5,
              //     height: 42,
              //   ).marginOnly(top: 60),
              // ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Container(
              //           height: 40,
              //           width: 95,
              //           decoration: BoxDecoration(
              //             color: Colors.transparent,
              //             border: Border.all(color: Color(0xffA9AAAB)),
              //             borderRadius: BorderRadius.circular(3.0),
              //           ),
              //           child: Center(
              //               child: Text(
              //             "English",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 15.0,
              //                 color: Colors.white),
              //           )),
              //         ).marginOnly(top: 80),
              //         Container(
              //           height: 40,
              //           width: 95,
              //           decoration: BoxDecoration(
              //             color: Colors.transparent,
              //             border: Border.all(color: Color(0xffA9AAAB)),
              //             borderRadius: BorderRadius.circular(3.0),
              //           ),
              //           child: Center(
              //               child: Text(
              //             "Urdu",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 15.0,
              //                 color: Colors.white),
              //           )),
              //         ).marginOnly(top: 80, left: 4),
              //         GestureDetector(
              //           onTap: () {},
              //           child: Text(
              //             "Clear All",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w500,
              //                 fontSize: 12.0,
              //                 color: Color(0xffB7B7B7)),
              //           ).marginOnly(top: 80, left: 28, bottom: 12),
              //         ),
              //         Icon(
              //           Icons.delete,
              //           color: Color(0xffb7b7b7),
              //           size: 15,
              //         ).marginOnly(bottom: 12, left: 3)
              //       ],
              //     ),
              //     // Container(
              //     //   height: 45,
              //     //   width: Get.width,
              //     //   decoration: BoxDecoration(
              //     //     border: Border.all(color: Color(0xffBDBDBD)),
              //     //     // color: Color(0xff1E202B),
              //     //     // color: Colors.white,

              //     //     // color: Color.fromRGBO(45, 47, 58, 1),
              //     //     borderRadius: BorderRadius.circular(4),
              //     //   ),
              //     //   child: Row(
              //     //     children: [
              //     //       Flexible(
              //     //         child: CommonTextField2(
              //     //           controller: _.keyWord,
              //     //           fillcolor: CommonColor.appBarColor,
              //     //           hintText: "Search Topics",
              //     //         ),
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),
              //   ],
              // ).marginOnly(top: 100.0),
              // Container(
              //   height: 45,
              //   //width: Get.width,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Color(0xffBDBDBD)),
              //     // color: Color(0xff1E202B),
              //     // color: Colors.white,

              //     // color: Color.fromRGBO(45, 47, 58, 1),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Row(
              //     children: [
              //       Flexible(
              //         child: CommonTextField2(
              //           controller: _.keyWord,
              //           hintText: "Search New Keywords",
              //           onTap: () {},
              //         ),
              //       ),
              //       MaterialButton(
              //         onPressed: () {
              //           if (_.counter.value == 0) {
              //             CustomSnackBar.showSnackBar(
              //                 title: "You already added 10 key words",
              //                 message: "",
              //                 backgroundColor: CommonColor.snackbarColour,
              //                 isWarning: true);
              //           } else if (_.keyWord.text != '') {
              //             _.keyWordsList.add(_.keyWord.text);
              //             _.counter.value--;
              //             if (_.counter.value <= 0) {
              //               _.counter.value = 0;
              //             }
              //           }
              //           _.keyWord.clear();
              //         },
              //         child: Text(
              //           "ADD",
              //           style: TextStyle(color: Color(0xff23B662)),
              //         ),
              //         color: CommonColor.greenColorWithOpacity,
              //         height: 38,
              //         minWidth: 33,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(9.0),
              //           side: BorderSide(
              //             color: Color(0xff23B662),
              //           ),
              //         ),
              //       ).marginOnly(right: 5, top: 4, bottom: 4),
              //     ],
              //   ),
            ],
          ),
        ],
      ),
    );
  }

//------------------------Auto complete text field code-------------

  Widget autoCompleteTextField(SelectKeyWordController _) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    List<String> listOfSuggestedKeyWords = ["Hello", "World"];
    return Obx(() {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                color: CommonColor.greenColorWithOpacity,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0xff23B662),
                    ),
                    borderRadius: BorderRadius.circular(9.0)),
                onPressed: () async {
                  _.selectedtopicList.clear();
                  for (int i = 0; i < _.topicList.length; i++) {
                    if (_.topicList[i].topicCheck.value == true) {
                      List a = [];
                      List b = [];
                      for (int j = 0; j < _.topicList[i].topic2!.length; j++) {
                        if (_.topicList[i].topic2![j].topicCheck2.value ==
                            true) {
                          a.add(_.topicList[i].topic2![j].name.toString());

                          for (int k = 0;
                              k < _.topicList[i].topic2![j].topic3!.length;
                              k++) {
                            if (_.topicList[i].topic2![j].topic3![k].topicCheck3
                                    .value ==
                                true) {
                              b.add(_.topicList[i].topic2![j].topic3![k].name
                                  .toString());
                            }
                          }
                        }
                      }
                      _.addDataToList(_.topicList[i].name!, a, b);
                    }
                  }
                  _.show();
                  _.updateTopic();
                },
                child: Text(
                  "SUBMIT",
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      color: CommonColor.greenButtonTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                minWidth: Get.width / 3.5,
                height: 42,
              ).marginOnly(top: 60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _.englishKeyPressed.value = true;
                    _.urduKeyPressed.value = false;
                  },
                  child: Container(
                    height: 40,
                    width: 95,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: _.englishKeyPressed.value == true
                          ? Border.all(color: Color(0xffA9AAAB))
                          : Border.all(
                              color: Color(0xffa9aaab).withOpacity(0.46),
                            ),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Center(
                        child: Text(
                      "English",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                          color: Colors.white),
                    )),
                  ).marginOnly(top: 80),
                ),
                GestureDetector(
                  onTap: () {
                    _.urduKeyPressed.value = true;
                    _.englishKeyPressed.value = false;
                  },
                  child: Container(
                    height: 40,
                    width: 95,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: _.urduKeyPressed.value == true
                          ? Border.all(color: Colors.white)
                          : Border.all(
                              color: Color(0xffa9aaab).withOpacity(0.46),
                            ),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Center(
                        child: Text(
                      "Urdu",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                          color: Colors.white),
                    )),
                  ).marginOnly(top: 80, left: 4),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: Color(0xffB7B7B7)),
                  ).marginOnly(top: 80, left: 28, bottom: 12),
                ),
                Icon(
                  Icons.delete,
                  color: Color(0xffb7b7b7),
                  size: 15,
                ).marginOnly(bottom: 12, left: 3)
              ],
            ),

            //<-------------------------------Suggestion box text field for English----------------->
            _.englishKeyPressed.value == true
                ? Container(
                    height: 42,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffBDBDBD)),
                      // color: Colors.white,
                      color: Colors.transparent,

                      // color: Color.fromRGBO(45, 47, 58, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: TypeAheadFormField(
                            hideKeyboard: true,
                            // suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            //     constraints: BoxConstraints(
                            //   maxWidth: Get.width,
                            // )),

                            textFieldConfiguration: TextFieldConfiguration(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xff22B161),
                                  size: 25,
                                ),
                                suffixIcon: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          if (_.keywordsCounter.value == 0) {
                                            CustomSnackBar.showSnackBar(
                                                title:
                                                    "You already added 10 key words",
                                                message: "",
                                                backgroundColor:
                                                    CommonColor.snackbarColour,
                                                isWarning: true);
                                          } else if (_.addKeyWord.text != '') {
                                            _.showListOfWords
                                                .add(_.addKeyWord.text);
                                            _.keywordsCounter.value--;
                                            if (_.keywordsCounter.value <= 0) {
                                              _.keywordsCounter.value = 0;
                                            }
                                          }
                                          _.addKeyWord.clear();
                                        },
                                        child: Text(
                                          "ADD",
                                          style: TextStyle(
                                              color: CommonColor
                                                  .greenButtonTextColor),
                                        ),
                                        color:
                                            CommonColor.greenColorWithOpacity,
                                        height: 38,
                                        minWidth: 33,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                          side: BorderSide(
                                            color: Color(0xff23B662),
                                          ),
                                        ),
                                      ).marginOnly(
                                          right: 5, top: 4, bottom: 4, left: 5),
                                      Text(
                                        '(${_.keywordsCounter})',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            letterSpacing: 0.7),
                                      ).marginOnly(right: 6),
                                    ],
                                  ),
                                ),
                                hintText: 'Search New Keywords',
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 10),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  //borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              controller: _.addKeyWord,
                            ),
                            suggestionsCallback: (pattern) => _.listOfQueryWords
                                .where((element) => element
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase())),
                            itemBuilder: (context, String element) => Container(
                              color: Color(0xff455177),
                              child: ListTile(
                                title: Text(element),
                              ),
                            ),
                            // transitionBuilder: (context, suggestionsBox, controller) {
                            //   return suggestionsBox;
                            // },
                            onSuggestionSelected: (String val) {
                              _.addKeyWord.text = val;
                              print(val);
                            },
                            getImmediateSuggestions: true,
                            hideSuggestionsOnKeyboardHide: true,
                            hideOnEmpty: false,
                            noItemsFoundBuilder: (context) => Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No item found"),
                            ),

                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please select a city';
                            //   }
                            // },
                            // onSaved: (value) => this._selectedCity = value,
                          ),
                        ),

                        //<------------Keywords Counter for English---------------
                        // Text(
                        //   '(${_.keywordsCounter})',
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //       letterSpacing: 0.7),
                        // ).marginOnly(right: 6),

                        //<---------------Add button for english side -------------------
                        // MaterialButton(
                        //   onPressed: () {
                        //     if (_.keywordsCounter.value == 0) {
                        //       CustomSnackBar.showSnackBar(
                        //           title: "You already added 10 key words",
                        //           message: "",
                        //           backgroundColor: CommonColor.snackbarColour,
                        //           isWarning: true);
                        //     } else if (_.addKeyWord.text != '') {
                        //       _.showListOfWords.add(_.addKeyWord.text);
                        //       _.keywordsCounter.value--;
                        //       if (_.keywordsCounter.value <= 0) {
                        //         _.keywordsCounter.value = 0;
                        //       }
                        //     }
                        //     _.addKeyWord.clear();
                        //   },
                        //   child: Text(
                        //     "ADD",
                        //     style: TextStyle(
                        //         color: CommonColor.greenButtonTextColor),
                        //   ),
                        //   color: CommonColor.greenColorWithOpacity,
                        //   height: 38,
                        //   minWidth: 33,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(9.0),
                        //     side: BorderSide(
                        //       color: Color(0xff23B662),
                        //     ),
                        //   ),
                        // ).marginOnly(right: 5, top: 4, bottom: 4),
                      ],
                    ),
                  )
                //<-----------------------Urdu KeyWords Direction chanage check----------------
                : Container(
                    height: 42,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffBDBDBD)),
                      color: Colors.transparent,
                      // color: Colors.white,

                      // color: Color.fromRGBO(45, 47, 58, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        // MaterialButton(
                        //   onPressed: () {
                        //     if (_.keywordsCounter.value == 0) {
                        //       CustomSnackBar.showSnackBar(
                        //           title: "You already added 10 key words",
                        //           message: "",
                        //           backgroundColor: CommonColor.snackbarColour,
                        //           isWarning: true);
                        //     } else if (_.addKeyWord.text != '') {
                        //       _.showListOfWords.add(_.addKeyWord.text);
                        //       _.keywordsCounter.value--;
                        //       if (_.keywordsCounter.value <= 0) {
                        //         _.keywordsCounter.value = 0;
                        //       }
                        //     }
                        //     _.addKeyWord.clear();
                        //   },
                        //   child: Text(
                        //     "ADD",
                        //     style: TextStyle(
                        //         color: CommonColor.greenButtonTextColor),
                        //   ),
                        //   color: CommonColor.greenColorWithOpacity,
                        //   height: 38,
                        //   minWidth: 33,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(9.0),
                        //     side: BorderSide(
                        //       color: Color(0xff23B662),
                        //     ),
                        //   ),
                        // ).marginOnly(right: 5, top: 4, bottom: 4, left: 5),
                        // Text(
                        //   '(${_.keywordsCounter})',
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //       letterSpacing: 0.7),
                        // ).marginOnly(right: 6),
                        Flexible(
                          child: TypeAheadFormField(
                            autoFlipDirection: true,
                            direction: AxisDirection.down,
                            hideKeyboard: false,

                            textFieldConfiguration: TextFieldConfiguration(
                              style: TextStyle(color: Colors.white),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: 'نئے مطلوبہ الفاظ تلاش کریں',
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: CommonColor.greenColor,
                                  size: 25,
                                ),
                                prefixIcon: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          if (_.keywordsCounter.value == 0) {
                                            CustomSnackBar.showSnackBar(
                                                title:
                                                    "You already added 10 key words",
                                                message: "",
                                                backgroundColor:
                                                    CommonColor.snackbarColour,
                                                isWarning: true);
                                          } else if (_.addKeyWord.text != '') {
                                            _.showListOfUrduWords
                                                .add(_.addKeyWord.text);
                                            _.keywordsCounter.value--;
                                            if (_.keywordsCounter.value <= 0) {
                                              _.keywordsCounter.value = 0;
                                            }
                                          }
                                          _.addKeyWord.clear();
                                        },
                                        child: Text(
                                          "ADD",
                                          style: TextStyle(
                                              color: CommonColor
                                                  .greenButtonTextColor),
                                        ),
                                        color:
                                            CommonColor.greenColorWithOpacity,
                                        height: 38,
                                        minWidth: 33,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                          side: BorderSide(
                                            color: Color(0xff23B662),
                                          ),
                                        ),
                                      ).marginOnly(
                                          right: 5, top: 4, bottom: 4, left: 5),
                                      Text(
                                        '(${_.keywordsCounter})',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            letterSpacing: 0.7),
                                      ).marginOnly(right: 6),
                                    ],
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 10),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  //borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              controller: _.addKeyWord,
                            ),
                            suggestionsCallback: (pattern) => _.urduQueryWords
                                .where((element) => element
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase())),
                            itemBuilder: (context, String element) => Container(
                              color: Color(0xff455177),
                              child: ListTile(
                                title: Text(
                                  element,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            // transitionBuilder: (context, suggestionsBox, controller) {
                            //   return suggestionsBox;
                            // },
                            onSuggestionSelected: (String val) {
                              _.addKeyWord.text = val;
                              print(val);
                            },
                            getImmediateSuggestions: true,
                            hideSuggestionsOnKeyboardHide: true,
                            hideOnEmpty: false,
                            noItemsFoundBuilder: (context) => Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No item found"),
                            ),

                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please select a city';
                            //   }
                            // },
                            // onSaved: (value) => this._selectedCity = value,
                          ),
                        ),
                      ],
                    ),
                  ),
            _.englishKeyPressed.value == true
                ? Container(
                        height: Get.height / 2,
                        width: Get.width,
                        child: returnListOfEnglishKeyWords(_))
                    .marginOnly(top: 10)
                : Container(
                        height: Get.height / 2,
                        width: Get.width,
                        child: returnListOfUrduKeyWords(_))
                    .marginOnly(top: 10),
          ],
        ),
      );
    });
  }
}
