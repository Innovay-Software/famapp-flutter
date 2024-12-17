// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:video_player/video_player.dart';
//
// class PhotoGalleryStateFullWidget extends StatefulWidget {
//   const PhotoGalleryStateFullWidget({
//     super.key,
//     required this.initialPhotoIndex,
//   });
//
//   final int initialPhotoIndex;
//
//   @override
//   State<PhotoGalleryStateFullWidget> createState() => PhotoGalleryState(
//       currentPhotoIndex: initialPhotoIndex, pageController: PageController(initialPage: initialPhotoIndex));
// }
//
// class PhotoGalleryState extends State<PhotoGalleryStateFullWidget> with TickerProviderStateMixin {
//   int currentPhotoIndex;
//   PageController pageController;
//   VideoPlayerController _videoController = VideoPlayerController.network('');
//   bool _displayVideo = false;
//
//   PhotoGalleryState({Key? key, required this.currentPhotoIndex, required this.pageController}) : super();
//
//   void onPageChanged(int index) {
//     setState(() {
//       currentPhotoIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.light,
//       // For iOS.
//       // Use [dark] for white status bar and [light] for black status bar.
//       statusBarBrightness: Brightness.dark,
//     ));
//
//     return Dismissible(
//         movementDuration: const Duration(milliseconds: 100),
//         resizeDuration: const Duration(milliseconds: 100),
//         behavior: HitTestBehavior.translucent,
//         background: Container(
//           // color: Colors.transparent,
//           color: Colors.transparent,
//         ),
//         key: const Key('photo_gallery_dismissible'),
//         direction: DismissDirection.vertical,
//         onDismissed: (_) => Navigator.pop(context),
//         dismissThresholds: const {DismissDirection.down: 0.3, DismissDirection.up: 0.5},
//         child: Scaffold(
//           // appBar: AppBar(
//           //   title: Text(
//           //       "${currentPhotoIndex + 1}/${allMediaManager.getMediaCount()}"),
//           //   backgroundColor: Colors.black,
//           //   foregroundColor: Colors.white,
//           // ),
//           body: Stack(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 alignment: Alignment.topCenter,
//                 color: Colors.black,
//                 child: PhotoViewGallery.builder(
//                   scrollPhysics: const BouncingScrollPhysics(),
//                   builder: (BuildContext context, int index) {
//                     return PhotoViewGalleryPageOptions(
//                       imageProvider: NetworkImage('https://innovay.app/img/logos/logo2_190x190.png'),
//                       initialScale: PhotoViewComputedScale.contained * 0.95,
//                       // heroAttributes:
//                       //     PhotoViewHeroAttributes(tag: galleryItems[index].id),
//                     );
//                   },
//                   itemCount: 0,
//                   loadingBuilder: (context, event) => const Center(
//                     child: SizedBox(
//                       width: 20.0,
//                       height: 20.0,
//                       child: CircularProgressIndicator(
//                         // value: event == null
//                         //     ? 0
//                         //     : event.cumulativeBytesLoaded /
//                         //         event.expectedTotalBytes,
//                         value: 0,
//                       ),
//                     ),
//                   ),
//                   // backgroundDecoration: widget.backgroundDecoration,
//                   pageController: pageController,
//                   onPageChanged: onPageChanged,
//                 ),
//               ),
//               Container(
//                 width: _displayVideo ? MediaQuery.of(context).size.width : 0,
//                 height: MediaQuery.of(context).size.height,
//                 alignment: Alignment.center,
//                 color: Colors.black,
//                 child: _displayVideo && _videoController.value.isInitialized
//                     ? AspectRatio(
//                         aspectRatio: _videoController.value.aspectRatio,
//                         child: VideoPlayer(_videoController),
//                       )
//                     : Container(),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _videoController.dispose();
//   }
// }
