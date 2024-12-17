// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';
//
// import '../../../core/utils/baby_utils.dart';
// import '../viewmodel/enums/album_type.dart';
// import './album.dart';
// import './album_file.dart';
//
// class AlbumFileCollection {
//   Album album;
//   List<AlbumFile> albumFiles = [];
//   DateTime date = DateTime.now();
//
//   AlbumFileCollection(this.album, AlbumFile firstFile) {
//     albumFiles.add(firstFile);
//     date = firstFile.shotAt;
//   }
//
//   bool isEmpty() {
//     return albumFiles.isEmpty;
//   }
//
//   void addToCollection(AlbumFile newFile) {
//     albumFiles.add(newFile);
//   }
//
//   bool canAddToCollection(AlbumFile newFile) {
//     return newFile.shotAt == date;
//   }
//
//   void removeFiles(List<int> fileIds) {
//     for (var i = 0; i < albumFiles.length; i++) {
//       if (fileIds.contains(albumFiles[i].id)) {
//         albumFiles.removeAt(i);
//         i--;
//       }
//     }
//   }
//
//   String dateString() {
//     return DatetimeUtils.formattedDate(date);
//   }
//
//   double getMediaCollectionWidgetHeight(BuildContext context, AlbumType albumType) {
//     var padding = 15;
//     var dateHeight = 30;
//     var mediaSpacing = 5;
//     var mediaRows = (albumFiles.length / 3).ceilToDouble();
//     var mediaHeight = (MediaQuery.of(context).size.width - padding * 2 - mediaSpacing * 2) / 3 + 1;
//     var height = mediaHeight * mediaRows + (mediaRows - 1) * 5;
//     height += padding * 2 + dateHeight;
//
//     if (albumType == AlbumType.baby) {
//       height += _getBabyMediaCollectionWidgetHeaderHeight();
//     } else if (albumType == AlbumType.normal) {
//       height += _getNormalMediaCollectionWidgetHeaderHeight();
//     }
//     return height;
//   }
//
//   double _getBabyMediaCollectionWidgetHeaderHeight() {
//     var birthDate = DateTime.parse(album.metadata['birthDate']);
//     var specialDateText = BabyUtils.getSpecialDateText(birthDate, date);
//     return specialDateText.isEmpty ? 0 : 120;
//   }
//
//   double _getNormalMediaCollectionWidgetHeaderHeight() {
//     return 0;
//   }
// }
