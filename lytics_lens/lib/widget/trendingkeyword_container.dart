import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingKeyword extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? searchText;
  final String? heading;
  final GetxController controller;

  const TrendingKeyword(
      {Key? key,
      this.title,
      this.subTitle,
      this.searchText,
      this.heading,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/new_logo.png",
              height: 89,
              width: 237,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              '$title "$searchText"',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                  fontFamily: 'Roboto',
                  fontSize: 24.0,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: SizedBox(
              width: Get.width / 2.0,
              child: Text(
                '$subTitle',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white.withOpacity(0.5),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ).marginOnly(left: 0.0, right: 0.0),
    );
  }

  Widget showTrendingTopic(_) {
    print("check ${_.alltopic.length}");
    List<Widget> g = [];
    if (_.alltopic.length >= 5) {
      for (int i = 0; i < 5; i++) {
        g.add(FittedBox(
          fit: BoxFit.fill,
          child: GestureDetector(
            onTap: () {
              _.searchdata.value.text = _.alltopic[i].name!;
              _.update();
              _.getFilterJobs(_.searchdata.value.text, 1);
            },
            child: Container(
              height: 27,
              decoration: BoxDecoration(
                //border: Border.all(color: Color(0xff22B161)),
                color: Color(0xff222452).withOpacity(0.55),
                borderRadius: BorderRadius.circular(21.0),
              ),
              child: Center(
                child: Text(
                  "#${_.alltopic[i].name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.79)),
                ).marginOnly(left: 15.0, right: 15.0),
              ),
            ),
          ),
        ).marginAll(5.0));
      }
    } else {
      for (int i = 0; i < _.alltopic.length; i++) {
        g.add(FittedBox(
          fit: BoxFit.fill,
          child: Obx(
            () => GestureDetector(
              onTap: () {
                _.searchdata.value.text = _.alltopic[i].name!;
                _.update();
                _.getFilterJobs(_.searchdata.value.text, 1);
              },
              child: Container(
                height: 27,
                decoration: BoxDecoration(
                  color: Color(0xff454857),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "${_.alltopic[i].name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ).marginOnly(left: 15.0, right: 15.0),
                ),
              ),
            ),
          ),
        ).marginAll(5.0));
      }
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }
}
