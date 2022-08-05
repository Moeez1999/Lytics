// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:video_trimmer/video_trimmer.dart';
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Trimmer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Trimmer"),
//       ),
//       body: Center(
//         child: Container(
//           child: ElevatedButton(
//             child: Text("LOAD VIDEO"),
//             onPressed: () async {
//               FilePickerResult? result = await FilePicker.platform.pickFiles(
//                 type: FileType.video,
//                 allowCompression: false,
//               );
//               if (result != null) {
//                 File file = File(result.files.single.path!);
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) {
//                     return TrimmerView(file);
//                   }),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TrimmerView extends StatefulWidget {
//   final File file;
//
//   TrimmerView(this.file);
//
//   @override
//   _TrimmerViewState createState() => _TrimmerViewState();
// }
//
// class _TrimmerViewState extends State<TrimmerView> {
//   final Trimmer _trimmer = Trimmer();
//
//   double _startValue = 0.0;
//   double _endValue = 0.0;
//
//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//
//   Future<String?> saveVideo() async {
//     setState(() {
//       _progressVisibility = true;
//     });
//
//     String? _value;
//
//     await _trimmer
//         .saveTrimmedVideo(
//             startValue: _startValue,
//             endValue: _endValue,
//             onSave: (String? outputPath) {})
//         .then((value) {
//       setState(() {
//         _progressVisibility = false;
//         //_value = value;
//       });
//     });
//
//     return _value;
//   }
//
//   void _loadVideo() {
//     _trimmer.loadVideo(videoFile: widget.file);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     _loadVideo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Trimmer"),
//       ),
//       body: Builder(
//         builder: (context) => Center(
//           child: Container(
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.black,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Visibility(
//                   visible: _progressVisibility,
//                   child: LinearProgressIndicator(
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 // ElevatedButton(
//                 //   onPressed: _progressVisibility
//                 //       ? null
//                 //       : () async {
//                 //           _saveVideo().then((outputPath) {
//                 //             print('OUTPUT PATH: $outputPath');
//                 //             final snackBar = SnackBar(
//                 //                 content: Text('Video Saved successfully'));
//                 //             ScaffoldMessenger.of(context).showSnackBar(
//                 //               snackBar,
//                 //             );
//                 //           });
//                 //         },
//                 //   child: Text("SAVE"),
//                 // ),
//                 // Expanded(
//                 //   child: VideoViewer(trimmer: _trimmer),
//                 // ),
//                 Center(
//                   child: TrimEditor(
//                     trimmer: _trimmer,
//                     viewerHeight: 50.0,
//                     viewerWidth: MediaQuery.of(context).size.width,
//                     maxVideoLength: Duration(seconds: 100),
//                     onChangeStart: (value) {
//                       _startValue = value;
//                     },
//                     onChangeEnd: (value) {
//                       _endValue = value;
//                     },
//                     onChangePlaybackState: (value) {
//                       setState(() {
//                         _isPlaying = value;
//                       });
//                     },
//                   ),
//                 ),
//                 TextButton(
//                   child: _isPlaying
//                       ? Icon(
//                           Icons.pause,
//                           size: 80.0,
//                           color: Colors.white,
//                         )
//                       : Icon(
//                           Icons.play_arrow,
//                           size: 80.0,
//                           color: Colors.white,
//                         ),
//                   onPressed: () async {
//                     bool playbackState = await _trimmer.videPlaybackControl(
//                       startValue: _startValue,
//                       endValue: _endValue,
//                     );
//                     setState(() {
//                       _isPlaying = playbackState;
//                     });
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
