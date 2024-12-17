// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import '../config.dart';
// import '../utils/debug_utils.dart';
// import '../utils/snack_bar_manager.dart';
// import '../widgets/app_bar.dart';
// import '../widgets/buttons/background_button.dart';
// import '../widgets/expanded_children_row.dart';
// import '../widgets/buttons/primary_button.dart';
//
// class CameraShootingPhotoPage extends StatefulWidget {
//   final String title;
//   final Function(String) successCallback;
//   const CameraShootingPhotoPage({super.key, required this.successCallback, this.title = ''});
//
//   @override
//   State<CameraShootingPhotoPage> createState() => _CameraShootingPhotoPageState();
// }
//
// class _CameraShootingPhotoPageState extends State<CameraShootingPhotoPage> {
//   bool _cameraInitialized = false;
//   bool _isFrontCamera = true;
//   XFile? _photoFile;
//   CameraController? _cameraController;
//   late CameraDescription _camera;
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
//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }
//
//   void selectCamera() async {
//     DebugManager.log("getCameras");
//     final cameras = await availableCameras();
//     if (cameras.isEmpty) {
//       return SnackBarManager.displayMessage('camera not found');
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
//     _initializeControllerFuture = _cameraController!.initialize();
//     setState(() {
//       _cameraInitialized = true;
//     });
//   }
//
//   void onTakePhotoTap() async {
//     DebugManager.log("onTakePhotoTap");
//     try {
//       await _initializeControllerFuture;
//       _photoFile = await _cameraController!.takePicture();
//       DebugManager.log("file path: ${_photoFile!.path}");
//       setState(() {});
//     } catch (e) {
//       DebugManager.log(e.toString());
//     }
//   }
//
//   void onConfirmPhotoTap() {
//     widget.successCallback(_photoFile == null ? '' : _photoFile!.path);
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
//               _cameraInitialized && _cameraController != null
//                   ? FutureBuilder<void>(
//                       future: _initializeControllerFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [CameraPreview(_cameraController!)]);
//                         } else {
//                           return const Center(child: CircularProgressIndicator());
//                         }
//                       },
//                     )
//                   : const SizedBox.shrink(),
//               Positioned(
//                   bottom: MediaQuery.of(context).padding.bottom + 15,
//                   left: 0,
//                   right: 0,
//                   child: Row(children: [
//                     Expanded(child: Container()),
//                     Expanded(
//                       child: IconButton(
//                           onPressed: onTakePhotoTap,
//                           icon: const Icon(Icons.camera_alt_outlined, size: 42, color: Colors.white)),
//                     ),
//                     Expanded(
//                       child: IconButton(
//                           onPressed: () {
//                             _isFrontCamera = !_isFrontCamera;
//                             selectCamera();
//                           },
//                           icon: const Icon(Icons.cameraswitch, size: 36, color: Colors.white)),
//                     ),
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
