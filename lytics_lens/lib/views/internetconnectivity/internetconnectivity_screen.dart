import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterConnectivity extends StatelessWidget {
  const InterConnectivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width / 3,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/wifi.png',
            ),
          ),
        ),
      ),
    );
  }
}
