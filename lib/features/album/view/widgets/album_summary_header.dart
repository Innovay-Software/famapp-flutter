import 'package:flutter/material.dart';

import '../../model/album.dart';
import '../../viewmodel/enums/album_type.dart';
import 'album_summary_header_baby.dart';

class AlbumSummaryHeaderWidget extends StatelessWidget {
  final Album album;

  const AlbumSummaryHeaderWidget({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    if (album.albumType == AlbumType.baby) {
      return AlbumSummaryHeaderBabyWidget(
        album: album,
      );
    }
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      // SizedBox(height: 50),
      // InnovayText('${folder.totalFiles} 照片/视频'),
      // Container(margin: const EdgeInsets.symmetric(horizontal: 8), width: 2, height: 2, color: InnovayConfig.colors.textColorLight7),
      // InnovayText(BabyUtils.getBabyAgeText(DateTime(2020, 1, 21), DateTime.now())),
    ]);
  }
}
