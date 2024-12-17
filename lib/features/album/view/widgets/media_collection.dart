// import 'package:flutter/material.dart';
// import 'package:famapp/features/album/model/album_file_collection_model.dart';
// import 'package:famapp/innovay/widgets/innovay_text.dart';
//
// import '../../../../innovay/config.dart';
// import '../../model/album.dart';
// import '../../viewmodel/enums/album_type.dart';
// import 'media_card.dart';
// import 'media_collection_baby.dart';
//
// class MediaCollectionWidget extends StatelessWidget {
//   final Album album;
//   final FolderFileCollection folderFileCollection;
//   final List<int> selectedFileIds;
//   final bool isEditingMode;
//   final Function(int) onMediaFileLongPressed;
//   final Function(int, bool) onMediaFileSelectStatusChanged;
//
//   const MediaCollectionWidget({
//     super.key,
//     required this.album,
//     required this.folderFileCollection,
//     required this.selectedFileIds,
//     required this.isEditingMode,
//     required this.onMediaFileLongPressed,
//     required this.onMediaFileSelectStatusChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (album.albumType == AlbumType.baby) {
//       return MediaCollectionBabyWidget(
//         folder: album,
//         folderFileCollection: folderFileCollection,
//         selectedFileIds: selectedFileIds,
//         isEditingMode: isEditingMode,
//         onMediaFileLongPressed: onMediaFileLongPressed,
//         onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
//       );
//     }
//     return Container(
//       padding: const EdgeInsets.all(15),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(children: [
//           Icon(
//             Icons.access_time_filled,
//             color: InnoConfig.colors.primaryColor,
//             size: 13,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(5),
//             child: InnovayText(
//               folderFileCollection.dateString(),
//               fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//           )
//         ]),
//         GridView(
//           padding: EdgeInsets.zero,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 2.0,
//             mainAxisSpacing: 2.0,
//           ),
//           scrollDirection: Axis.vertical,
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           // children: children,
//           children: folderFileCollection.folderFiles.map((item) {
//             return Builder(builder: (BuildContext context) {
//               return MediaCard(
//                 folder: album,
//                 folderFile: item,
//                 onImageTap: () {
//                   onImageTap(context, folderFileCollection.folderFiles.indexOf(item));
//                 },
//                 isEditingMode: isEditingMode,
//                 isSelected: selectedFileIds.contains(item.id),
//                 onMediaFileLongPressed: onMediaFileLongPressed,
//                 onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
//               );
//             });
//           }).toList(),
//         ),
//       ]),
//     );
//   }
//
//   void onImageTap(BuildContext context, int initialIndex) async {
//     // await Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //       builder: (context) => MediaSlideShowPage(
//     //           files: _files,
//     //           initialIndex: initialIndex,
//     //           systemBarHeight: MediaQuery.of(context).padding.top)),
//     // );
//   }
// }
