// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lytics_lens/Constants/common_color.dart';
// import 'package:lytics_lens/Controllers/sign_up_controller.dart';
// import 'package:lytics_lens/views/Components/widget/common_textfield.dart';
// import 'package:dropdown_search/dropdown_search.dart';


// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: bodyData(context),
//       ),
//     );
//   }

//   Widget bodyData(context) {
//     return GetBuilder<SignUpController>(
//         init: SignUpController(),
//         builder: (_) {
//           return Container(
//             height: Get.height,
//             width: Get.width,
//             color: CommonColor.registrationBackground,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage("assets/images/profile_image.png"),
//                         backgroundColor: Colors.transparent,
//                       ).marginOnly(top: 26),
//                       Container(
//                         height: 45,
//                         width: 45,
//                         child: CircleAvatar(
//                           backgroundColor: Color(0xff22b161),
//                           child:Container(
//                             height: 30,
//                             width: 30,
//                             child: CircleAvatar(
//                               backgroundColor: Color(0xff22b161),

//                               backgroundImage: AssetImage("assets/images/camera.png"),


//                             ),
//                           ),



//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     child: Text(
//                       "Add Profile Photo",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 14,
//                         fontFamily: 'Roboto',
//                         letterSpacing: 0.4,
//                         color: Color(0xffc4c4c4).withOpacity(0.65),
//                       ),
//                     ),
//                   ).marginOnly(top: 10),
//                   Container(
//                     child: Text(
//                       "Personal Details",
//                       style: TextStyle(
//                           fontFamily: 'Roboto',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white),
//                     ),
//                   ).marginOnly(top: 23),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Row(
//                             children: [
//                               Flexible(
//                                   child: CommonTextField(
//                                       controller: _.firstName,hintText: "First Name",hintTextColor: CommonColor.hintTextColor,

//                                   )
//                                       .marginOnly(right: 3)),
//                               Flexible(
//                                   child: CommonTextField(controller: _.lastName,hintText: "Last Name",hintTextColor: CommonColor.hintTextColor,)
//                                       .marginOnly(left: 3)),
//                             ],
//                           ).marginOnly(top: 12),
//                         ),
//                       ),
//                     ],
//                   ).marginOnly(right: 28),
//                   Container(width: Get.width/2.35,child: CommonTextField(controller: _.contactNumber,hintText: "Contact Number",hintTextColor:CommonColor.hintTextColor)).marginOnly(top: 20),
//                   Container(width: Get.width/1.7,child: CommonTextField(controller: _.email,hintText: "Personal Email",hintTextColor:CommonColor.hintTextColor)).marginOnly(top: 20),

//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Row(
//                             children: [
//                               Flexible(
//                                   child: Container(
//                                     height: 48,
//                                     decoration:BoxDecoration(
//                                     border: Border.all(color: Colors.green),
//                                       borderRadius: BorderRadius.circular(4),
//                                       color:Color.fromRGBO(45, 47, 58, 1),


//                                     ),
//                                     padding: EdgeInsets.only(left: 10,bottom: 0),
//                                     child: DropdownSearch<String>(
//                                       mode: Mode.MENU,
//                                       dropDownButton:  Icon(Icons.arrow_drop_down, size: 24,color:Color(0xff28C66E),),
//                                       showSelectedItems: true,
//                                       items: ["Male", "Female"],
//                                       dropdownSearchDecoration: InputDecoration(
//                                         hintText: "Gender",
//                                         hintStyle: TextStyle(color: CommonColor.hintTextColor),
//                                       ),
//                                       onChanged: print,
//                                       //selectedItem: "Gender",

//                                     ),
//                                   ),


//                                       ),
//                               Flexible(
//                                   child: CommonTextField(controller: _.age,hintText: "Age",hintTextColor: CommonColor.hintTextColor,)
//                                       .marginOnly(left: 3,right: 2)),
//                               Flexible(
//                                 child: Container(
//                                   height: 48,
//                                   decoration:BoxDecoration(
//                                     border: Border.all(color: Colors.green),
//                                     borderRadius: BorderRadius.circular(4),
//                                     color:Color.fromRGBO(45, 47, 58, 1),


//                                   ),
//                                   padding: EdgeInsets.only(left: 10,bottom: 0),
//                                   child: DropdownSearch<String>(
//                                     mode: Mode.MENU,
//                                     dropDownButton:  Icon(Icons.arrow_drop_down, size: 24,color:Color(0xff28C66E),),
//                                     showSelectedItems: true,
//                                     items: ["Lahore", "Peshawar", "Quetta", 'Islamabad'],
//                                     dropdownSearchDecoration: InputDecoration(
//                                       hintText: "Location",
//                                       hintStyle: TextStyle(color: CommonColor.hintTextColor),
//                                     ),
//                                     onChanged: print,
//                                     //selectedItem: "Gender",

//                                   ),
//                                 ).marginOnly(left: 2),


//                               ),
//                             ],
//                           ).marginOnly(top: 12),
//                         ),
//                       ),
//                     ],
//                   ).marginOnly(right: 28),

//                   Container(
//                     child: Text(
//                       "Company Details",
//                       style: TextStyle(
//                           fontFamily: 'Roboto',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white),
//                     ),
//                   ).marginOnly(top: 23),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Row(
//                             children: [
//                               Flexible(
//                                   child: CommonTextField(
//                                     controller: _.companyName,hintText: "Name of Company",hintTextColor: CommonColor.hintTextColor

//                                   )
//                                       .marginOnly(right: 3)),
//                               Flexible(
//                                   child: CommonTextField(controller: _.lastName,hintText: "Type of Business",hintTextColor: CommonColor.hintTextColor)
//                                       .marginOnly(left: 3)),
//                             ],
//                           ).marginOnly(top: 12),
//                         ),
//                       ),
//                     ],
//                   ).marginOnly(right: 28),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 child: Container(
//                                   height: 48,
//                                   decoration:BoxDecoration(
//                                     border: Border.all(color: Colors.green),
//                                     borderRadius: BorderRadius.circular(4),
//                                     color:Color.fromRGBO(45, 47, 58, 1),


//                                   ),
//                                   padding: EdgeInsets.only(left: 10,bottom: 0),
//                                   child: DropdownSearch<String>(
//                                     mode: Mode.MENU,
//                                     dropDownButton:  Icon(Icons.arrow_drop_down, size: 24,color:Color(0xff28C66E),),
//                                     showSelectedItems: true,
//                                     items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//                                     dropdownSearchDecoration: InputDecoration(
//                                       hintText: "No. of Employees",
//                                       hintStyle: TextStyle(color: CommonColor.hintTextColor),
//                                     ),
//                                     onChanged: print,
//                                     //selectedItem: "Gender",

//                                   ),
//                                 ),


//                               ),
//                               Flexible(
//                                   child: CommonTextField(controller: _.departmentName,hintText: "Department Name",hintTextColor: CommonColor.hintTextColor)
//                                       .marginOnly(left: 3)),
//                             ],
//                           ).marginOnly(top: 12),
//                         ),
//                       ),
//                     ],
//                   ).marginOnly(right: 28),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Row(
//                             children: [
//                               Flexible(
//                                   child: CommonTextField(
//                                     controller: _.companyName,hintText: "Office Address",hintTextColor: CommonColor.hintTextColor,

//                                   )
//                                       .marginOnly(right: 3),),

//                             ],
//                           ).marginOnly(top: 12),
//                         ),
//                       ),
//                     ],
//                   ).marginOnly(right: 28),

//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Row(
//                             children: [
//                               Flexible(
//                                   child: CommonTextField(
//                                     controller: _.officeEmail,hintText: "Office Email",hintTextColor: CommonColor.hintTextColor

//                                   )
//                                       .marginOnly(right: 3)),
//                               Flexible(
//                                   child: CommonTextField(controller: _.officeContact,hintText: "Office Contact",hintTextColor: CommonColor.hintTextColor,)
//                                       .marginOnly(left: 3)),
//                             ],
//                           ).marginOnly(top: 12),
//                         ),
//                       ),
//                     ],
//                   ).marginOnly(right: 28),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       //color: CommonColor.loginAndSendCodeButtonColor,
//                       width: 162,
//                       height: 48,
//                       child: MaterialButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(9.0),
//                           side: BorderSide(
//                             color: Color(0xff23B662),
//                           ),
//                         ),

//                         onPressed: () async {
//                         },
//                         child: Text(
//                           "SUBMIT",
//                           textScaleFactor: 1.0,
//                           style: TextStyle(
//                               color: Color(0xff2CE08E),
//                               letterSpacing: 0.4,
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w700),
//                           maxLines: 2,
//                         ),
//                         minWidth: Get.width / 3,
//                         height: 40,
//                         // color: Color.fromRGBO(72, 190, 235, 1),
//                         color: Color(0xff23B662).withOpacity(0.1),
//                       ),
//                     ).marginOnly(top: 26,bottom: 15),
//                   ),









//                 ],
//               ).marginOnly(left: 27),
//             ),
//           );
//         });
//   }
// }
