import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Controllers/perefrences_page_controller.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(context),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Topics",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            )),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_backspace_rounded,
          ).marginOnly(left: 34),
        ),
      ),
    );
  }

  Widget bodyData(context) {
    return GetBuilder<PreferencesPageController>(
        init: PreferencesPageController(),
        builder: (_) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
              Color(0xff1b1d28).withOpacity(.95),
              Color(0xff1b1d28),
            ])),
            child: program(_),

            // Column(
            //   children: [
            //     //list body
            //     Expanded(
            //       child: RawScrollbar(
            //         radius: Radius.circular(5),
            //         thickness: 4,
            //         thumbColor: Color(0xff48BEEB),
            //         child: ListView.separated(
            //             separatorBuilder: (context, index) => Padding(
            //                   padding: EdgeInsets.only(bottom: 9),
            //                 ),
            //             itemCount: _.topic.length,
            //             itemBuilder: (c, i) {
            //               return Column(
            //                 children: [
            //                   InkWell(
            //                     onTap: () {
            //                       if (_.topic[i]['check'] == false) {
            //                         _.topic[i]['check'] = true;
            //                         _.update();
            //                       } else {
            //                         _.topic[i]['check'] = false;
            //                         _.update();
            //                       }
            //                       _.currentindex = i;

            //                       _.update();
            //                     },
            //                     child: Container(
            //                         height: 40,
            //                         decoration: BoxDecoration(
            //                             color: _.currentindex == i
            //                                 ? Color(0xff48BEEB)
            //                                 : Color(0xff1b1d28),
            //                             border: Border.all(
            //                                 color: _.currentindex == i
            //                                     ? Color(0xff48BEEB)
            //                                     : Color(0xffBDBDBD),
            //                                 width: 1),
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(4))),
            //                         child: Center(
            //                           child: Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             children: [
            //                               Text('${_.topic[i]['name']}',
            //                                   style: TextStyle(
            //                                     fontSize: 16,
            //                                     fontFamily: 'Roboto',
            //                                     fontWeight: FontWeight.w400,
            //                                     color: Colors.white,
            //                                   )),
            //                               Spacer(),
            //                               Icon(
            //                                 Icons.expand_more,
            //                                 size: 18,
            //                                 color: _.currentindex == i
            //                                     ? Colors.white
            //                                     : Color(0xffCCCCCC),
            //                               ).marginOnly(right: 15)
            //                             ],
            //                           ).marginOnly(
            //                             left: 60,
            //                           ),
            //                         )).marginSymmetric(horizontal: 20),
            //                   ),
            //                   SizedBox(
            //                     height: 1,
            //                   ),
            //                   _.currentindex == i
            //                       ? Container(
            //                           height: _.currentindex == i ? 300 : 160,
            //                           decoration: BoxDecoration(
            //                               color: Color(0xff4F505B)),
            //                           child: RawScrollbar(
            //                             radius: Radius.circular(5),
            //                             thickness: 4,
            //                             thumbColor: Color(0xff48BEEB),
            //                             child: ListView.separated(
            //                               separatorBuilder: (context, index) =>
            //                                   Container(
            //                                       height: 1,
            //                                       color: Colors.white),
            //                               itemCount: _.subtopics.length,
            //                               itemBuilder: (context, index) =>
            //                                   Column(
            //                                 children: [
            //                                   InkWell(
            //                                           onTap: () {
            //                                             _.topic[_.currentindex]
            //                                                 ['check'] = false;

            //                                             _.index = index;
            //                                             _.update();
            //                                           },
            //                                           child: Container(
            //                                             height: 30,
            //                                             child: Row(
            //                                               children: [
            //                                                 Text(
            //                                                     '${_.subtopics[index]['name']}',
            //                                                     style: TextStyle(
            //                                                         fontSize:
            //                                                             13,
            //                                                         fontWeight:
            //                                                             FontWeight
            //                                                                 .w500,
            //                                                         color: _.index ==
            //                                                                 index
            //                                                             ? Color(
            //                                                                 0xff48BEEB)
            //                                                             : Colors
            //                                                                 .white)),
            //                                                 Spacer(),
            //                                                 IconButton(
            //                                                     onPressed:
            //                                                         () {},
            //                                                     icon: Icon(
            //                                                       Icons
            //                                                           .expand_more,
            //                                                       size: 18,
            //                                                       color: Color(
            //                                                           0xffCCCCCC),
            //                                                     )),
            //                                               ],
            //                                             ),
            //                                           ))
            //                                       .marginOnly(
            //                                           left: 60,
            //                                           top: 3,
            //                                           bottom: 3),
            //                                   _.index == index
            //                                       ? Column(
            //                                           children: [
            //                                             Container(
            //                                               height: 200,
            //                                               color:
            //                                                   Color(0xff8B8C9E),
            //                                               child: RawScrollbar(
            //                                                   thumbColor: Color(
            //                                                       0xff48BEEB),
            //                                                   child:
            //                                                       showChannels(
            //                                                           _)),
            //                                             ),
            //                                             Container(
            //                                               color:
            //                                                   Color(0xff8B8C9E),
            //                                               child: Row(
            //                                                 mainAxisAlignment:
            //                                                     MainAxisAlignment
            //                                                         .center,
            //                                                 children: [
            //                                                   Container(
            //                                                     height: 40,
            //                                                     width: 71,
            //                                                     decoration:
            //                                                         BoxDecoration(
            //                                                       color: Color(
            //                                                           0xff6F707E),
            //                                                       borderRadius:
            //                                                           BorderRadius
            //                                                               .all(
            //                                                         Radius
            //                                                             .circular(
            //                                                                 5.0),
            //                                                       ),
            //                                                     ),
            //                                                     child: Center(
            //                                                       child: Text(
            //                                                         'CANCEL',
            //                                                         style: TextStyle(
            //                                                             fontSize:
            //                                                                 13,
            //                                                             fontWeight:
            //                                                                 FontWeight
            //                                                                     .w700,
            //                                                             color: Colors
            //                                                                 .white),
            //                                                       ),
            //                                                     ),
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 10,
            //                                                   ),
            //                                                   InkWell(
            //                                                     onTap: () {},
            //                                                     child:
            //                                                         Container(
            //                                                       height: 40,
            //                                                       width: 71,
            //                                                       decoration:
            //                                                           BoxDecoration(
            //                                                         color: Color(
            //                                                             0xff48BEEB),
            //                                                         borderRadius:
            //                                                             BorderRadius
            //                                                                 .all(
            //                                                           Radius.circular(
            //                                                               5.0),
            //                                                         ),
            //                                                       ),
            //                                                       child: Center(
            //                                                         child: Text(
            //                                                           'SUBMIT',
            //                                                           style: TextStyle(
            //                                                               fontSize:
            //                                                                   13,
            //                                                               fontWeight: FontWeight
            //                                                                   .w700,
            //                                                               color:
            //                                                                   Colors.white),
            //                                                         ),
            //                                                       ),
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ).marginSymmetric(
            //                                                   vertical: 6),
            //                                             )
            //                                           ],
            //                                         )
            //                                       : Container(),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ).marginOnly(
            //                           left: 20, right: 20, bottom: 20)
            //                       : Container(),
            //                 ],
            //               );
            //             }),
            //       ),
            //     ),
            //   ],
            // ),
          );
        });
  }

  Widget showChannels(PreferencesPageController _) {
    print("check ${_.subtopics1.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.subtopics1.length; i++) {
      g.add(GestureDetector(
        onTap: () {
          if (_.subtopics1[i]['check'] == false) {
            _.subtopics1[i]['check'] = true;
            _.update();
          } else {
            _.subtopics1[i]['check'] = false;
            _.update();
          }
        },
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: _.subtopics1[i]['check'] == false
                ? Color(0xff8B8C9E)
                : Color(0xff48BEEB),
            border: Border.all(
              color: _.subtopics1[i]['check'] == false
                  ? Color(0xff8B8C9E)
                  : Color(0xff48BEEB),
              width: 1.0,
            ),
          ),
          child: Text(
            "${_.subtopics1[i]['name']}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                color: Colors.white),
          ).marginOnly(left: 60, top: 7),
        ),
      ).marginOnly(
        bottom: 00.5,
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: g,
    );
  }

  Widget program(PreferencesPageController _) {
    print("check ${_.programType.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.programType.length; i++) {
      g.add(
        Theme(
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      if (_.programType[i].onTapcheck.value == false) {
                        _.programType[i].onTapcheck.value = true;
                        _.update();
                      } else {
                        _.programType[i].onTapcheck.value = false;
                        _.update();
                      }
                    },
                    child: _.programType[i].onTapcheck.value == false
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Polygon2.png'))),
                              ),
                              Container(
                                  height: 160,
                                  child: showDates1(_).marginOnly())
                            ],
                          )
                        : Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/polygon.png'))),
                          )),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity:
                      VisualDensity(horizontal: -3.5, vertical: -3.5),
                  side: BorderSide(color: Color(0xffFFFFFF)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  activeColor: Color(0xff22B161),
                  value: _.programType[i].check.value,
                  onChanged: (val) {
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
                    _.filterProgramType.length == 0
                        ? _.programcheckvalue.value = false
                        : _.programcheckvalue.value = true;
                    _.update();
                  },
                ),
                Text(
                  "${_.programType[i].name}",
                  textAlign: TextAlign.left,
                  //overflow: TextOverflow.ellipsis,
                  // maxLines: 1,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.4,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          data: ThemeData(unselectedWidgetColor: Colors.white),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: g,
    );
  }

  Widget showDates1(PreferencesPageController _) {
    print("check dates ${_.alldatelist1.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.alldatelist1.length; i++) {
      g.add(
        Theme(
          child: Obx(
            () => Row(
              children: [
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity:
                      VisualDensity(horizontal: -3.5, vertical: -3.5),
                  side: BorderSide(color: Color(0xffFFFFFF)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  activeColor: Color(0xff22B161),
                  value: _.alldatelist1[i].check.value,
                  onChanged: (val) {
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
                      _.filterlist1.removeWhere(
                          (i) => i.toString().substring(0, 2) == '20');
                      _.filterlist1.add(
                          '${_.alldatelist1[i].endDate} - ${_.alldatelist1[i].startDate}');
                      _.update();
                      print('Start Date is ${_.startSearchDate.text}');
                    }
                    _.filterlist1.length == 0
                        ? _.datecheckvalue.value = false
                        : _.datecheckvalue.value = true;
                    _.update();
                  },
                ),
                Text(
                  "${_.alldatelist1[i].name}",
                  //overflow: TextOverflow.ellipsis,
                  // maxLines: 1,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.4,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          data: ThemeData(unselectedWidgetColor: Colors.white),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: g,
    );
  }

  Widget showmaintopics(PreferencesPageController _) {
    print("check ${_.topic.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.topic.length; i++) {
      g.add(
        InkWell(
          onTap: () {
            if (_.topic[i]['check'] == false) {
              _.topic[i]['check'] = true;
              _.update();
            } else {
              _.topic[i]['check'] = false;
              _.update();
            }
            _.currentindex = i;

            _.update();
          },
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: _.currentindex == i
                      ? Color(0xff48BEEB)
                      : Color(0xff1b1d28),
                  border: Border.all(
                      color: _.currentindex == i
                          ? Color(0xff48BEEB)
                          : Color(0xffBDBDBD),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_.topic[i]['name']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )),
                    Spacer(),
                    Icon(
                      Icons.expand_more,
                      size: 18,
                      color: _.currentindex == i
                          ? Colors.white
                          : Color(0xffCCCCCC),
                    ).marginOnly(right: 15)
                  ],
                ).marginOnly(
                  left: 60,
                ),
              )).marginSymmetric(horizontal: 20),
        ),
      );
    }

    return ListView(shrinkWrap: true, children: g);
  }
}
