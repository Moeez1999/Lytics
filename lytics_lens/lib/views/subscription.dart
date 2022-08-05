// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:lytics_lens/Controllers/select_subscription.dart';
// // import 'package:lytics_lens/utils/custom_checkbox.dart';
// // import 'Components/widget/common_textfield.dart';
// //
// // class SelectSubscription extends StatelessWidget {
// //   const SelectSubscription({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(child: bodyData(context)),
// //       appBar: AppBar(
// //         backgroundColor: Color(0xff1E202B),
// //         title: Align(
// //             alignment: Alignment.centerLeft,
// //             child: Text(
// //               "Select Subscription",
// //               textScaleFactor: 1.0,
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.w500,
// //                 fontFamily: 'Roboto',
// //                 letterSpacing: 0.4,
// //               ),
// //             )),
// //         elevation: 0.0,
// //         centerTitle: false,
// //         automaticallyImplyLeading: false,
// //         leading: GestureDetector(
// //           onTap: () {
// //             Get.back();
// //           },
// //           child: Icon(
// //             Icons.keyboard_backspace_rounded,
// //           ).marginOnly(left: 26, right: 13),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget bodyData(context) {
// //     return GetBuilder<SelectSubscriptionController>(
// //         init: SelectSubscriptionController(),
// //         builder: (_) {
// //           return GestureDetector(
// //             onTap: () {
// //               _.isContainerShown = false;
// //               _.update();
// //             },
// //             child: Container(
// //               height: Get.height,
// //               width: Get.width,
// //               color: Color(0xff1E202B),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     height: 45,
// //                     width: Get.width,
// //                     decoration: BoxDecoration(
// //                       border: Border.all(color: Color(0xffBDBDBD)),
// //                       color: Color(0xff1E202B),
// //                       // color: Colors.white,
// //
// //                       // color: Color.fromRGBO(45, 47, 58, 1),
// //                       borderRadius: BorderRadius.circular(4),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         Flexible(
// //                           child: CommonTextField2(
// //                               readOnly: true,
// //                               hintText: "Select Information Type",
// //                               controller: _.information,
// //                               onTap: () {
// //                                 _.isContainerShown = true;
// //                                 _.update();
// //                               }),
// //                         ),
// //                       ],
// //                     ),
// //                   ).marginOnly(left: 15, right: 15, top: 25),
// //                   _.isContainerShown ? selectionContainer() : SizedBox(),
// //                 ],
// //               ),
// //             ),
// //           );
// //         });
// //   }
// //
// //   Widget selectionContainer() {
// //     return Container(
// //       width: Get.width,
// //       height: Get.height / 1.5,
// //       color: Color(0xff5A5C69),
// //       // child: Column(
// //       //   children: [
// //       //     ParentChildCheckbox(
// //       //       parent: Text(
// //       //         'TV',
// //       //         style: TextStyle(
// //       //             fontFamily: 'Roboto',
// //       //             fontSize: 12,
// //       //             letterSpacing: 0.7,
// //       //             fontWeight: FontWeight.w500,
// //       //             color: Colors.white),
// //       //       ),
// //       //       children: [],
// //       //       parentCheckboxColor: Color(0xff22B161),
// //       //       childrenCheckboxColor: Color(0xff22B161),
// //       //     ).marginOnly(top: 8),
// //       //     ParentChildCheckbox(
// //       //       parent: Text(
// //       //         'Print',
// //       //         style: TextStyle(
// //       //             fontFamily: 'Roboto',
// //       //             fontSize: 12,
// //       //             letterSpacing: 0.7,
// //       //             fontWeight: FontWeight.w500,
// //       //             color: Colors.white),
// //       //       ),
// //       //       children: [],
// //       //       parentCheckboxColor: Color(0xff22B161),
// //       //       childrenCheckboxColor: Color(0xff22B161),
// //       //     ),
// //       //     ParentChildCheckbox(
// //       //       parent: Text(
// //       //         'Online Video',
// //       //         style: TextStyle(
// //       //             fontFamily: 'Roboto',
// //       //             fontSize: 12,
// //       //             letterSpacing: 0.7,
// //       //             fontWeight: FontWeight.w500,
// //       //             color: Colors.white),
// //       //       ),
// //       //       children: [],
// //       //       parentCheckboxColor: Color(0xff22B161),
// //       //       childrenCheckboxColor: Color(0xff22B161),
// //       //     ),
// //       //     ParentChildCheckbox(
// //       //       parent: Text(
// //       //         'Websites',
// //       //         style: TextStyle(
// //       //             fontFamily: 'Roboto',
// //       //             fontSize: 12,
// //       //             letterSpacing: 0.7,
// //       //             fontWeight: FontWeight.w500,
// //       //             color: Colors.white),
// //       //       ),
// //       //       children: [],
// //       //       parentCheckboxColor: Color(0xff22B161),
// //       //       childrenCheckboxColor: Color(0xff22B161),
// //       //     ),
// //       //     ParentChildCheckbox(
// //       //       parent: Text(
// //       //         'Social Media',
// //       //         style: TextStyle(
// //       //             fontFamily: 'Roboto',
// //       //             fontSize: 12,
// //       //             letterSpacing: 0.7,
// //       //             fontWeight: FontWeight.w500,
// //       //             color: Colors.white),
// //       //       ),
// //       //       children: [],
// //       //       parentCheckboxColor: Color(0xff22B161),
// //       //       childrenCheckboxColor: Color(0xff22B161),
// //       //     ),
// //       //     ParentChildCheckbox(
// //       //       parent: Text(
// //       //         'Intelligence',
// //       //         style: TextStyle(
// //       //             fontFamily: 'Roboto',
// //       //             fontSize: 12,
// //       //             letterSpacing: 0.7,
// //       //             fontWeight: FontWeight.w500,
// //       //             color: Colors.white),
// //       //       ),
// //       //       children: [],
// //       //       parentCheckboxColor: Color(0xff22B161),
// //       //       childrenCheckboxColor: Color(0xff22B161),
// //       //     ),
// //       //     ParentChildCheckbox(
// //       //       parent: Text(
// //       //         'Report Timing',
// //       //         style: TextStyle(
// //       //             fontFamily: 'Roboto',
// //       //             fontSize: 12,
// //       //             letterSpacing: 0.7,
// //       //             fontWeight: FontWeight.w500,
// //       //             color: Colors.white),
// //       //       ),
// //       //       children: [],
// //       //       parentCheckboxColor: Color(0xff22B161),
// //       //       childrenCheckboxColor: Color(0xff22B161),
// //       //     ),
// //       //   ],
// //       // ),
// //
// //     ).marginOnly(left: 16, right: 16);
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'Components/widget/common_textfield.dart';
//
// class SelectSubscription extends StatelessWidget {
//   const SelectSubscription({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(child: bodyData(context)),
//       appBar: AppBar(
//         backgroundColor: Color(0xff1E202B),
//         title: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "Select Subscription",
//               textScaleFactor: 1.0,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Roboto',
//                 letterSpacing: 0.4,
//               ),
//             )),
//         elevation: 0.0,
//         centerTitle: false,
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(
//             Icons.keyboard_backspace_rounded,
//           ).marginOnly(left: 26, right: 13),
//         ),
//       ),
//     );
//   }
//
//   Widget bodyData(context) {
//     return GetBuilder<SelectSubscriptionController>(
//         init: SelectSubscriptionController(),
//         builder: (_) {
//           return GestureDetector(
//             onTap: () {
//               _.isContainerShown = false;
//               _.update();
//             },
//             child: Container(
//               height: Get.height,
//               width: Get.width,
//               color: Color(0xff1E202B),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xffBDBDBD)),
//                       color: Color(0xff1E202B),
//                       // color: Colors.white,
//
//                       // color: Color.fromRGBO(45, 47, 58, 1),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Row(
//                       children: [
//                         Flexible(
//                           child: CommonTextField2(
//                               readOnly: true,
//                               hintText: "Select Information Type",
//                               controller: _.information,
//                               onTap: () {
//                                 _.isContainerShown = true;
//                                 _.update();
//                               }),
//                         ),
//                       ],
//                     ),
//                   ).marginOnly(left: 15, right: 15, top: 25),
//                   _.isContainerShown ? selectionContainer() : SizedBox(),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget selectionContainer() {
//     return Container(
//       width: Get.width,
//       height: Get.height / 1.5,
//       color: Color(0xff5A5C69),
//       // child: Column(
//       //   children: [
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'TV',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ).marginOnly(top: 8),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Print',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Online Video',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Websites',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Social Media',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Intelligence',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Report Timing',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //   ],
//       // ),
//     ).marginOnly(left: 16, right: 16);
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lytics_lens/Controllers/select_subscription.dart';
// import 'Components/widget/common_textfield.dart';

// class SelectSubscription extends StatelessWidget {
//   const SelectSubscription({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(child: bodyData(context)),
//       appBar: AppBar(
//         backgroundColor: Color(0xff1E202B),
//         title: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "Select Subscription",
//               textScaleFactor: 1.0,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Roboto',
//                 letterSpacing: 0.4,
//               ),
//             )),
//         elevation: 0.0,
//         centerTitle: false,
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(
//             Icons.keyboard_backspace_rounded,
//           ).marginOnly(left: 26, right: 13),
//         ),
//       ),
//     );
//   }

//   Widget bodyData(context) {
//     return GetBuilder<SelectSubscriptionController>(
//         init: SelectSubscriptionController(),
//         builder: (_) {
//           return GestureDetector(
//             onTap: () {
//               _.isContainerShown = false;
//               _.update();
//             },
//             child: Container(
//               height: Get.height,
//               width: Get.width,
//               color: Color(0xff1E202B),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xffBDBDBD)),
//                       color: Color(0xff1E202B),
//                       // color: Colors.white,

//                       // color: Color.fromRGBO(45, 47, 58, 1),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Row(
//                       children: [
//                         Flexible(
//                           child: CommonTextField2(
//                               readOnly: true,
//                               hintText: "Select Information Type",
//                               controller: _.information,
//                               onTap: () {
//                                 _.isContainerShown = true;
//                                 _.update();
//                               }),
//                         ),
//                       ],
//                     ),
//                   ).marginOnly(left: 15, right: 15, top: 25),
//                   _.isContainerShown ? selectionContainer() : SizedBox(),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Widget selectionContainer() {
//     return Container(
//       width: Get.width,
//       height: Get.height / 1.5,
//       color: Color(0xff5A5C69),
//       // child: Column(
//       //   children: [
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'TV',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ).marginOnly(top: 8),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Print',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Online Video',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Websites',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Social Media',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Intelligence',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //     ParentChildCheckbox(
//       //       parent: Text(
//       //         'Report Timing',
//       //         style: TextStyle(
//       //             fontFamily: 'Roboto',
//       //             fontSize: 12,
//       //             letterSpacing: 0.7,
//       //             fontWeight: FontWeight.w500,
//       //             color: Colors.white),
//       //       ),
//       //       children: [],
//       //       parentCheckboxColor: Color(0xff22B161),
//       //       childrenCheckboxColor: Color(0xff22B161),
//       //     ),
//       //   ],
//       // ),
//     ).marginOnly(left: 16, right: 16);
//   }
// }

