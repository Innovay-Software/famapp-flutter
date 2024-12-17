// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import '../models/inno_file_upload_item.dart';
// import './z_camera_shooting_video_preview.dart';
// import '../config.dart';
// import '../utils/debug_utils.dart';
// import '../utils/snack_bar_manager.dart';
// import '../widgets/expanded_children_row.dart';
// import '../widgets/buttons/background_button.dart';
// import '../widgets/buttons/primary_button.dart';
// import '../../innovay/widgets/app_bar.dart';
//
// class CameraShootingVideoPage extends StatefulWidget {
//   final String title;
//   final Function(InnovayFileUploadItemModel) successCallback;
//   const CameraShootingVideoPage({super.key, required this.successCallback, this.title = ''});
//
//   @override
//   State<CameraShootingVideoPage> createState() => _CameraShootingVideoPageState();
// }
//
// class _CameraShootingVideoPageState extends State<CameraShootingVideoPage> {
//   bool _cameraInitialized = false;
//   bool _isFrontCamera = true;
//   bool _isRecording = false;
//   XFile? _photoFile;
//   late CameraDescription _camera;
//   late CameraController _cameraController;
//   late Future<void> _initializeControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       selectCamera();
//     });
//   }
//
//   void selectCamera() async {
//     DebugManager.log("getCameras");
//     final cameras = await availableCameras();
//     if (cameras.isEmpty) {
//       return SnackBarManager.displayMessage('未检测到摄像头');
//     }
//     for (var camera in cameras) {
//       if (_isFrontCamera && camera.lensDirection == CameraLensDirection.back) {
//         onCameraSelected(camera);
//         return;
//       }
//       if (!_isFrontCamera && camera.lensDirection == CameraLensDirection.front) {
//         onCameraSelected(camera);
//         return;
//       }
//     }
//     onCameraSelected(cameras.first);
//     return;
//   }
//
//   void onCameraSelected(CameraDescription camera) {
//     _camera = camera;
//     _cameraController = CameraController(
//       _camera,
//       ResolutionPreset.medium,
//       imageFormatGroup: ImageFormatGroup.yuv420,
//     );
//     _initializeControllerFuture = _cameraController.initialize();
//     setState(() {
//       _cameraInitialized = true;
//     });
//   }
//
//   void onRecordVideoTap() async {
//     if (_isRecording) {
//       final file = await _cameraController.stopVideoRecording();
//       DebugManager.log(file.path);
//       setState(() => _isRecording = false);
//       final route = MaterialPageRoute(
//         fullscreenDialog: true,
//         builder: (_) => CameraShootingVideoPreviewPage(
//             filePath: file.path,
//             successCallback: () {
//               Navigator.pop(context);
//               widget.successCallback(InnovayFileUploadItemModel(file.path, '', false, false));
//             }),
//       );
//       Navigator.push(context, route);
//     } else {
//       await _cameraController.prepareForVideoRecording();
//       await _cameraController.startVideoRecording();
//       setState(() => _isRecording = true);
//     }
//   }
//
//   // void onTakePhotoTap() async {
//   //   DebugManager.Log("onTakePhotoTap");
//   //   try {
//   //     await _initializeControllerFuture;
//   //     _photoFile = await _cameraController.takePicture();
//   //     DebugManager.Log("file path: ${_photoFile!.path}");
//   //     setState(() {});
//   //     // widget.successCallback(image);
//   //   } catch (e) {
//   //     DebugManager.Log(e.toString());
//   //   }
//   // }
//
//   void onConfirmPhotoTap() {
//     if (_photoFile == null) return;
//     widget.successCallback(InnovayFileUploadItemModel(_photoFile!.path, '', false, false));
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: InnovayAppBar(false, widget.title, []),
//         backgroundColor: InnovayConfig.colors.backgroundColor,
//         body: Container(
//             color: Colors.black,
//             child: Stack(children: [
//               _cameraInitialized
//                   ? FutureBuilder<void>(
//                       future: _initializeControllerFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           // If the Future is complete, display the preview.
//                           return Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [CameraPreview(_cameraController)]);
//                         } else {
//                           // Otherwise, display a loading indicator.
//                           return const Center(child: CircularProgressIndicator());
//                         }
//                       },
//                     )
//                   : const SizedBox.shrink(),
//               Positioned(
//                   bottom: MediaQuery.of(context).padding.bottom + 15,
//                   left: 0,
//                   right: 0,
//                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     Expanded(child: Container()),
//                     Expanded(
//                       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                         Container(
//                             decoration:
//                                 BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
//                             width: 60,
//                             height: 60,
//                             child: IconButton(
//                                 padding: const EdgeInsets.all(0),
//                                 onPressed: onRecordVideoTap,
//                                 icon: Icon(
//                                     _isRecording
//                                         ? Icons.stop_circle_rounded
//                                         : Icons.fiber_manual_record_rounded,
//                                     size: 60,
//                                     color: Colors.red)))
//                       ]),
//                     ),
//                     Expanded(
//                         child: SizedBox(
//                             height: 80,
//                             child: IconButton(
//                                 onPressed: () {
//                                   if (_isRecording) {
//                                     return;
//                                   }
//                                   _isFrontCamera = !_isFrontCamera;
//                                   selectCamera();
//                                 },
//                                 icon: const Icon(Icons.cameraswitch, size: 36, color: Colors.white)))),
//                   ])),
//               _photoFile == null
//                   ? const SizedBox.shrink()
//                   : Positioned(
//                       left: 0,
//                       right: 0,
//                       top: 0,
//                       bottom: MediaQuery.of(context).padding.bottom + 10,
//                       child: Container(
//                           color: Colors.black,
//                           child: Column(children: [
//                             Expanded(
//                                 child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//                               Image.file(File(_photoFile!.path)),
//                             ])),
//                             Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                                 child: ExpandedChildrenRow(params: '15-c-c', children: [
//                                   InnovayBackgroundButton(
//                                     '',
//                                     InnovayConfig.colors.textColor,
//                                     () {
//                                       setState(() {
//                                         _photoFile = null;
//                                       });
//                                     },
//                                     prefixWidget: const Icon(Icons.refresh),
//                                   ),
//                                   InnovayPrimaryButton('', onConfirmPhotoTap,
//                                       prefixWidget: const Icon(Icons.check)),
//                                 ]))
//                           ])))
//             ])));
//   }
// }
