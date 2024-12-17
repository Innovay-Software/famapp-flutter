import 'package:flutter/material.dart';

import '../../model/album.dart';
import '../../model/album_file.dart';
import '../media_slide_show_page.dart';
import 'media_card.dart';

class AlbumMediaCard extends StatelessWidget {
  final int albumFileIndex;
  final double mediaCardSize;
  final Album album;
  final AlbumFile albumFile;
  final bool isEditingMode;
  final bool isEditingSelected;
  final String mediaFileProcessingMessage;
  final Function(int) onMediaFileLongPressed;
  final Function(int, bool) onMediaFileSelectStatusChanged;
  final Function() onNavigateBackToAlbumHome;

  const AlbumMediaCard({
    super.key,
    required this.albumFileIndex,
    required this.mediaCardSize,
    required this.album,
    required this.albumFile,
    required this.isEditingMode,
    required this.isEditingSelected,
    required this.mediaFileProcessingMessage,
    required this.onMediaFileLongPressed,
    required this.onMediaFileSelectStatusChanged,
    required this.onNavigateBackToAlbumHome,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: Key('AlbumMediaCard-${albumFile.id}'),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: mediaCardSize,
        height: mediaCardSize,
        child: MediaCard(
          album: album,
          albumFile: albumFile,
          onImageTap: () {
            _onImageTap(context);
          },
          isEditingMode: isEditingMode,
          isSelected: isEditingSelected,
          mediaFileProcessingMessage: mediaFileProcessingMessage,
          onMediaFileLongPressed: onMediaFileLongPressed,
          onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
        ),
      ),
    );
  }

  void _onImageTap(BuildContext context) async {
    var paddingTop = MediaQuery.of(context).padding.top;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return MediaSlideShowPage(
          paddingTop: paddingTop,
          album: album,
          initialIndex: albumFileIndex,
          systemBarHeight: MediaQuery.of(context).padding.top,
          pivotDate: DateTime.now(),
        );
      },
    );

    onNavigateBackToAlbumHome();
  }
}
