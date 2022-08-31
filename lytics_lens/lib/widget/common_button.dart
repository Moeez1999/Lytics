import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  final String? buttonText;
  VoidCallback? onPressed;
  CommonButton({Key? key, this.buttonText, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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

        onPressed: onPressed,
        child: Text(
          buttonText!,
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
        color: CommonColor.buttonColor,
      ),
    );
  }
}
