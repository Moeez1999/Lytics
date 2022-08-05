import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/app_strrings.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/forgotpassword_controller.dart';
import 'package:lytics_lens/views/Components/widget/common_textfield.dart';
import 'package:lytics_lens/views/CreateNewPasswordScreen.dart';
import 'package:lytics_lens/widget/common_snackbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/long_left.png"),
                ),
                backgroundColor: Color(0xff02083B),
              ),
              body: Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
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
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                _.remoteConfigService.remoteConfig
                                        .getString('forgot')
                                        .isNotEmpty
                                    ? _.remoteConfigService.remoteConfig
                                        .getString('forgot')
                                    : "Forgot Your Password?",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  letterSpacing: 0.7,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 25.0,
                            ),
                            Center(
                              child: Container(
                                width: Get.width/2,
                                height: 32,
                                child: Text(
                                  _.remoteConfigService.remoteConfig
                                          .getString('password_instructions')
                                          .isNotEmpty
                                      ? _.remoteConfigService.remoteConfig
                                          .getString('password_instructions')
                                      : "Enter your registered email below to receive password reset instructions",
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 0.4,
                                      color: Color(0xFFD3D3D3),
                                      fontSize: 12.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 43.0,
                            ),
                            Form(
                              key: _.formkey,
                              child: CommonTextField(
                                fillcolor: Colors.transparent,
                                controller: _.emailController,
                                hintText: 'Email Address',
                                textInputAction: TextInputAction.next,
                                // ignore: body_might_complete_normally_nullable
                                validator: (value) {
                                  if (value!.isEmpty) return "Enter email";
                                  if (EmailValidator.validate(
                                          _.emailController.text) ==
                                      false) return "Enter valid email";
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: 162,
                              height: 48,
                              //color: CommonColor.loginAndSendCodeButtonColor,
                              child: MaterialButton(
                                onPressed: () {
                                  if (_.start == 0 || _.start == 60) {
                                    _.forgotPassword();
                                  }
                                },
                                child: Text(
                                  _.remoteConfigService.remoteConfig
                                      .getString('send_code')
                                      .isNotEmpty
                                  ? _.remoteConfigService.remoteConfig
                                      .getString('send_code') : "SEND CODE",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: Color(0xff23B662),
                                      fontSize: 16.0,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w700),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  side: BorderSide(
                                    color: Color(0xff23B662),
                                  ),
                                ),
                                // color: Color.fromRGBO(72, 190, 235, 1),
                                color: Color(0xff23B662).withOpacity(0.1),
                                minWidth: Get.width / 3,
                                height: 36,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: Get.width / 2,
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                    color: Colors.white, fontSize: 11),
                                length: 4,
                                animationType: AnimationType.fade,
                                textStyle: TextStyle(
                                    letterSpacing: 0.4,
                                    color: Colors.white,
                                    fontSize: 11),
                                // ignore: body_might_complete_normally_nullable
                                validator: (v) {
                                  // if (v!.length < 3) {
                                  //   return "I'm from validator";
                                  // } else {
                                  //   return null;
                                  // }
                                },
                                pinTheme: PinTheme(
                                  selectedFillColor: CommonColor.snackbarColour,
                                  selectedColor: CommonColor.snackbarColour,
                                  borderWidth: 2,
                                  disabledColor: Color(0xff23B662),
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 46,
                                  fieldWidth: 46,
                                  inactiveColor:
                                      Color(0xff1E975D).withOpacity(0.27),
                                  inactiveFillColor:
                                      Color(0xff1E975D).withOpacity(0.27),
                                  activeColor:
                                      Color(0xff1E975D).withOpacity(0.27),
                                  activeFillColor:
                                      Color(0xff1E975D).withOpacity(0.27),
                                ),
                                cursorColor: CommonColor.snackbarColour,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                errorAnimationController: _.errorController,
                                controller: _.pin,
                                keyboardType: TextInputType.number,
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                onCompleted: (v) {
                                  print('Complete value $v');
                                  if (_.start == 60 || _.start == 0) {
                                    CustomSnackBar.showSnackBar(
                                        title:
                                            'OTP code has expired please retry',
                                        message: "",
                                        backgroundColor:
                                            CommonColor.snackbarColour,
                                        isWarning: true);
                                  } else {
                                    if (v.toString() == _.lastcode.toString()) {
                                      print('Code Done');
                                      _.start = 0;
                                      _.update();

                                      Get.to(() => CreateNewPasswordScreen(),
                                          arguments: _.emailController.text);
                                    } else {
                                      CustomSnackBar.showSnackBar(
                                          title: AppStrings.otpNotMatch,
                                          message: "",
                                          backgroundColor:
                                              CommonColor.snackbarColour,
                                          isWarning: true);
                                    }
                                  }
                                },
                                onChanged: (value) {},
                                beforeTextPaste: (text) {
                                  return true;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Center(
                              child: Text(
                                _.remoteConfigService.remoteConfig
                                      .getString('code')
                                      .isNotEmpty
                                  ? _.remoteConfigService.remoteConfig
                                      .getString('code') : 'ENTER CODE',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Center(
                              child: Text(
                                '00 : ${_.start}',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ).marginOnly(left: 55.0, right: 30.0),
                  ),
                ),
              ));
        });
  }
}
