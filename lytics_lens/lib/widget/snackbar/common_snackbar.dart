import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    bool isWarning = false,
  }) {
    Get.snackbar(title, message,
        padding: EdgeInsets.all(0),
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        titleText: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isWarning
                ? title == 'You are offline. Please connect to the internet.'
                    ? Image.asset('assets/images/nowifi.png')
                    : Container(
                        height: 23.0,
                        width: 23.0,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          Icons.warning,
                          color: Color(0xff22B161),
                          size: 18.0,
                        ),
                      )
                : Container(
                    height: 23.0,
                    width: 23.0,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      Icons.done,
                      color: Color(0xff22B161),
                      size: 18.0,
                    ),
                  ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text(
                title,
                textScaleFactor: 1.0,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4),
              ),
            )
          ],
        ).marginOnly(top: 18.0, left: 10.0),
        // messageText: Text(
        //   message,
        //   style: const TextStyle(fontSize: 16),
        // ),
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(0));
  }
}
