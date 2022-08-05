import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/app_strrings.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/widget/common_snackbar.dart';
import 'package:lytics_lens/Controllers/changepassword_controller.dart';
import 'package:lytics_lens/views/Components/widget/common_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return MediaQuery(
      data: mqDataNew,
      child: Scaffold(
        backgroundColor: CommonColor.allScreenBackgroundColor,
        appBar: AppBar(
          backgroundColor: CommonColor.allScreenBackgroundColor,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Password",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ).marginOnly(top: 25),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_backspace_rounded,
            ).marginOnly(left: 34, top: 25),
          ),
        ),
        body: bodyData(context),
      ),
    );
  }

  Widget bodyData(context) {
    return GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (_) {
          return Container(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Form(
                key: _.formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Current Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ).marginOnly(top: 79, left: 34),
                    CommonTextField(
                            fillcolor: CommonColor.textFieldBackgrounfColour,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r"\s\b|\b\s"))
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter current password';
                              }
                              return null;
                            },
                            controller: _.oldPassword,
                            isTextHidden: _.securetext)
                        .marginOnly(left: 34, top: 15, right: 66),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "New Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ).marginOnly(top: 15, left: 34),
                    CommonTextField(
                            fillcolor: CommonColor.textFieldBackgrounfColour,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r"\s\b|\b\s"))
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter new password';
                              }
                              return null;
                            },
                            controller: _.newPassword,
                            isTextHidden: _.securetext)
                        .marginOnly(left: 34, top: 15, right: 66),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm New Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ).marginOnly(top: 15, left: 34),
                    CommonTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                      ],
                      fillcolor: CommonColor.textFieldBackgrounfColour,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter confirm password';
                        }
                        return null;
                      },
                      controller: _.confirmPassword,
                      isTextHidden: _.securetext,
                    ).marginOnly(left: 34, top: 15, right: 66),
                    MaterialButton(
                      color: CommonColor.greenColorWithOpacity,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: CommonColor.greenBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(9.0)),
                      onPressed: () async {
                        if (_.formKey.currentState!.validate()) {
                          if (_.newPassword.text == _.confirmPassword.text) {
                            _.changePassword();
                          } else {
                            CustomSnackBar.showSnackBar(
                                title: AppStrings.passwordNotMatch,
                                message: "",
                                backgroundColor: CommonColor.snackbarColour,
                                isWarning: true);
                          }
                        }
                      },
                      child: Text(
                        "UPDATE PASSWORD",
                        style: TextStyle(
                            color: CommonColor.greenButtonTextColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto'),
                      ),
                      minWidth: 176,
                      height: 45,
                      //color: Color(0xff23B662),
                    ).marginOnly(top: 56),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
