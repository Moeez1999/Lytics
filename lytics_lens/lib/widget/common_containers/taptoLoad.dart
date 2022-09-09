import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapToLoad extends StatelessWidget {
  final Function() onPressed;

  const TapToLoad({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: Get.width / 2.0,
              height: Get.height / 2.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/no_server.png',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Could not connect to the server.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'Please try again.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 39,
          ),
          Container(
            width: 163,
            height: 48,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff23B662)),
                color: Color(0xff23B662).withOpacity(0.1),
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
              child: Text(
                'TRY AGAIN',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                  color: Color(0xff2CE08E),
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ).marginOnly(left: 20.0, right: 20.0),
    );
  }
}
