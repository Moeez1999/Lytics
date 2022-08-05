// import 'package:flutter/material.dart';
// import 'package:skeletons/skeletons.dart';
//
// class ShimmerCommon extends StatelessWidget {
//   const ShimmerCommon({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: 7,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           padding: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(color: Colors.transparent),
//           child: SkeletonTheme(
//             themeMode: ThemeMode.dark,
//             darkShimmerGradient: LinearGradient(
//               colors: [
//                 Color(0xFF545663),
//                 Color(0xFF545663),
//                 Color(0xFF545663),
//                 Color(0xFF545663),
//                 Color(0xFF545663),
//               ],
//               stops: [
//                 0.0,
//                 0.2,
//                 0.5,
//                 0.8,
//                 1,
//               ],
//               begin: Alignment(-2.4, -0.2),
//               end: Alignment(2.4, 0.2),
//               tileMode: TileMode.clamp,
//             ),
//             child: SkeletonItem(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SkeletonAvatar(
//                     style: SkeletonAvatarStyle(
//                         shape: BoxShape.rectangle, width: 120, height: 100),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SkeletonParagraph(
//                         style: SkeletonParagraphStyle(
//                             lines: 1,
//                             spacing: 6,
//                             lineStyle: SkeletonLineStyle(
//                               height: 15,
//                               borderRadius: BorderRadius.circular(10),
//                               maxLength: MediaQuery.of(context).size.width / 15,
//                               width: 150,
//                             )),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       SkeletonParagraph(
//                         style: SkeletonParagraphStyle(
//                             lines: 2,
//                             spacing: 6,
//                             lineStyle: SkeletonLineStyle(
//                               height: 15,
//                               borderRadius: BorderRadius.circular(10),
//                               maxLength: MediaQuery.of(context).size.width / 15,
//                               width: 180,
//                             )),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
