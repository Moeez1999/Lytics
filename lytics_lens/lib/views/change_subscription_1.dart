import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Controllers/change_subscription_1_controller.dart';
import 'package:lytics_lens/views/change_subscription_2.dart';

class ChangeSubscription1 extends StatelessWidget {
  const ChangeSubscription1({Key? key}) : super(key: key);

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
    return GetBuilder<ChangeSubscription1Controller>(
        init: ChangeSubscription1Controller(),
        builder: (_) {
          return Container(
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
                  height: 60,
                ),
                Text(
                  'Intelligence',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ).marginOnly(left: 30, bottom: 29),
                //topics list
                showIntelligenceList(_).marginOnly(left: 30, right: 20),
                Text(
                  'Report Timing',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ).marginOnly(left: 30, top: 44, bottom: 29),
                //channels list
                showChannels(_).marginOnly(left: 22, bottom: 60),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text('BACK',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(ChangeSubscription2());
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
          );
        });
  }

  Widget showIntelligenceList(ChangeSubscription1Controller _) {
    print("check ${_.intelligence.length}");
    List<Widget> g = [];
    for (int i = 0; i < _.intelligence.length; i++) {
      g.add(FittedBox(
        fit: BoxFit.fill,
        child: GestureDetector(
          onTap: () {
            if (_.intelligence[i]['check'] == false) {
              _.intelligence[i]['check'] = true;
              _.update();
            } else {
              _.intelligence[i]['check'] = false;
              _.update();
            }
          },
          child: Container(
            height: 41,
            width:
                _.intelligence[i]['name'] == 'Speaker Recognition' ? 140 : 90,
            decoration: BoxDecoration(
              color: _.intelligence[i]['check'] == false
                  ? Color(0xff1b1d28)
                  : Color(0xff48BEEB),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: _.intelligence[i]['check'] == false
                    ? Color(0xffADADAD)
                    : Color(0xff48BEEB),
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                "${_.intelligence[i]['name']}",
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

  Widget showChannels(ChangeSubscription1Controller _) {
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
            height: 41,
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
              child: Text(
                "${_.allchannels[i]['name']}" + " Hours",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ).marginOnly(bottom: 17, right: 10));
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }
}
