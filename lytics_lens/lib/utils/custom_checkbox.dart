// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lytics_lens/Controllers/searchScreen_controller.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class ParentChildCheckbox extends StatefulWidget {
//   final Text? parent;
//   final List<Text>? children;

//   ///Color of Parent CheckBox
//   ///
//   ///Defaults to [ThemeData.toggleableActiveColor].
//   final Color? parentCheckboxColor;

//   ///Color of Parent CheckBox
//   ///
//   ///Defaults to [ThemeData.toggleableActiveColor].
//   final Color? childrenCheckboxColor;

//   ///Default constructor of ParentChildCheckbox
//   ParentChildCheckbox({
//     required this.parent,
//     required this.children,
//     this.parentCheckboxColor,
//     this.childrenCheckboxColor,
//   });
//   static Map<String?, bool?> _isParentSelected = {};
//   static get isParentSelected => _isParentSelected;
//   static Map<String?, List<String?>> _selectedChildrenMap = {};
//   static get selectedChildrens => _selectedChildrenMap;
//   @override
//   _ParentChildCheckboxState createState() => _ParentChildCheckboxState();
// }

// class _ParentChildCheckboxState extends State<ParentChildCheckbox> {
//   ///Default parentValue set to false
//   bool? _parentValue = false;
//   final SearchController controller = Get.put(SearchController());

//   ///List of childrenValue which depicts whether checkbox is clicked or not
//   List<bool?> _childrenValue = [];
//   @override
//   void initState() {
//     super.initState();
//     _childrenValue = List.filled(widget.children!.length, false);
//     ParentChildCheckbox._selectedChildrenMap.addAll({widget.parent!.data: []});
//     ParentChildCheckbox._isParentSelected.addAll({widget.parent!.data: false});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             // IconButton(
//             //     onPressed: () {
//             //       setState(() {
//             //         if (controller.isExpanded1 == false) {
//             //           controller.isExpanded1 = true;
//             //           print(
//             //               'The Value of box on tap is ${controller.isExpanded1}');
//             //         } else {
//             //           controller.isExpanded1 = false;
//             //           print(
//             //               'Else The Value of box on tap is ${controller.isExpanded1}');
//             //         }
//             //       });
//             //     },
//             //     icon: Icon(
//             //         controller.isExpanded1 == true
//             //             ? FontAwesomeIcons.caretDown
//             //             : FontAwesomeIcons.caretRight,
//             //         color: Colors.white),),

//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   if (controller.isExpanded1 == false) {
//                     controller.isExpanded1 = true;
//                     print(
//                         'The Value of box on tap is ${controller.isExpanded1}');
//                   } else {
//                     controller.isExpanded1 = false;
//                     print(
//                         'Else The Value of box on tap is ${controller.isExpanded1}');
//                   }
//                 });
//               },
//               child:  controller.isExpanded1 == false?Container(
//                 height: 15,
//                 width: 15,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/polygon.png'),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ).marginOnly(left: 15):Container(
//                 height: 15,
//                 width: 15,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/Polygon2.png'),
//                     fit: BoxFit.contain,
//                   ),
//                 ),


//               ).marginOnly(left: 15),
//             ),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Checkbox(
//                 value: _parentValue,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4.0)),
//                 splashRadius: 0.0,
//                 activeColor: widget.parentCheckboxColor,
//                 onChanged: (value) => _parentCheckBoxClick(),
//                 tristate: true,
//                 visualDensity:   VisualDensity(horizontal: -3.5, vertical: -2.5),
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 side: BorderSide(color: Colors.white,),

//               ),
//             ),
//             widget.parent!,
//           ],
//         ),
//         for (int i = 0; i < widget.children!.length; i++)
//           controller.isExpanded1 == true
//               ? Padding(
//                   padding: EdgeInsets.only(left: 65.0),
//                   child: Row(
//                     children: [
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4.0)),
//                         splashRadius: 0.0,
//                         activeColor: widget.childrenCheckboxColor,
//                         value: _childrenValue[i],
//                         onChanged: (value) => _childCheckBoxClick(i),
//                         visualDensity:   VisualDensity(horizontal: -3.5, vertical: -2.5),
//                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         side: BorderSide(color: Colors.white,),


//                       ),
//                       widget.children![i],
//                     ],
//                   ),
//                 )
//               : SizedBox(),
//       ],
//     );
//   }

//   ///onClick method when particular children of index i is clicked
//   void _childCheckBoxClick(int i) {
//     setState(() {
//       _childrenValue[i] = !_childrenValue[i]!;
//       if (!_childrenValue[i]!) {
//         ParentChildCheckbox._selectedChildrenMap.update(widget.parent!.data,
//             (value) {
//           value.removeWhere((element) => element == widget.children![i].data);
//           return value;
//         });
//       } else {
//         ParentChildCheckbox._selectedChildrenMap.update(widget.parent!.data,
//             (value) {
//           value.add(widget.children![i].data);
//           return value;
//         });
//       }
//       _parentCheckboxUpdate();
//     });
//   }

//   ///onClick method when particular parent is clicked
//   void _parentCheckBoxClick() {
//     setState(() {
//       if (_parentValue != null) {
//         _parentValue = !_parentValue!;
//         ParentChildCheckbox._isParentSelected
//             .update(widget.parent!.data, (value) => _parentValue);
//         ParentChildCheckbox._selectedChildrenMap.addAll({
//           widget.parent!.data: [],
//         });
//         for (int i = 0; i < widget.children!.length; i++) {
//           _childrenValue[i] = _parentValue;
//           if (_parentValue!) {
//             ParentChildCheckbox._selectedChildrenMap.update(widget.parent!.data,
//                 (value) {
//               value.add(widget.children![i].data);
//               return value;
//             });
//           }
//         }
//       } else {
//         _parentValue = false;
//         ParentChildCheckbox._isParentSelected
//             .update(widget.parent!.data, (value) => _parentValue);
//         ParentChildCheckbox._selectedChildrenMap
//             .update(widget.parent!.data, (value) => []);
//         for (int i = 0; i < widget.children!.length; i++)
//           _childrenValue[i] = false;
//       }
//     });
//   }

//   ///Method to update the Parent Checkbox based on the status of Child checkbox
//   void _parentCheckboxUpdate() {
//     setState(() {
//       if (_childrenValue.contains(false) && _childrenValue.contains(true)) {
//         _parentValue = null;
//         ParentChildCheckbox._isParentSelected
//             .update(widget.parent!.data, (value) => false);
//       } else {
//         _parentValue = _childrenValue.first;
//         ParentChildCheckbox._isParentSelected
//             .update(widget.parent!.data, (value) => _childrenValue.first);
//       }
//     });
//   }
// }
