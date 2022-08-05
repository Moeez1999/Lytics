import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeatilContainer extends StatelessWidget {
  final String? heading;
  final String? content;
  final bool isDivider;
  final bool isBottomDivider;
  final bool isWidget;
  final Widget? chips;
  const DeatilContainer(
      {Key? key,
      this.heading,
      this.content,
      this.chips,
      this.isDivider = false,
      this.isWidget = false,
      this.isBottomDivider = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isDivider
            ? Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 2,
                  color: Color(0xff979797),
                ).marginOnly(left: Get.width / 3.0),
              )
            : SizedBox(),
        isDivider
            ? SizedBox(
                height: 10.0,
              )
            : SizedBox(),
        SizedBox(
          width: Get.width,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width / 3.0,
                  child: Text(
                    heading!,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    ),
                  ),
                ),
                isWidget
                    ? Flexible(
                        child: chips!,
                      )
                    : Flexible(
                        child: Text(
                          content!,
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            color: Color(0xffd3d3d3),
                          ),
                        ).marginOnly(left: 5.0),
                      ),
              ]),
        ),
        isBottomDivider
            ? SizedBox(
                height: 10.0,
              )
            : SizedBox(),
        isBottomDivider
            ? Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 2,
                  color: Color(0xff979797),
                ).marginOnly(left: Get.width / 3.0),
              )
            : SizedBox(),
      ],
    );
  }
}
