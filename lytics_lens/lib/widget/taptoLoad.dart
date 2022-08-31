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
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/server.png',
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
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Please try again.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 39,
          ),
          Container(
            width: 133,
            height: 48,
            decoration: BoxDecoration(
                // border: Border.all(color: Color(0xff23B662)),
                color: Color(0xff109F4F),
                borderRadius: BorderRadius.circular(7.0)),
            child: Center(
              child: Text(
                'TRY AGAIN',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.0,
                  color: Colors.white,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ).marginOnly(left: 20.0, right: 20.0),
    );
  }
}
