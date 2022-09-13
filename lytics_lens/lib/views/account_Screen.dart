import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/account_controller.dart';
import 'package:lytics_lens/views/changepassword_screen.dart';
import 'package:lytics_lens/views/home_screen.dart';
// import 'package:lytics_lens/views/select_subsccription_screen.dart';
// import 'package:lytics_lens/views/select_keyword_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.appBarColor,
      appBar: AppBar(
        backgroundColor: CommonColor.appBarColor,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              letterSpacing: 0.7),
        ).marginOnly(left: 20.0, top: 10),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      // bottomNavigationBar: GlobalBottomNav(),
      body: bodyData(context),
    );
  }

  void moveToAlertScreen(BuildContext context) {
    Get.offAll(HomeScreen());
  }

  Widget bodyData(BuildContext context) {
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (_) {
          return Container(
              width: Get.width,
              height: Get.height,
              color: CommonColor.appBarColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.right,
                        color: Colors.black,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return ListView(shrinkWrap: true, children: [
                                options(
                                  text: 'Change Password',
                                  subTitle: 'You can change your password',
                                  imagename: 'assets/images/password.png',
                                  onTap: () {
                                    Get.to(() => ChangePasswordScreen());
                                  },
                                ),
                                // options(
                                //   text: 'Manage Notifications',
                                //   subTitle:
                                //       'You can see which notifications to receive',
                                //   imagename: 'assets/images/notification.png',
                                //   onTap: () {
                                //     Get.to(() => NotificationViewScreen());
                                //   },
                                // ),

                                // options(
                                //   text: 'Select Preferences by Topic',
                                //   subTitle:
                                //       'You can add new Topics to your list',
                                //   imagename: 'assets/images/pref.png',
                                //   onTap: () {
                                //     Get.to(() => SelectKeyWords());
                                //   },
                                // ),

                                // options(
                                //   text: 'Select Preferences by Keywords',
                                //   subTitle:
                                //       'You can add new Keywords to your list',
                                //   imagename: 'assets/images/setting.png',
                                //   onTap: () {
                                //     Get.to(() => SelectKeyWords());
                                //   },
                                // ),

                                // options(
                                //   text: 'Select Subscription',
                                //   subTitle:
                                //       'You can add new Keywords to your list',
                                //   imagename: 'assets/images/setting.png',
                                //   onTap: () {
                                //     Get.to(() => SelectSubscriptionScreen());
                                //   },
                                // ),

                                // options(
                                //   text: 'Change Subscription',
                                //   subTitle:
                                //       // options(
                                //       //   text: 'Change Subscription',
                                //       //   subTitle:
                                //       'Request a change in your subscriptions and choose a new one',
                                //   imagename: 'assets/images/email_setting.png',
                                //   onTap: () {
                                //     Get.to(() => SelectSubscriptionScreen());
                                //   },
                                // ),

                                options(
                                  text: 'Logout',
                                  subTitle: '',
                                  imagename: 'assets/images/logout.png',
                                  onTap: () {
                                    _showMyDialog(context, _);
                                  },
                                ),
                              ]);
                            }),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_.isShow == true) {
                        versionBox(context, _);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'v2.0.1',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ).marginOnly(bottom: 5.0),
                        // Image.asset(
                        //   "assets/images/i.png",
                        //   height: 15,
                        //   width: 15,
                        // ).marginOnly(bottom: 7),
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                          size: 15,
                        ).marginOnly(bottom: 8, left: 3),
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  Widget options(
      {String? text, String? subTitle, String? imagename, Function()? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  width: 60.0,
                  child: Image.asset(
                    imagename!,
                    height: 24,
                    width: 24,
                  ),
                ).marginOnly(left: 20.0),
                SizedBox(
                  width: 5.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width / 1.4,
                      child: Text(
                        text!,
                        textScaleFactor: 1.0,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    subTitle == ''
                        ? SizedBox()
                        : SizedBox(
                            height: 5.0,
                          ),
                    subTitle == ''
                        ? SizedBox()
                        : Container(
                            width: Get.width / 1.4,
                            child: Text(
                              subTitle!,
                              textScaleFactor: 1.0,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                  ],
                )
              ],
            )),
        onTap: onTap,
        highlightColor:CommonColor.greenColor ,
        splashColor: CommonColor.greenColor,
        hoverColor: CommonColor.greenColor,
        focusColor: CommonColor.greenColor,
      ).marginOnly(bottom: 30.0),
    );
  }

  void versionBox(context, AccountController _) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff131C3A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Update',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
          content: Container(
            height: Get.height / 3.0,
            width: Get.width,
            child: ListView.separated(
              itemCount: _.updateList.length,
              shrinkWrap: true,
              itemBuilder: (c, i) {
                return getRow(des: _.updateList[i]['point']);
              },
              separatorBuilder: (c, q) {
                return SizedBox(
                  height: 5.0,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget getRow({String? des}) {
    return Row(
      children: [
        Container(
          height: 5.0,
          width: 5.0,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
        SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text(
            des!,
            textScaleFactor: 1.0,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 0.4,
                fontFamily: 'Roboto'),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(context, AccountController _) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff131C3A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Log Out?',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
          content: Container(
            height: 100.0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to log out?',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 0.4,
                      fontFamily: 'Roboto'),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: CommonColor.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      minWidth: 80,
                      height: 42,
                      color: Color(0xff212A4A),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    MaterialButton(
                      color: CommonColor.newButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      onPressed: () async {
                        print("check");

                        await _.logout();
                      },
                      child: Text(
                        "Log Out",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: CommonColor.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      minWidth: 123,
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
