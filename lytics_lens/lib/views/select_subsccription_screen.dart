import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';
import '../Constants/common_color.dart';
import '../Controllers/select_subscription_controller.dart';
import 'Components/widget/common_textfield.dart';
import 'package:change_case/change_case.dart';

class SelectSubscriptionScreen extends StatelessWidget {
  const SelectSubscriptionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(context),
      appBar: AppBar(
        backgroundColor: CommonColor.backgroundColour,
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Subscription",
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                letterSpacing: 0.4,
              ),
            )),
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_backspace_rounded,
          ).marginOnly(left: 26, right: 13),
        ),
      ),
    );
  }

  Widget bodyData(context) {
    return GetBuilder<SelectSubscriptionController>(
        init: SelectSubscriptionController(),
        builder: (_) {
          return Obx(() => Container(
              height: Get.height,
              width: Get.width,
              color: CommonColor.backgroundColour,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 45,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: CommonColor.greenColorWithOpacity,
                        borderRadius: BorderRadius.circular(4.0),
                        border:
                            Border.all(color: CommonColor.textFieldBorderColor),
                      ),
                      child: CommonTextField2(
                        controller: _.controller,
                        hintText: "Select Information Type",
                        readOnly: true,
                        onTap: () {
                          if (_.isShownContaine.value == true) {
                            _.isShownContaine.value = false;
                            print("value of container is " +
                                _.isShownContaine.value.toString());
                          } else {
                            _.isShownContaine.value = true;
                            print("value of container is " +
                                _.isShownContaine.value.toString());
                          }
                        },
                      ),
                    ).marginOnly(top: 50),
                    _.isShownContaine.value == true
                        ? Container(
                            height: Get.height / 2,
                            width: Get.width,
                            color: CommonColor.textFieldBackgrounfColour,
                            child: ListView(
                              children: [
                                topicListView(_).marginOnly(
                                  top: 10,
                                ),
                              ],
                            ))
                        : SizedBox(),
                    Container(
                      child: Text(
                        "Intelligence",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ).marginOnly(top: 20, left: 15),
                    Container(
                      child: Text(
                        "Select atleast one option",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ).marginOnly(top: 6, left: 15, bottom: 16),
                    showIntelligence(_).marginOnly(left: 15),
                    Container(
                      child: Text(
                        "Report Timing",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ).marginOnly(top: 30, left: 15),
                    Container(
                      child: Text(
                        "Select atleast one option",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ).marginOnly(top: 6, left: 15, bottom: 16),
                    showReportTimming(_).marginOnly(
                      left: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        //color: CommonColor.loginAndSendCodeButtonColor,
                        width: 162,
                        height: 48,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            side: BorderSide(
                              color: Color(0xff23B662),
                            ),
                          ),

                          onPressed: () async {
                            List c = [];
                            _.subscriptionSelectList.clear();
                            c.clear();
                            for (int i = 0;
                                i < _.subscriptionList.length;
                                i++) {
                              _.key = '';

                              if (_.subscriptionList[i].check.value == true) {
                                _.key = _.subscriptionList[i].source!;

                                for (int j = 0;
                                    j <
                                        _.subscriptionList[i].sourceValue!
                                            .length;
                                    j++) {
                                  if (_.subscriptionList[i].sourceValue![j]
                                          .check1.value ==
                                      true) {
                                    c.add(_.subscriptionList[i].sourceValue![j]
                                        .sValues);
                                  }
                                  _.update();
                                  _.addDataInList(_.key, c);
                                }

                                // _.subscriptionSelectList.add({'${_.key}': c});
                              }
                            }
                            _.show();
                            _.sendData();
                          },
                          child: Text(
                            "SUBMIT",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: Color(0xff2CE08E),
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
                      ).marginOnly(top: 26, bottom: 15),
                    ),
                  ],
                ).marginOnly(left: 20, right: 15),
              )));
        });
  }

// ------------------- Intelligence Part ----------------------
  Widget showIntelligence(SelectSubscriptionController _) {
    print("check ${_.intelligence.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.intelligence.length; i++) {
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: GestureDetector(
          onTap: () {
            if (_.intelligence[i]['check'] == false) {
              _.intelligence[i]['check'] = true;

              _.filterlist.add(_.intelligence[i]['name']);
              _.update();
            } else {
              _.intelligence[i]['check'] = false;
              _.filterlist
                  .removeWhere((item) => item == _.intelligence[i]['name']);
              _.update();
            }
          },
          child: Container(
            height: 40,
            //width: _.alltopic[i]['name'] == "Speaker Recognition" ? 155 : 110,
            decoration: BoxDecoration(
              color: _.intelligence[i]['check'] == false
                  ? Colors.transparent
                  : Color(0xff22B161),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: _.intelligence[i]['check'] == false
                    ? Color(0xffADADAD)
                    : Color(0xff22B161),
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                "${_.intelligence[i]['name']}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Roboto',
                    fontWeight: _.intelligence[i]['check'] == true
                        ? FontWeight.w500
                        : FontWeight.w300,
                    color: _.intelligence[i]['check'] == true
                        ? Color(0xffFFFFFF)
                        : Color(0xffCACACA)),
              ).marginOnly(left: 15, right: 10),
            ),
          ),
        ),
      ).marginOnly(bottom: 17, right: 13));
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }

// ---------------------- Report Timing ---------------------
  Widget showReportTimming(SelectSubscriptionController _) {
    print("check ${_.reportTiming.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.reportTiming.length; i++) {
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: GestureDetector(
          onTap: () {
            _.reportTiming.forEach((e) {
              e['check'] = false;
            });
            if (_.reportTiming[i]['check'] == false) {
              _.reportTiming[i]['check'] = true;
              _.reportTimeController.text = _.reportTiming[i]['min'];
              _.update();
            } else {
              _.reportTiming[i]['check'] = false;
              _.update();
            }
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: _.reportTiming[i]['check'] == false
                  ? Colors.transparent
                  : Color(0xff22B161),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: _.reportTiming[i]['check'] == false
                    ? Color(0xffADADAD)
                    : Color(0xff22B161),
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                "${_.reportTiming[i]['timming']}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Roboto',
                    fontWeight: _.reportTiming[i]['check'] == true
                        ? FontWeight.w500
                        : FontWeight.w300,
                    color: _.reportTiming[i]['check'] == true
                        ? Color(0xffFFFFFF)
                        : Color(0xffCACACA)),
              ),
            ),
          ),
        ),
      ).marginOnly(bottom: 17, right: 11));
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }

  Widget topicListView(SelectSubscriptionController _) {
    List<TreeNode> n = [];
    for (int i = 0; i < _.subscriptionList.length; i++)
      n.add(
        TreeNode(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  child: Obx(
                    () => Checkbox(
                      tristate: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.0))),
                      visualDensity:
                          VisualDensity(horizontal: -3.5, vertical: -2.5),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(width: 1.0, color: Colors.white),
                      activeColor: CommonColor.greenColor,
                      focusColor: CommonColor.filterColor,
                      hoverColor: CommonColor.filterColor,
                      value: _.subscriptionList[i].check.value,
                      onChanged: (val) {
                        _.subscriptionList[i].check.value =
                            !_.subscriptionList[i].check.value;
                        if (_.subscriptionList[i].check.value == true) {
                          for (int j = 0;
                              j < _.subscriptionList[i].sourceValue!.length;
                              j++) {
                            _.subscriptionList[i].sourceValue![j].check1.value =
                                true;
                          }
                        } else {
                          for (int j = 0;
                              j < _.subscriptionList[i].sourceValue!.length;
                              j++) {
                            _.subscriptionList[i].sourceValue![j].check1.value =
                                false;
                          }
                        }
                      },
                    ),
                  ),
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                ),
                SizedBox(
                  width: 28.0,
                ),
                Text(
                  '${_.subscriptionList[i].source}'.toUpperFirstCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ],
            ),
            children: [
              for (int j = 0;
                  j < _.subscriptionList[i].sourceValue!.length;
                  j++)
                TreeNode(
                    content: Row(
                  children: [
                    Theme(
                      child: Obx(
                        () => Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.0),
                            ),
                          ),
                          visualDensity:
                              VisualDensity(horizontal: -3.5, vertical: -2.5),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          side: BorderSide(width: 1.0, color: Colors.white),
                          activeColor: CommonColor.greenColor,
                          focusColor: CommonColor.filterColor,
                          hoverColor: CommonColor.filterColor,
                          value: _
                              .subscriptionList[i].sourceValue![j].check1.value,
                          onChanged: (val) {
                            _.subscriptionList[i].sourceValue![j].check1.value =
                                !_.subscriptionList[i].sourceValue![j].check1
                                    .value;
                            if (_.subscriptionList[i].sourceValue![j].check1
                                    .value ==
                                true) {
                              _.subscriptionList[i].check.value = true;
                            } else {
                              var s = '';
                              for (int k = 0;
                                  k < _.subscriptionList[i].sourceValue!.length;
                                  k++) {
                                if (_.subscriptionList[i].sourceValue![k].check1
                                        .value ==
                                    true) {
                                  s = 'contain';
                                }
                              }

                              print("Value for Check Box $s");
                              if (s == 'contain') {
                                _.subscriptionList[i].check.value = true;
                              } else {
                                _.subscriptionList[i].check.value = false;
                              }
                            }
                          },
                        ),
                      ),
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${_.subscriptionList[i].sourceValue![j].sValues}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ],
                ))
            ]),
      );

    return TreeView(
      treeController: _.treeController,
      nodes: n,
      indent: 30,
    );
  }
}
