// import 'dart:isolate';
//
// import 'package:famapp/innovay/global_data.dart';
//
// import '../innovay/models/user.dart';
// import '../innovay/utils/debug_utils.dart';
// import '../innovay/utils/file_utils.dart';
// import '../innovay/utils/snack_bar_manager.dart';
// import '../pages/album/models/folder_file_upload_item_model.dart';
//
// void _startUploadProcessGlobal(List<dynamic> args) async {
//   var sendPort = args[0] as SendPort;
//   var uploadItems = args[1] as List<FolderFileUploadItemModel>;
//   var userToken = args[2] as String;
//   var useRemoteServer = args[3] as bool;
//   InnovayGlobalData.useRemoteServer = useRemoteServer;
//   if (args.length >= 6) {
//     var receivePort = args[4] as ReceivePort;
//     DebugManager.log("_uploadItemsLength: ${uploadItems.length}");
//
//     receivePort.listen((message) {
//       if (message['msg'] == 'cancelJob') {
//         var uploadItemIndex = message['index'];
//         if (uploadItemIndex < uploadItems.length) {
//           uploadItems[uploadItemIndex].cancelUpload();
//         }
//       }
//     });
//   }
//
//   for (var i = 0; i < uploadItems.length; i++) {
//     await uploadItems[i].chunkUploadAndSaveToFolder(userToken, () {
//       sendPort.send({'msg': 'update', 'progressList': uploadItems.map((e) => e.uploadProgress).toList()});
//     });
//   }
//   // SnackBarManager.displayMessage('All files uploaded');
//   DebugManager.log("Isolate: All upload items completed, sending completed message now");
//   sendPort.send({'msg': 'completed'});
// }
//
// class MediaFileUploadService {
//   final List<FolderFileUploadItemModel> uploadItems = [];
//   final List<Function> onAllFilesUploadedCallbacks = [];
//   late ReceivePort isolateReceivePort;
//   late ReceivePort isolateSendPort;
//
//   void onPickMediaTap(int targetFolderId) {
//     FileUtils.pickMediasFromGallery(9, (shotImages) {
//       if (shotImages.isEmpty) return;
//       for (var item in shotImages) {
//         if (item.fileSize > 500000000) {
//           return SnackBarManager.displayMessage('文件超过500MB，无法上传');
//         }
//       }
//       var uploadItems = <FolderFileUploadItemModel>[];
//       for (var item in shotImages) {
//         var uploadItem = FolderFileUploadItemModel(item.localPath, '', false, false, targetFolderId);
//         uploadItems.add(uploadItem);
//       }
//       add(uploadItems);
//     });
//   }
//
//   void add(List<FolderFileUploadItemModel> newUploadItems) async {
//     // DebugManager.log("Current folder id = ${_currentFolder.id}");
//     uploadItems.addAll(newUploadItems);
//
//     for (var item in newUploadItems) {
//       if (item.isVideoFile()) {
//         await item.generateThumbnail();
//       }
//     }
//
//     isolateReceivePort = ReceivePort();
//     isolateSendPort = ReceivePort();
//     final isolate = await Isolate.spawn(
//       _startUploadProcessGlobal,
//       [isolateReceivePort.sendPort, uploadItems, UserModel.instance.accessToken, InnovayGlobalData.useRemoteServer],
//     );
//
//     isolateReceivePort.listen((message) {
//       DebugManager.log("Receive port message: ${message.toString()}");
//       if (message['msg'] == 'update') {
//         DebugManager.log("Update:");
//         List<int> uploadProgressList = message['progressList'];
//         for (var i = 0; i < uploadProgressList.length; i++) {
//           if (i < uploadItems.length) {
//             uploadItems[i].uploadProgress = uploadProgressList[i];
//           }
//         }
//         // setState(() {});
//       } else if (message['msg'] == 'completed') {
//         isolateReceivePort.close();
//         isolate.kill();
//         onAllFilesUploaded();
//         // setState(() {});
//       }
//     });
//
//     // await _startUploadProcess();
//     // uploadItems.clear();
//     // widget.onAlLFilesUploaded();
//     // setState(() {});
//   }
//
//   void onAllFilesUploaded() {
//     SnackBarManager.displayMessage('所有文件均已上传');
//     uploadItems.clear();
//     for (var item in onAllFilesUploadedCallbacks) {
//       item();
//     }
//   }
//
//   double getCurrentUploadProgress() {
//     if (uploadItems.isEmpty) return 100.0;
//     double progress = 0.0;
//     for (var item in uploadItems) {
//       progress += item.uploadProgress / uploadItems.length;
//     }
//     return progress;
//   }
//
//   void cancelJob(int index) {
//     isolateSendPort.sendPort.send({'message': 'cancelJob', 'index': index});
//     uploadItems[index].cancelUpload();
//   }
// }
