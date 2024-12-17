import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/utils/baby_utils.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/album.dart';

class AlbumSummaryHeaderBabyWidget extends StatelessWidget {
  final Album album;

  const AlbumSummaryHeaderBabyWidget({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    // if (folder.folderType == FolderType.normal) {
    //   return MediaCollectionNormalWidget(
    //     folder: folder,
    //     folderFileCollection: folderFileCollection,
    //     selectedFileIds: selectedFileIds,
    //     isEditingMode: isEditingMode,
    //     onMediaFileLongPressed: onMediaFileLongPressed,
    //     onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
    //   );
    // }
    // if (folder.folderType == FolderType.baby) {
    //   return MediaCollectionBabyWidget(
    //     folder: folder,
    //     folderFileCollection: folderFileCollection,
    //     selectedFileIds: selectedFileIds,
    //     isEditingMode: isEditingMode,
    //     onMediaFileLongPressed: onMediaFileLongPressed,
    //     onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
    //   );
    // }
    var imageSize = MediaQuery.of(context).size.width * 0.3;
    return Stack(children: [
      // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //   Image.asset('assets/ui/baby/calendar.png',
      //       width: imageSize,
      //       height: imageSize,
      //       fit: BoxFit.contain,
      //       opacity: const AlwaysStoppedAnimation(.05)),
      //   SizedBox(height: imageSize + 50),
      // ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 15, height: imageSize),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InnoText('姓名：${album.metadata['name']}', color: InnoConfig.colors.textColor),
          const SizedBox(height: 3),
          InnoText('年龄：${BabyUtils.getBabyAgeText(DateTime(2020, 1, 21), DateTime.now())}',
              color: InnoConfig.colors.textColor),
          const SizedBox(height: 3),
          InnoText('出生日期：${album.metadata['birthDate']}', color: InnoConfig.colors.textColor),
          const SizedBox(height: 3),
          InnoText('文件数：${album.totalFiles} 照片/视频', color: InnoConfig.colors.textColor),
        ]),
        // Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 8),
        //     width: 2,
        //     height: 2,
        //     color: InnovayConfig.colors.textColorLight7),
        // InnovayText(BabyUtils.getBabyAgeText(DateTime(2020, 1, 21), DateTime.now()),
        //     color: InnovayConfig.colors.textColorLight7),
      ]),
      Positioned(
        right: 0,
        bottom: 0,
        child: Image.asset(
          'assets/ui/baby/christmas-balloon-red.gif',
          width: 100,
          height: 100,
          opacity: const AlwaysStoppedAnimation(.5),
        ),
      ),
      Positioned(
        left: 15,
        right: 15,
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 1,
          color: InnoConfig.colors.dividerLineColor,
        ),
      ),
    ]);
  }
}
