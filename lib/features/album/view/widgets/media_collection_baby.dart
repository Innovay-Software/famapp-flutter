// import 'package:flutter/material.dart';
// import 'package:famapp/innovay/config.dart';
// import 'package:famapp/innovay/widgets/innovay_text.dart';
// import 'package:famapp/utils/baby_utils.dart';
//
// import '../../model/album.dart';
// import '../../model/album_file_collection_model.dart';
// import 'media_card.dart';
//
// class MediaCollectionBabyWidget extends StatelessWidget {
//   final Album folder;
//   final FolderFileCollection folderFileCollection;
//   final List<int> selectedFileIds;
//   final bool isEditingMode;
//   final Function(int) onMediaFileLongPressed;
//   final Function(int, bool) onMediaFileSelectStatusChanged;
//
//   const MediaCollectionBabyWidget({
//     super.key,
//     required this.folder,
//     required this.folderFileCollection,
//     required this.selectedFileIds,
//     required this.isEditingMode,
//     required this.onMediaFileLongPressed,
//     required this.onMediaFileSelectStatusChanged,
//   });
//
//   List<String> getSpecialDateText() {
//     var birthDate = DateTime.parse(folder.metadata['birthDate']);
//     return BabyUtils.getSpecialDateText(birthDate, folderFileCollection.date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var dateTextList = getSpecialDateText();
//     return Container(
//       height: folderFileCollection.getMediaCollectionWidgetHeight(context, folder.albumType),
//       padding: const EdgeInsets.all(15),
//       // decoration: BoxDecoration(
//       //   border: Border.all(color: Colors.red),
//       // ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         if (dateTextList.isNotEmpty)
//           SizedBox(
//             height: 120,
//             child: Center(
//               child: Stack(children: [
//                 Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   Image.asset('assets/ui/baby/${dateTextList[1]}',
//                       width: 300, height: 100, fit: BoxFit.contain, opacity: const AlwaysStoppedAnimation(.3)),
//                 ]),
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     InnovayText(
//                       dateTextList[0],
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ]),
//                 ),
//               ]),
//             ),
//           ),
//         Row(children: [
//           const SizedBox(height: 30),
//           Icon(Icons.access_time_filled, color: Colors.pink.withOpacity(0.6), size: 18),
//           const SizedBox(width: 5),
//           InnovayText(
//             folderFileCollection.dateString(),
//             fontWeight: FontWeight.bold,
//             fontSize: 11,
//             color: InnoConfig.colors.textColorLight7,
//           ),
//         ]),
//         GridView(
//           padding: EdgeInsets.zero,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 5.0,
//             mainAxisSpacing: 5.0,
//           ),
//           scrollDirection: Axis.vertical,
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           // children: children,
//           children: folderFileCollection.folderFiles.map((item) {
//             return Builder(builder: (BuildContext context) {
//               return MediaCard(
//                 folder: folder,
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
//     //           folderFileCollection: folderFileCollection,
//     //           initialIndex: initialIndex,
//     //           systemBarHeight: MediaQuery.of(context).padding.top)),
//     // );
//   }
// }
