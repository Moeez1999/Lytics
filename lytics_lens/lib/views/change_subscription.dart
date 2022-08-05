import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Controllers/change_subscription_controller.dart';
import 'package:lytics_lens/views/change_subscription_1.dart';

class ChangeSubscription extends StatelessWidget {
  const ChangeSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Subscription",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            )),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_backspace_rounded,
          ).marginOnly(left: 34),
        ),
      ),
      body: bodyData(context),
    );
  }

  Widget bodyData(BuildContext context) {
    return GetBuilder<ChangeSubscriptionController>(
        init: ChangeSubscriptionController(),
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                Color(0xff1b1d28).withOpacity(.95),
                Color(0xff1b1d28),
              ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                  ),
                  Text(
                    'Select Information Type',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ).marginOnly(left: 30, bottom: 29),
                  //topics list
                  showTrendingTopic(_).marginOnly(left: 30, right: 20),
                  Text(
                    'Select Information Type',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ).marginOnly(left: 30, top: 29, bottom: 40),
                  //channels list
                  showChannels(_).marginOnly(left: 15, bottom: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ChangeSubscription1());
                        },
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ).marginSymmetric(horizontal: 40)
                ],
              ),
            ),
          );
        });
  }

  Widget showTrendingTopic(ChangeSubscriptionController _) {
    print("check ${_.alltopic.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.alltopic.length; i++) {
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: GestureDetector(
          onTap: () {
            if (_.alltopic[i]['check'] == false) {
              _.alltopic[i]['check'] = true;
              _.update();
            } else {
              _.alltopic[i]['check'] = false;
              _.update();
            }
          },
          child: Container(
            height: 40,
            width: 90,
            decoration: BoxDecoration(
              color: _.alltopic[i]['check'] == false
                  ? Color(0xff1b1d28)
                  : Color(0xff48BEEB),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: _.alltopic[i]['check'] == false
                    ? Color(0xffADADAD)
                    : Color(0xff48BEEB),
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                "${_.alltopic[i]['name']}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ).marginOnly(bottom: 17, right: 13));
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }

  Widget showChannels(ChangeSubscriptionController _) {
    print("check ${_.allchannels.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.allchannels.length; i++) {
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: GestureDetector(
          onTap: () {
            if (_.allchannels[i]['check'] == false) {
              _.allchannels[i]['check'] = true;
              _.update();
            } else {
              _.allchannels[i]['check'] = false;
              _.update();
            }
          },
          child: Container(
            height: 42,
            width: 100,
            decoration: BoxDecoration(
              color: _.allchannels[i]['check'] == false
                  ? Color(0xff1b1d28)
                  : Color(0xff48BEEB),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: _.allchannels[i]['check'] == false
                    ? Color(0xffADADAD)
                    : Color(0xff48BEEB),
                width: 1.0,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 17,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              '${_.allchannels[i]['image']}',
                            ),
                            fit: BoxFit.fill)),
                  ).marginAll(6),
                  Text(
                    "${_.allchannels[i]['name']}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ).marginOnly(bottom: 17, right: 15));
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );

  }
}
