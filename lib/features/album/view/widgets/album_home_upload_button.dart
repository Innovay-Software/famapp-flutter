// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// import '../../../innovay/config.dart';
// import '../../../innovay/global_data.dart';
// import '../../../innovay/utils/debug_utils.dart';
// import '../../../innovay/widgets/innovay_text.dart';
// import '../../../pages/album_file_uploader_page.dart';
// import '../../../services/media_file_upload_service.dart';
// import '../../models/album.dart';
//
// class AlbumHomeUploadButton extends StatefulWidget {
//   final List<FolderModel> folders;
//   final FolderModel currentFolder;
//   final Function(FolderModel) onCurrentFolderChanged;
//   final int Function() getCurrentFolderId;
//
//   const AlbumHomeUploadButton({
//     super.key,
//     required this.folders,
//     required this.currentFolder,
//     required this.onCurrentFolderChanged,
//     required this.getCurrentFolderId,
//   });
//
//   @override
//   State<AlbumHomeUploadButton> createState() => _AlbumHomeUploadButtonState();
// }
//
// class _AlbumHomeUploadButtonState extends State<AlbumHomeUploadButton> {
//   final MediaFileUploadService _mediaFileUploader = InnovayGlobalData.mediaFileUploader;
//   late Timer _periodicUpdateTimer;
//   // final List<FolderFileUploadItemModel> _uploadItems = [];
//   // late FolderModel _currentFolder;
//   // bool _showUploadItemsRow = false;
//
//   @override
//   void initState() {
//     super.initState();
//     DebugManager.log("_AlbumHomeUploadButtonState");
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _periodicUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         _refreshPage();
//       });
//     });
//     // _currentFolder = widget.currentFolder;
//
//     // Timer.periodic(const Duration(milliseconds: 300), (timer) {
//     //   _checkUploadStatus();
//     // });
//   }
//
//   void _refreshPage() {
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = 22.0;
//     return Stack(clipBehavior: Clip.none, children: [
//       // if (_showUploadItemsRow && _uploadItems.isNotEmpty)
//       //   Positioned.fill(
//       //     child: GestureDetector(
//       //       onTap: () {
//       //         _showUploadItemsRow = false;
//       //         setState(() {});
//       //       },
//       //       child: Container(
//       //         color: Colors.black.withOpacity(0.1),
//       //         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 54),
//       //         child: Align(
//       //           alignment: Alignment.topCenter,
//       //           child: Container(
//       //             padding: const EdgeInsets.all(4),
//       //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
//       //             constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//       //             height: 58,
//       //             child: SingleChildScrollView(
//       //               scrollDirection: Axis.horizontal,
//       //               child: Row(
//       //                 children: _uploadItems.map((uploadItem) {
//       //                   return Container(
//       //                     width: 50,
//       //                     height: 50,
//       //                     margin: EdgeInsets.only(right: _uploadItems.last == uploadItem ? 0 : 4),
//       //                     child: ClipRRect(
//       //                       borderRadius: BorderRadius.circular(4),
//       //                       child: Stack(children: [
//       //                         Image.asset(uploadItem.localPath, width: 50, height: 50, fit: BoxFit.cover),
//       //                         Container(
//       //                             color: Colors.black.withOpacity(0.3),
//       //                             child: Center(
//       //                                 child: InnovayText('${uploadItem.uploadProgress}%',
//       //                                     color: Colors.white, fontSize: 12)))
//       //                       ]),
//       //                     ),
//       //                   );
//       //                 }).toList(),
//       //               ),
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         GestureDetector(
//           onTap: _onUploadMediaTap,
//           child: Container(
//             margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15),
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
//             child: Stack(children: [
//               Icon(Icons.camera, color: InnovayConfig.colors.primaryColor, size: 36),
//               if (_mediaFileUploader.uploadItems.isNotEmpty)
//                 Positioned.fill(
//                   child: Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       child: CircularProgressIndicator(
//                         value: max(0.01, _mediaFileUploader.getCurrentUploadProgress() / 100.0),
//                         valueColor: AlwaysStoppedAnimation<Color>(InnovayConfig.colors.successColor),
//                       ),
//                     ),
//                   ),
//                 ),
//               if (_mediaFileUploader.uploadItems.isNotEmpty)
//                 Positioned.fill(
//                   child: Center(
//                     child: Container(
//                       width: size,
//                       height: size,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.white,
//                       ),
//                       child: Center(
//                         child: InnovayText(
//                           _mediaFileUploader.getCurrentUploadProgress().toStringAsFixed(0),
//                           fontSize: 8,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ]),
//           ),
//         ),
//         // Padding(
//         //     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15),
//         //     child:
//         //
//         //     CircleAvatar(
//         //         radius: 18,
//         //         backgroundColor: Colors.white.withOpacity(0.9),
//         //         child: IconButton(
//         //           padding: EdgeInsets.zero,
//         //           constraints: const BoxConstraints(),
//         //           iconSize: 36,
//         //           icon: Icon(Icons.camera, color:  InnovayConfig.colors.primaryColor),
//         //           onPressed: onUploadMediaTap,
//         //         )))
//       ]),
//     ]);
//   }
//
//   void _onUploadMediaTap() {
//     if (_mediaFileUploader.uploadItems.isNotEmpty) {
//       Navigator.push(
//         InnovayGlobalData.bottomNavigatorContext!,
//         MaterialPageRoute(
//           builder: (context) => const MediaFileUploaderView(),
//         ),
//       );
//       return;
//     }
//     return _mediaFileUploader.onPickMediaTap(widget.currentFolder.id);
//
//     // var buttons = [
//     //   IconButton(onPressed: _onShootImageTap, icon: const Icon(CupertinoIcons.camera, size: 24)),
//     //   IconButton(onPressed: _onPickImageTap, icon: const Icon(CupertinoIcons.photo, size: 24)),
//     //   IconButton(onPressed: _onPickVideoTap, icon: const Icon(CupertinoIcons.play_rectangle, size: 24)),
//     //   // IconButton(onPressed: onPickVideoTap, icon: const Icon(CupertinoIcons.doc_chart, size: 24)),
//     // ];
//     // CommonUtils.displayBottomPicker(context, '', [
//     //   Padding(
//     //       padding: const EdgeInsets.all(15),
//     //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//     //         const SizedBox(height: 15),
//     //         Row(
//     //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //             children: buttons.map((button) {
//     //               return Container(
//     //                   decoration: BoxDecoration(
//     //                     borderRadius: BorderRadius.circular(100),
//     //                     border: Border.all(width: 1, color: InnovayConfig.colors.textColor),
//     //                   ),
//     //                   child: button);
//     //             }).toList()),
//     //
//     //         // [
//     //         //   IconButton(onPressed: onShootImageTap, icon: const Icon(CupertinoIcons.camera, size: 24)),
//     //         //   IconButton(onPressed: onPickImageTap, icon: const Icon(CupertinoIcons.photo, size: 24)),
//     //         //   IconButton(onPressed: onPickVideoTap, icon: const Icon(CupertinoIcons.play_rectangle, size: 24)),
//     //         //   IconButton(onPressed: onPickVideoTap, icon: const Icon(CupertinoIcons.doc_chart, size: 24)),
//     //         // ]),
//     //         const SizedBox(height: 15),
//     //         // Row(children: [
//     //         //   ExpandedText(1, '相册', color: InnovayConfig.colors.textColorLight7),
//     //         //   IconButton(onPressed: onFolderListTap, icon: const Icon(CupertinoIcons.folder_badge_plus, size: 24)),
//     //         // ])
//     //       ])),
//     // ]);
//   }
//
//   // void _onPickImageTap() {
//   //   Navigator.pop(context);
//   //   FileUtils.pickImagesFromGallery(9, (pickedImages) {
//   //     for (var item in pickedImages) {
//   //       if (item.fileSize > 100000000) {
//   //         return SnackBarManager.displayMessage('文件超过100MB，无法上传');
//   //       }
//   //     }
//   //     var folderFiles = <FolderFileUploadItemModel>[];
//   //     var currentFolderId = widget.getCurrentFolderId();
//   //     for (var item in pickedImages) {
//   //       var uploadItem = FolderFileUploadItemModel(item.localPath, '', false, false);
//   //       uploadItem.targetFolderId = currentFolderId;
//   //       folderFiles.add(uploadItem);
//   //     }
//   //     _addToUploadList(folderFiles);
//   //   });
//   // }
//
//   // void _onShootImageTap() {
//   //   Navigator.pop(context);
//   //   FileUtils.shootImageFromCamera(context, (shotImages) {
//   //     for (var item in shotImages) {
//   //       if (item.fileSize > 100000000) {
//   //         return SnackBarManager.displayMessage('文件超过100MB，无法上传');
//   //       }
//   //     }
//   //     var folderFiles = <FolderFileUploadItemModel>[];
//   //     var currentFolderId = widget.getCurrentFolderId();
//   //     for (var item in shotImages) {
//   //       var uploadItem = FolderFileUploadItemModel(item.localPath, '', false, false);
//   //       uploadItem.targetFolderId = currentFolderId;
//   //       folderFiles.add(uploadItem);
//   //     }
//   //     _addToUploadList(folderFiles);
//   //   });
//   // }
//
//   // void _onPickVideoTap() {
//   //   Navigator.pop(context);
//   //   FileUtils.pickVideoFromGallery((pickedVideos) {
//   //     for (var item in pickedVideos) {
//   //       if (item.fileSize > 100000000) {
//   //         return SnackBarManager.displayMessage('文件超过100MB，无法上传');
//   //       }
//   //     }
//   //     var folderFiles = <FolderFileUploadItemModel>[];
//   //     var currentFolderId = widget.getCurrentFolderId();
//   //     for (var item in pickedVideos) {
//   //       var uploadItem = FolderFileUploadItemModel(item.localPath, '', false, false);
//   //       uploadItem.targetFolderId = currentFolderId;
//   //       folderFiles.add(uploadItem);
//   //     }
//   //     _addToUploadList(folderFiles);
//   //   });
//   // }
//
//   // Future<bool> _startUploadProcess() async {
//   //   for (var i = 0; i < _uploadItems.length; i++) {
//   //     DebugManager.log("Start upload process: $i");
//   //     await _uploadItems[i].chunkUploadAndSaveToFolder(UserModel.instance.accessToken, () {
//   //       setState(() {});
//   //     });
//   //   }
//   //   // SnackBarManager.displayMessage('All files uploaded');
//   //   DebugManager.log("End");
//   //   // uploadItems.clear();
//   //   return true;
//   // }
// }
