import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterConnectivity extends StatelessWidget {
  final Function() onPressed;

  const InterConnectivity({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/no_wifi.png',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 27,
          ),
          Text(
            'No internet connection.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 11.0,
              color: Colors.white,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            'Please connect to the internet and try again.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 11.0,
              color: Colors.white,
              letterSpacing: 0.4,
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
      ).marginOnly(bottom: 200),
    );
  }
}
