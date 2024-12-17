// import 'dart:io';
//
// import 'package:cached_video_player/cached_video_player.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// import '../../../innovay/config.dart';
// import '../../../innovay/utils/debug_utils.dart';
// import '../../../innovay/widgets/cached_image.dart';
// import '../../../innovay/widgets/innovay_text.dart';
// import '../../models/album_file.dart';
//
// class MediaSlideShowItemCleanWidget extends StatefulWidget {
//   final FolderFileModel folderFile;
//
//   const MediaSlideShowItemCleanWidget({super.key, required this.folderFile});
//
//   @override
//   State<MediaSlideShowItemCleanWidget> createState() => _MediaSlideShowItemCleanWidgetState();
// }
//
// class _MediaSlideShowItemCleanWidgetState extends State<MediaSlideShowItemCleanWidget> {
//   CachedVideoPlayerController? _videoController;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (widget.folderFile.fileType == 'video') {
//         // DebugManager.log("VideoContent: ${widget.folderFile.fileUrl} ${widget.folderFile.fileUrlHeaders}");
//         if (widget.folderFile.fileUrl.startsWith('http')) {
//           DebugManager.log("Video HTTP: ${widget.folderFile.fileUrl}");
//           _videoController = CachedVideoPlayerController.network(
//               widget.folderFile.fileUrl,
//               httpHeaders: widget.folderFile.fileUrlHeaders)
//             ..initialize().then((_) {
//               _videoController!.play();
//               _videoController!.setLooping(true);
//               if (!mounted) return;
//               setState(() {});
//             });
//         } else {
//           DebugManager.log("Video file: ${widget.folderFile.fileUrl}");
//           _videoController = CachedVideoPlayerController.file(File(widget.folderFile.fileUrl))
//             ..initialize().then((_) {
//               _videoController!.play();
//               _videoController!.setLooping(true);
//               if (!mounted) return;
//               setState(() {});
//             });
//         }
//         _videoController!.addListener(() {
//           if (!mounted) return;
//           setState(() {});
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     if (widget.folderFile.fileType == 'video') {
//       _videoController?.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.folderFile.fileType == 'image') {
//       return Stack(children: [
//         // if (_isLoading)
//         Center(
//           child: InnovayCachedImage(
//             widget.folderFile.thumbnailUrl,
//             cacheKey: widget.folderFile.cacheKeyThumbnail,
//             httpHeaders: widget.folderFile.thumbnailUrlHeaders,
//             fit: BoxFit.contain,
//             loadingBackgroundColor: Colors.black,
//             loadingForegroundColor: Colors.white,
//             placeholderWidget: const SizedBox.shrink(),
//           ),
//         ),
//         Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: ExtendedImage.network(
//               widget.folderFile.fileUrl,
//               cacheKey: widget.folderFile.cacheKeyFile,
//               headers: widget.folderFile.fileUrlHeaders,
//               fit: BoxFit.contain,
//               cacheMaxAge: const Duration(days: 365),
//               handleLoadingProgress: true,
//               loadStateChanged: (ExtendedImageState state) {
//                 if (state.extendedImageLoadState == LoadState.loading) {
//                   return Center(child: LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 30));
//                 }
//                 if (_isLoading && state.extendedImageLoadState == LoadState.completed) {
//                   _isLoading = false;
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     if (mounted) setState(() {});
//                   });
//                   return null;
//                 }
//                 return null;
//               },
//             )),
//       ]);
//     }
//
//     if (widget.folderFile.fileType == 'video') {
//       if (_videoController == null) {
//         return Stack(children: [
//           Center(
//             child: InnovayCachedImage(
//               widget.folderFile.thumbnailUrl,
//               httpHeaders: widget.folderFile.thumbnailUrlHeaders,
//               cacheKey: widget.folderFile.cacheKeyThumbnail,
//               loadingBackgroundColor: Colors.black,
//               loadingForegroundColor: Colors.white,
//               fit: BoxFit.contain,
//             ),
//           ),
//           Center(child: LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 50)),
//         ]);
//       }
//       return Stack(children: [
//         if (_videoController!.value.isInitialized)
//           Center(
//             child: AspectRatio(
//               aspectRatio: _videoController!.value.aspectRatio,
//               child: CachedVideoPlayer(_videoController!),
//             ),
//           ),
//         if (!_videoController!.value.isInitialized || _videoController!.value.isBuffering)
//           Center(
//             child: Stack(
//               children: [
//                 // Center(child: CachedNetworkImage(imageUrl: thumbnailUrl)),
//                 Center(
//                   child: Container(
//                     child: LoadingAnimationWidget.threeArchedCircle(
//                       color: Colors.white,
//                       size: 50,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         if (_videoController!.value.isInitialized && !_videoController!.value.isPlaying)
//           const Center(child: Icon(Icons.play_circle, color: Colors.white, size: 60)),
//         if (_videoController!.value.isInitialized)
//           Positioned(
//             left: 30,
//             right: 30,
//             bottom: 88,
//             child: VideoProgressIndicator(
//               _videoController!,
//               allowScrubbing: true,
//               padding: const EdgeInsets.only(top: 30, bottom: 30),
//               colors: VideoProgressColors(playedColor: InnovayConfig.colors.primaryColorLighter),
//             ),
//           ),
//         Positioned.fill(
//           child: GestureDetector(
//             onTap: () {
//               if (!_videoController!.value.isInitialized) return;
//               setState(() {
//                 _videoController!.value.isPlaying ? _videoController!.pause() : _videoController!.play();
//               });
//             },
//           ),
//         ),
//       ]);
//     }
//
//     return InnovayText('Unrecognized file type: ${widget.folderFile.fileType}', color: Colors.white);
//   }
// }
