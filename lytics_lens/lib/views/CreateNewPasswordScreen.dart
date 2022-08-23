import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/Controllers/createnewpassword_controller.dart';

import 'package:lytics_lens/views/Components/widget/common_textfield.dart';

import '../Constants/app_strrings.dart';
import '../widget/common_snackbar.dart';
import '../widget/validator.dart';
// import 'package:resize/resize.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   backgroundColor: CommonColor.transparent,
          //   elevation: 0.0,
          //   leading: GestureDetector(
          //     onTap: () {
          //       Get.back();
          //     },
          //     child: Image.asset("assets/images/long_left.png"),
          //   ),
          // ),
          body: bodyData(context)),
    );
  }

  Widget bodyData(context) {
    return GetBuilder<CreatenewpasswordController>(
      init: CreatenewpasswordController(),
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    _.remoteConfigService.remoteConfig
                            .getString('create_password')
                            .isNotEmpty
                        ? _.remoteConfigService.remoteConfig
                            .getString('create_password')
                        : "Create New Password",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 0.4,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 26.0,
                ),
                Center(

                  child: Container(
                    width: Get.width/1.7,
                    height: 34,
                    //color: Colors.amber,
                    child: Text(
                      _.remoteConfigService.remoteConfig
                              .getString('new_password_detail')
                              .isNotEmpty
                          ? _.remoteConfigService.remoteConfig
                              .getString('new_password_detail')
                          : "Your new password must be different\n from previously used passwords",
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Color(0xFFD3D3D3)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 43.0,
                ),
                Form(
                  key: _.formkey,
                  child: Column(
                    children: [
                      CommonTextField(
                        fillcolor: Colors.transparent,
                        controller: _.passwordController,
                        hintText: 'Enter New Password',
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                        ],
                        //     ? Icons.visibility_off
                        //     : Icons.remove_red_eye,
                        // toggleFunction: () {
                        //   _.securetext = !_.securetext;
                        //   _.update();
                        // },
                        // ignore: body_might_complete_normally_nullable
                        validator: (value) {
                          return PasswordValidationWidget
                              .validatePasswordOnPressed(value!);
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      CommonTextField(
                        fillcolor: Colors.transparent,
                        controller: _.retypePasswordController,
                        hintText: 'Confirm password',
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                        ],
                        //     ? Icons.visibility_off
                        //     : Icons.remove_red_eye,
                        // toggleFunction: () {
                        //   _.securetext1 = !_.securetext1;
                        //   _.update();
                        // },
                        // ignore: body_might_complete_normally_nullable
                        validator: (value) {
                          return PasswordValidationWidget
                              .validatePasswordOnPressed(value!);
                        },
                      ),
                    ],
                  ),
                ).marginOnly(left: 40.0, right: 40.0),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 162,
                  height: 48,
                  child: MaterialButton(
                    onPressed: () {
                      if (_.passwordController.text ==
                          _.retypePasswordController.text) {
                        _.createNewPassword();
                      } else {
                        CustomSnackBar.showSnackBar(
                          title: AppStrings.passwordmatcherror,
                          message: "",
                          backgroundColor: CommonColor.snackbarColour,
                          isWarning: true,
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      side: BorderSide(
                        color: Color(0xff23B662),
                      ),
                    ),
                    minWidth: Get.width / 3,
                    height: 40,
                    color: Colors.transparent,
                    child: Text(
                      "SAVE",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          color: Color(0xff23B662),
                          fontSize: 12.0,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
