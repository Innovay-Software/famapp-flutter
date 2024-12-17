// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import '../widgets/innovay_text.dart';
//
// class CameraShootingVideoPreviewPage extends StatefulWidget {
//   final String filePath;
//   final Function() successCallback;
//
//   const CameraShootingVideoPreviewPage({super.key, required this.filePath, required this.successCallback});
//
//   @override
//   State<CameraShootingVideoPreviewPage> createState() => _CameraShootingVideoPreviewPageState();
// }
//
// class _CameraShootingVideoPreviewPageState extends State<CameraShootingVideoPreviewPage> {
//   late VideoPlayerController _videoPlayerController;
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   Future _initVideoPlayer() async {
//     _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
//     await _videoPlayerController.initialize();
//     await _videoPlayerController.setLooping(true);
//     await _videoPlayerController.play();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const InnovayText('预览', color: Colors.white),
//         elevation: 0,
//         backgroundColor: Colors.black26,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: () {
//               Navigator.pop(context);
//               widget.successCallback();
//             },
//           )
//         ],
//       ),
//       extendBodyBehindAppBar: true,
//       body: FutureBuilder(
//         future: _initVideoPlayer(),
//         builder: (context, state) {
//           if (state.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return VideoPlayer(_videoPlayerController);
//           }
//         },
//       ),
//     );
//   }
// }
