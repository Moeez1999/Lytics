import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Controllers/change_subscription_2_controller.dart';
import 'package:lytics_lens/views/Components/widget/common_textfield.dart';

class ChangeSubscription2 extends StatelessWidget {
  const ChangeSubscription2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Subscription",
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
      body: bodyData(context),
    );
  }

  Widget bodyData(BuildContext context) {
    return GetBuilder<ChangeSubscription2Controller>(
        init: ChangeSubscription2Controller(),
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                Color(0xff1b1d28).withOpacity(.95),
                Color(0xff1b1d28),
              ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Text(
                        'App and Portal Logins',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Spacer(),
                      Container(
                        height: 21,
                        width: 21,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff48BEEB),
                            image: DecorationImage(
                                image: AssetImage('assets/images/add.png'))),
                      )
                    ],
                  ).marginOnly(left: 30, bottom: 44, right: 21),
                  //list of data
                  Expanded(
                      child: ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    itemCount: _.userdata.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        showWillPopMessage(context, _);
                      },
                      child: Container(
                        height: 70,
                        width: Get.width,
                        decoration: BoxDecoration(color: Color(0xff3E3F4C)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 20,
                                width: 47,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3)),
                                    color: _.userdata[index]['isapp'] == true
                                        ? Color(0xff48BEEB)
                                        : Color(0xff22B161)),
                                child: Center(
                                    child: Text(
                                  _.userdata[index]['isapp'] == true
                                      ? 'App'
                                      : 'Portal',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                            Text(
                              "${_.userdata[index]['name']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ).marginOnly(bottom: 4, left: 15),
                            Row(
                              children: [
                                Text(
                                  "${_.userdata[index]['email']}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "${_.userdata[index]['number']}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                )
                              ],
                            ).marginOnly(left: 15)
                          ],
                        ),
                      ),
                    ),
                  ).marginOnly(bottom: 90)),
                ],
              ),
            ),
          );
        });
  }

  showWillPopMessage(
      context, ChangeSubscription2Controller changeSubscription2Controller) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return GetBuilder<ChangeSubscription2Controller>(
            init: ChangeSubscription2Controller(),
            builder: (_) {
              return AlertDialog(
                scrollable: true,
                insetPadding: EdgeInsets.all(7),
                contentPadding: EdgeInsets.all(0),
                backgroundColor: Color(0xff4F505B),
                content: Container(
                  height: 380,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'New Login Request',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (_.isapp == false) {
                                _.isapp = true;
                                _.isportal = false;
                                _.update();
                              } else {
                                _.isapp = false;
                              }
                            },
                            child: Container(
                              width: 55,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _.isapp == true
                                    ? Color(0xff48BEEB)
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  width: 1,
                                  color: _.isapp == true
                                      ? Color(0xff48BEEB)
                                      : Color(0xffADADAD),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'App\nLogin',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          InkWell(
                            onTap: () {
                              if (_.isportal == false) {
                                _.isportal = true;
                                _.isapp = false;
                                _.update();
                              } else {
                                _.isportal = false;
                              }
                            },
                            child: Container(
                              width: 55,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _.isportal == true
                                    ? Color(0xff48BEEB)
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  width: 1,
                                  color: _.isportal == true
                                      ? Color(0xff48BEEB)
                                      : Color(0xffADADAD),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Portal\nLogin',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).marginOnly(left: 28, right: 12, top: 13, bottom: 34),
                      textfieldtitle(
                        context,
                        'Name',
                      ),
                      SizedBox(
                        height: 30,
                        width: 140,
                        child: CommonTextField1(
                          hintText: 'Name',
                          controller: _.name,
                          bordercolor: Color(0xffB7B7B7),
                        ),
                      ).marginOnly(left: 22, top: 10, bottom: 20),
                      textfieldtitle(
                        context,
                        'Email',
                      ),
                      SizedBox(
                        height: 30,
                        width: 200,
                        child: CommonTextField1(
                          hintText: 'Email',
                          controller: _.email,
                          bordercolor: Color(0xffB7B7B7),
                        ),
                      ).marginOnly(left: 22, top: 10, bottom: 20),
                      textfieldtitle(
                        context,
                        'Contact Number',
                      ),
                      SizedBox(
                        height: 30,
                        width: 140,
                        child: CommonTextField1(
                          hintText: 'Phone Number',
                          controller: _.phonenumber,
                          bordercolor: Color(0xffB7B7B7),
                        ),
                      ).marginOnly(left: 22, top: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 105,
                          height: 40,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            onPressed: () {},
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.4,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            minWidth: Get.width / 3,
                            height: 40,
                            color: Color(0XFF48BEEB),
                          ),
                        ).marginOnly(top: 26, bottom: 19, right: 17),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget textfieldtitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
    ).marginOnly(left: 25);
  }
}
