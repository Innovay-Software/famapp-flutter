// import 'dart:math';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
//
// import '../models/album.dart';
// import '../widgets/media_slide_show_item.dart';
// import '../models/album_file.dart';
// import '../../innovay/config.dart';
// import '../../innovay/models/user.dart';
// import '../../innovay/utils/file_utils.dart';
// import '../../innovay/utils/debug_utils.dart';
// import '../../innovay/utils/snack_bar_manager.dart';
// import '../../innovay/widgets/divider_dot.dart';
// import '../../innovay/widgets/innovay_text.dart';
//
// class MediaSlideShowPage extends StatefulWidget {
//   final double paddingTop;
//   final Folder folder;
//
//   // final FolderFileCollection folderFileCollection;
//   final int initialIndex;
//   final double systemBarHeight;
//
//   const MediaSlideShowPage({
//     super.key,
//     required this.paddingTop,
//     required this.folder,
//     required this.initialIndex,
//     required this.systemBarHeight,
//   });
//
//   @override
//   State<MediaSlideShowPage> createState() => _MediaSlideShowPageState();
// }
//
// class _MediaSlideShowPageState extends State<MediaSlideShowPage> {
//   final CarouselController _carouselController = CarouselController();
//   final FocusNode _remarkTextFieldFocusNode = FocusNode();
//   bool _collapseRemark = true;
//   int _currentIndex = 0;
//
//   // bool _isShowingKeyboard = false;
//   bool _isShowingRemarkTextField = false;
//   late FolderFile _startingFile;
//   late FolderFile _currentFile;
//
//   // late StreamSubscription<bool> _keyboardSubscription;
//   late TextEditingController _editingController = TextEditingController();
//   String _remarkUserInput = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//     _currentFile = widget.folder.files[widget.initialIndex];
//     _startingFile = widget.folder.files[widget.initialIndex];
//
//     // var keyboardVisibilityController = KeyboardVisibilityController();
//     // _keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
//     //   setState(() {
//     //     _isShowingKeyboard = visible;
//     //   });
//     // });
//   }
//
//   @override
//   void dispose() {
//     // _keyboardSubscription.cancel();
//     _remarkTextFieldFocusNode.dispose();
//     // _remarkTextFieldController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _editingController = TextEditingController(text: _currentFile.remark);
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: Stack(children: [
//           Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             SizedBox(height: widget.paddingTop),
//             Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//                 child: Row(children: [
//                   Expanded(
//                     child: InnovayText(
//                       DatetimeUtils.formattedDate(_currentFile.shotAt),
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Expanded(
//                     child: InnovayText(
//                       '${_currentIndex + 1}/${widget.folder.files.length}${kDebugMode ? ' / ' + widget.folder.files[_currentIndex].id.toString() : ''}',
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.info_outline,
//                           color: Colors.white,
//                         ),
//                         onPressed: _onInfoTap,
//                       ),
//                     ),
//                   )
//                 ])),
//             Expanded(
//                 child: CarouselSlider(
//               carouselController: _carouselController,
//               options: CarouselOptions(
//                 enableInfiniteScroll: false,
//                 initialPage: widget.initialIndex,
//                 height: MediaQuery.of(context).size.height,
//                 enlargeCenterPage: true,
//                 viewportFraction: 1,
//                 onPageChanged: (index, reason) {
//                   _currentIndex = index;
//                   _currentFile = widget.folder.files[index];
//                   _remarkUserInput = _currentFile.remark;
//                   if (_currentIndex >= widget.folder.files.length - 5) {
//                     widget.folder.loadFiles(
//                         startCallback: () {},
//                         successCallback: () {
//                           setState(() {});
//                         },
//                         forceReload: false,
//                         pivotDate: DateTime.now().add(const Duration(days: 1)));
//                   }
//                   setState(() {});
//                 },
//               ),
//               items: widget.folder.files.map((item) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     var childWidget = MediaSlideShowItemWidget(folderFile: item);
//                     if (item.id == _startingFile.id) {
//                       return Hero(tag: 'slideShow-${_startingFile.id}', child: childWidget);
//                     }
//                     return childWidget;
//                   },
//                 );
//               }).toList(),
//             ))
//           ]),
//           Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: GestureDetector(
//                   onTap: _onRemarkTap,
//                   child: Container(
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.8)])),
//                       padding: EdgeInsets.only(right: 15, bottom: max(5, MediaQuery.of(context).padding.bottom + 5)),
//                       child: Row(children: [
//                         GestureDetector(
//                             onTap: _onEditTap,
//                             child: Container(
//                                 color: Colors.white.withOpacity(0.01),
//                                 padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
//                                 child: const Icon(Icons.edit, color: Colors.white, size: 12))),
//                         Expanded(
//                             child: _collapseRemark
//                                 ? InnovayText(
//                                     _currentFile.remark.isEmpty ? '添加备注' : _currentFile.remark,
//                                     style: const TextStyle(
//                                         overflow: TextOverflow.ellipsis, color: Colors.white, fontSize: 12),
//                                   )
//                                 : InnovayText(
//                                     _currentFile.remark.isEmpty ? '添加备注' : _currentFile.remark,
//                                     style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.5),
//                                   )),
//                       ])))),
//           Visibility(
//               visible: _isShowingRemarkTextField,
//               child: Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Focus(
//                   canRequestFocus: true,
//                   onFocusChange: (hasFocus) {
//                     if (!hasFocus) {
//                       setState(() {
//                         _isShowingRemarkTextField = false;
//                         if (_remarkUserInput != _currentFile.remark) {
//                           _currentFile.remark = _remarkUserInput;
//                           _currentFile.syncToCloud(() {});
//                         }
//                       });
//                     }
//                   },
//                   child: Container(
//                     color: Colors.white,
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: TextField(
//                       focusNode: _remarkTextFieldFocusNode,
//                       controller: _editingController,
//                       autofocus: true,
//                       onChanged: (text) {
//                         _remarkUserInput = text;
//                       },
//                       decoration: const InputDecoration(
//                         isDense: true,
//                         hintText: '点此添加备注',
//                         contentPadding: EdgeInsets.only(top: 12, bottom: 8, left: 5, right: 5),
//                         border: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                       ),
//                       style: const TextStyle(
//                         fontSize: 14,
//                       ),
//                       textAlign: TextAlign.left,
//                       minLines: 1,
//                       maxLines: 10,
//                     ),
//                   ),
//                 ),
//               ))
//         ]));
//   }
//
//   void _onDownloadMediaFileTap(int index) {
//     SnackBarManager.displayMessage('开始下载');
//     DebugManager.log('_onDownloadMediaFileTap $index');
//     var folderFile = widget.folder.files[index];
//     if (folderFile.fileType == 'image') {
//       FileUtils.downloadImageFile(context, folderFile.fileUrl, () {
//         SnackBarManager.displayMessage('下载成功');
//       });
//     } else if (folderFile.fileType == 'video') {
//       FileUtils.downloadVideoFile(context, folderFile.fileUrl, () {
//         SnackBarManager.displayMessage('下载成功');
//       });
//     }
//   }
//
//   void _onInfoTap() {
//     int currentIndex = _currentIndex;
//     showModalBottomSheet(
//         barrierColor: Colors.transparent,
//         backgroundColor: const Color(0xF2333333),
//         context: context,
//         isScrollControlled: true,
//         isDismissible: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
//           side: BorderSide.none,
//         ),
//         builder: (BuildContext context) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Container(
//                 padding: EdgeInsets.only(
//                     left: 15, right: 15, top: 15, bottom: max(15, MediaQuery.of(context).padding.bottom)),
//                 constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
//                 // child: Column(children: [SingleChildScrollView(child: Wrap(children: children))])),
//                 child: SingleChildScrollView(
//                     child: Column(children: [
//                   Row(children: [
//                     const SizedBox(width: 5),
//                     InnovayText(DatetimeUtils.formattedDate(_currentFile.shotAt),
//                         color: InnovayConfig.colors.textColorLight9),
//                     const Spacer(),
//                     // IconButton(
//                     //     onPressed: () {
//                     //       _onDownloadMediaFileTap(currentIndex);
//                     //     },
//                     //     icon: const Icon(Icons.download, color: Colors.white)),
//                     const SizedBox(width: 5),
//                   ]),
//                   Container(
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       width: MediaQuery.of(context).size.width - 30,
//                       height: 1,
//                       color: Colors.white),
//                   if (_currentFile.fileType == 'image')
//                     Row(children: [
//                       const SizedBox(width: 5),
//                       InnovayText(_currentFile.fileUrl.split('.').last.toUpperCase(),
//                           color: InnovayConfig.colors.textColorLight9),
//                       InnovayDividerDot(color: InnovayConfig.colors.textColorLight9),
//                       InnovayText('${_currentFile.getSizeInMb()} MB', color: InnovayConfig.colors.textColorLight9),
//                       InnovayDividerDot(color: InnovayConfig.colors.textColorLight9),
//                       InnovayText('${_currentFile.metadata['dimension']}', color: InnovayConfig.colors.textColorLight9),
//                     ]),
//                   if (_currentFile.fileType == 'video')
//                     Row(children: [
//                       const SizedBox(width: 5),
//                       InnovayText(_currentFile.fileUrl.split('.').last.toUpperCase(),
//                           color: InnovayConfig.colors.textColorLight9),
//                       InnovayDividerDot(color: InnovayConfig.colors.textColorLight9),
//                       InnovayText('${_currentFile.getDurationString()} ', color: InnovayConfig.colors.textColorLight9),
//                       InnovayDividerDot(color: InnovayConfig.colors.textColorLight9),
//                       InnovayText('${_currentFile.getSizeInMb()} MB', color: InnovayConfig.colors.textColorLight9),
//                       InnovayDividerDot(color: InnovayConfig.colors.textColorLight9),
//                       InnovayText('${_currentFile.metadata['dimension']}', color: InnovayConfig.colors.textColorLight9),
//                     ]),
//                   const SizedBox(height: 10),
//                   Row(children: [
//                     const SizedBox(width: 5),
//                     Expanded(
//                         child: InnovayText(
//                       _currentFile.fileUrl,
//                       color: InnovayConfig.colors.textColorLight9,
//                     )),
//                     IconButton(
//                         color: Colors.white,
//                         icon: const Icon(Icons.file_copy_rounded),
//                         onPressed: () async {
//                           ClipboardData data = ClipboardData(text: _currentFile.fileUrl);
//                           await Clipboard.setData(data);
//                           SnackBarManager.displayMessage('copied');
//                         }),
//                   ]),
//                 ]))),
//           );
//         });
//   }
//
//   void _onRemarkTap() {
//     if (_currentFile.remark.isEmpty) {
//       return _onEditTap();
//     }
//     setState(() {
//       _collapseRemark = !_collapseRemark;
//     });
//   }
//
//   void _onEditTap() {
//     if (_currentFile.ownerId != UserModel.instance.id || widget.folder.ownerId != UserModel.instance.id) {
//       return SnackBarManager.displayPermissionDeniedMessage();
//     }
//     setState(() {
//       _isShowingRemarkTextField = true;
//     });
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       FocusScope.of(context).requestFocus(_remarkTextFieldFocusNode);
//     });
//   }
// }
