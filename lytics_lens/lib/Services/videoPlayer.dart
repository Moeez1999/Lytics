// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerClass extends StatefulWidget {
//
//   final VideoPlayerController videoPlayerController;
//   final bool looping;
//
//   VideoPlayerClass (this.looping, this.videoPlayerController);
//
//   @override
//   _VideoPlayerClassState createState() => _VideoPlayerClassState();
// }
//
// class _VideoPlayerClassState extends State<VideoPlayerClass> {
//
//   var  _chewieController;
//
//   @override
//
//   void initState(){
//     super.initState();
//     _chewieController=ChewieController(
//       videoPlayerController: widget.videoPlayerController,
//       aspectRatio: 16/10,
//       autoInitialize: true,
//       looping: widget.looping,
//       errorBuilder: (context,errorMessage){
//         return Center(
//           child: Text(errorMessage,style: TextStyle(color: Colors.white),),
//         );
//       }
//     );
//   }
//
//   void dispose(){
//     super.dispose();
//     widget.videoPlayerController.dispose();
//     _chewieController.dispose();
//   }
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(0.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         child: Chewie(controller: _chewieController)),
//     );
//   }
// }