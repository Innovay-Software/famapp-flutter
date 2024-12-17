// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import '../config.dart';
//
// class NetworkVideoPreview extends StatefulWidget {
//   final String videoUrl;
//   final double width;
//   final double height;
//
//   const NetworkVideoPreview({
//     super.key,
//     required this.videoUrl,
//     required this.width,
//     required this.height,
//   });
//
//   @override
//   State<NetworkVideoPreview> createState() => _NetworkVideoPreviewState();
// }
//
// class _NetworkVideoPreviewState extends State<NetworkVideoPreview> {
//   late VideoPlayerController _videoController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         _videoController.addListener(() {
//           setState(() {
//             if (!_videoController.value.isPlaying &&
//                 (_videoController.value.duration == _videoController.value.position)) {
//               setState(() {});
//             }
//           });
//         });
//
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       SizedBox(
//           width: widget.width,
//           height: widget.height,
//           child: _videoController.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _videoController.value.aspectRatio,
//                   child: VideoPlayer(_videoController),
//                 )
//               : const Center(
//                   child: CircularProgressIndicator(),
//                 )),
//       GestureDetector(
//           onTap: () {
//             setState(() {
//               _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
//             });
//           },
//           child: _videoController.value.isPlaying
//               ? Container(
//                   width: widget.width,
//                   height: widget.height,
//                   color: Colors.transparent,
//                 )
//               : Container(
//                   color: InnovayConfig.colors.loadingGreyTransparentBackgroundColor,
//                   width: widget.width,
//                   height: widget.height,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           child: Icon(Icons.play_arrow, color: Colors.white, size: 22),
//                         )
//                       ]))),
//     ]);
//   }
// }
