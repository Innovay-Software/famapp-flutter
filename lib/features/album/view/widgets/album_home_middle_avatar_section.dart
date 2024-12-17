import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/album.dart';
import 'album_home_album_section_top_border.dart';

class AlbumHomeMiddleAvatarSection extends StatelessWidget {
  final double sectionHeight;
  final Album album;
  const AlbumHomeMiddleAvatarSection({
    super.key,
    required this.sectionHeight,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeight,
      child: Stack(
        children: [
          const Padding(padding: EdgeInsets.only(top: 90), child: AlbumHomeAlbumSectionTopBorder(height: 50)),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 4, color: Colors.white),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: album.cover.isNotEmpty
                    ? InnovayCachedImage(album.cover, width: 130, height: 130)
                    : Container(
                        color: InnoConfig.colors.primaryColor,
                        width: 130,
                        height: 130,
                        child: Center(
                          child: InnoText(
                            album.title.isEmpty ? '' : album.title[0],
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
