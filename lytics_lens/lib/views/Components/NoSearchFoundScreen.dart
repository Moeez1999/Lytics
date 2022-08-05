
// import 'package:flutter/material.dart';
// import 'package:lytics_lens/Views/Components/SearchBarTextField.dart';

// import 'GlobalDrawer.dart';
// import 'Global_BottmNav.dart';
// import 'package:resize/resize.dart';

// class NoSearch extends StatelessWidget {
//   @override
//   // final searchController = TextEditingController();

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(27, 29, 40, 1),
//       appBar: AppBar(
//         titleSpacing: 0,
//         leading: Builder(builder: (BuildContext context) {
//           return IconButton(
//             icon: const Icon(Icons.sort),
//             iconSize: 35.sp,
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//             tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//           );
//         }),
//         title: Padding(
//           padding: const EdgeInsets.only(right: 10),
//           child: SearchBarTextField(searchController, (c) {}, "", (v){}),
//         ),
//         backgroundColor: Color.fromRGBO(27, 29, 40, 1),
//       ),
//       bottomNavigationBar: GlobalBottomNav(),
//       drawer: GlobalDrawer(),
//       body: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 120.h,
//             ),
//             Center(
//                 child: Text(
//               "No Results Found",
//               style: TextStyle(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             )),
//             SizedBox(
//               height: 34.0,
//             ),
//             // Text("Please check your spelling or try different keywords",
//             // style: TextStyle(fontSize: 14,color: Colors.grey),),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 75.0),
//               child: Container(
//                   height: 150.h,
//                   width: 201.w,
//                   child: Text(
//                     "Please check your spelling or try different keywords",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         letterSpacing: 0.4,
//                         color: Color(0xFFD3D3D3),
//                         fontSize: 13.0),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
