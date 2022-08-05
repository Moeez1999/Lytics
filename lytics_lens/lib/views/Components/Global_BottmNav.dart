import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/constants.dart';
import 'package:lytics_lens/views/search.dart';
import '../account_Screen.dart';
import '../home_screen.dart';
import '../reports_Screen.dart';

class GlobalBottomNav extends StatefulWidget {
  const GlobalBottomNav({Key? key}) : super(key: key);

  @override
  _GlobalBottomNavState createState() => _GlobalBottomNavState();
}

class _GlobalBottomNavState extends State<GlobalBottomNav> {
  int selectedIndex = 0;


  void navigation(int index) {
    if (index == 0)
      {
        print("List clear");
        Get.off(() => HomeScreen());
      }

    else if (index == 1)
      {
        Get.off(() => SearchBarView());
      }
    else if(index == 2)
      {
        Get.off(() => ReportsScreen());
      }
    else if(index==3)
    {
      Get.off(() => AccountScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/alerts.png"),
            size: 25.0,
          ),
          label: 'Alerts',
            backgroundColor: Color(0xff031347),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search , size: 25.0,),
          label: 'Search',
          backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.content_paste),
          label: 'Analysis',
          backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
          backgroundColor: Color.fromRGBO(27, 29, 40, 1),
        ),
      ],
      currentIndex: Constants.index,
      selectedItemColor: Color( 0xff22B161),
      selectedFontSize : 12.0,
      backgroundColor: Color(0xff031347),
      unselectedItemColor: Color(0xffD3D3D3),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          Constants.index = index;
        });
        navigation(index);
      },
    );
  }
}
