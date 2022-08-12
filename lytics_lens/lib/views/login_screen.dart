import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/login_screen_controller.dart';
import 'package:lytics_lens/Views/Forgot%20Password.dart';
import 'package:lytics_lens/views/Components/widget/common_textfield.dart';
import 'package:lytics_lens/widget/common_snackbar.dart';
import '../widget/validator.dart';
import 'Components/Global_TextField.dart';
import 'package:resize/resize.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 29, 40, 1),
      body: bodyData(context),
    );
  }

  Widget bodyData(context) {
    return GetBuilder<LoginScreenController>(
      init: LoginScreenController(),
      builder: (_) {
        return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: _.isLoading
                ? Center(
                    child: Image.asset(
                      "assets/images/gif.gif",
                      height: 300.0,
                      width: 300.0,
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      width: Get.width,
                      height: Get.height,
                      //color: Colors.white,
                      decoration: const BoxDecoration(
                        // gradient: RadialGradient(
                        //   center: Alignment(1.0, 1.0),
                        //   radius: 1.0,
                        //   tileMode: TileMode.clamp,
                        //   colors: [Color(0xff22b161),Color(0xff000425)]
                        // )
                        gradient: LinearGradient(
                          // stops: [0.0, 1.0],
                          // tileMode: TileMode.clamp,
                          colors: [Color(0xff02083B), Color(0xff36E381)],
                          begin: Alignment(1.0, -0.7),
                          end: Alignment(3.0, 1.8),
                          //stops: [0.8, 0.4],
                          // begin: Alignment.topLeft,
                          // end: Alignment.bottomRight
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50.0,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onLongPress: () {
                                      _.eraseUrlStorage();
                                    },
                                    onDoubleTap: () {
                                      showBox(context, _);
                                    },
                                    child: Image.asset(
                                      "assets/images/new_logo.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ).marginSymmetric(horizontal: 25),
                                SizedBox(
                                  height: 46.0,
                                ),
                                Form(
                                  key: _.formkey,
                                  child: Column(
                                    children: [
                                      CommonTextField(
                                        labelText: "Username",
                                        fillcolor: Colors.transparent,
                                        controller: _.userNameController,
                                        hintText: 'Username',
                                        hintTextColor:
                                            Colors.white.withOpacity(0.6),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty)
                                            return "Enter email";
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          var regex = RegExp(pattern as String);
                                          return (!regex.hasMatch(value))
                                              ? 'Please enter valid email'
                                              : null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\b|\b\s"))
                                        ],
                                        onChanged: (value) {
                                          value = value.replaceAll(' ', '');
                                        },
                                      ),
                                      SizedBox(
                                        height: 18.0,
                                      ),
                                      CommonTextField(
                                          fillcolor: Colors.transparent,
                                          controller: _.passwordController,
                                          textInputAction: TextInputAction.done,
                                          hintText: 'Password',
                                          labelText: "Password",
                                          hintTextColor:
                                              Colors.white.withOpacity(0.6),
                                          isTextHidden: _.securetext,
                                          togglePassword: true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r"\s\b|\b\s"))
                                          ],
                                          toggleIcon: _.securetext == true
                                              ? Icons.visibility_off_outlined
                                              : Icons.remove_red_eye_outlined,
                                          toggleFunction: () {
                                            _.securetext = !_.securetext;
                                            _.update();
                                          },
                                          validator: (value) {
                                            return PasswordValidationWidget
                                                .validatePasswordOnPressed(
                                                    value!);
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  //color: CommonColor.loginAndSendCodeButtonColor,
                                  width: 125,
                                  height: 48,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                      side: BorderSide(
                                        color: Color(0xff23B662),
                                      ),
                                    ),

                                    onPressed: () async {
                                      await _.verifyEmailPassword();
                                    },
                                    child: Text(
                                      _.remoteConfigService.remoteConfig
                                              .getString('logintext')
                                              .isNotEmpty
                                          ? _.remoteConfigService.remoteConfig
                                              .getString('logintext')
                                          : "LOGIN",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0.4,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700),
                                      maxLines: 2,
                                    ),
                                    minWidth: Get.width / 3,
                                    height: 4,
                                    // color: Color.fromRGBO(72, 190, 235, 1),
                                    color: Color(0xff109f4f),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ForgotPassword());
                                    },
                                    child: Text(
                                      _.remoteConfigService.remoteConfig
                                              .getString('login_forgot')
                                              .isNotEmpty
                                          ? _.remoteConfigService.remoteConfig
                                              .getString('login_forgot')
                                          : "Forgot Password?",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Color(0xff109f4f),
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.checkBio();
                                  },
                                  child: Image.asset(
                                    "assets/images/fingerprint.png",
                                    height: 50.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.checkBio();
                                  },
                                  child: Text(
                                    _.remoteConfigService.remoteConfig
                                            .getString('biometric')
                                            .isNotEmpty
                                        ? _.remoteConfigService.remoteConfig
                                            .getString('biometric')
                                        : "Use Biometric",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ],
                            ).marginOnly(left: 50.0, right: 50.0),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'v2.0.1',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ).marginOnly(bottom: 20.0)
                        ],
                      ),
                    ),
                  ));
      },
    );
  }

  showBox(context, LoginScreenController _) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: CommonColor.backgroundColour,
        title: Text(
          'ENTER URL',
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white38,
          ),
        ),
        content: Container(
          height: 150,
          child: Column(
            children: [
              GlobalTextField(_.linkController, (value) {
                if (value.isEmpty) return "Enter link";
              }, "110.93.212.132:3000", TextInputAction.done, false),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                  side: BorderSide(color: CommonColor.greenBorderColor),
                ),
                onPressed: () async {
                  if (_.linkController.text.isEmpty ||
                      _.linkController.text == "") {
                    CustomSnackBar.showSnackBar(
                        title: "Please add URL",
                        message: "",
                        backgroundColor: CommonColor.snackbarColour,
                        isWarning: true);
                  } else {
                    await _.getUrl();
                  }
                },
                child: Text(
                  "DONE",
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      color: CommonColor.greenTextColor, fontSize: 11.sp),
                ),
                minWidth: 274.w,
                height: 36.h,
                color: CommonColor.greenColorWithOpacity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
