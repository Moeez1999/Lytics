import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    'assets/images/internet.png',
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
              fontSize: 14.0,
              color: Colors.white,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            'Please connect to the internet and try again.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.0,
              color: Colors.white,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 39,
          ),
          Container(
            width: 133,
            height: 48,
            decoration: BoxDecoration(
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
      ),
    );
  }
}
