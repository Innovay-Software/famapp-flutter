import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/debug_utils.dart';
import '../../../../core/utils/snack_bar_manager.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/album.dart';
import '../../model/album_file.dart';

class MediaCard extends StatelessWidget {
  final String mediaFileProcessingMessage;
  final bool isEditingMode;
  final bool isSelected;
  final Album album;
  final AlbumFile albumFile;
  final Function() onImageTap;
  final Function(int) onMediaFileLongPressed;
  final Function(int, bool) onMediaFileSelectStatusChanged;

  const MediaCard({
    super.key,
    required this.mediaFileProcessingMessage,
    required this.isEditingMode,
    required this.isSelected,
    required this.album,
    required this.albumFile,
    required this.onImageTap,
    required this.onMediaFileLongPressed,
    required this.onMediaFileSelectStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onMediaFileTap,
      onLongPress: _onMediaFileLongPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(children: [
          Hero(
            tag: albumFile.heroKeyThumbnail,
            child: albumFile.isPreprocessing
                ? Container(
                    color: Colors.grey.withOpacity(.8),
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 30),
                    ),
                  )
                : InnovayCachedImage(
                    albumFile.thumbnailUrl,
                    cacheKey: albumFile.cacheKeyThumbnail,
                    width: 1000,
                    height: 1000,
                    fit: BoxFit.cover,
                    httpHeaders: albumFile.thumbnailUrlHeaders,
                    allowLongPress: false,
                    loadingBackgroundColor: Colors.grey,
                  ),
          ),
          if (albumFile.isPrivate)
            const Positioned(
              left: 5,
              top: kDebugMode ? 20 : 5,
              child: Icon(Icons.lock, color: Colors.red, size: 12),
            ),
          if (albumFile.fileType == 'video')
            Positioned(
              right: 5,
              bottom: 5,
              child: InnoText(
                albumFile.getDurationString(),
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (kDebugMode)
            Positioned(
              left: 5,
              top: 5,
              child: InnoText(
                // albumFile.shotAt.toString(),
                DateFormat('MM/dd@HH:mm').format(albumFile.shotAt.toLocal()),
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (kDebugMode)
            Positioned(
              left: 5,
              bottom: 5,
              child: InnoText('${albumFile.id}', color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          if (isEditingMode)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: _onMediaFileTap,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(isSelected ? Icons.check_box_outlined : Icons.square_outlined, color: Colors.white),
                      ]),
                ),
              ),
            ),
        ]),
      ),
    );
  }

  void _onMediaFileTap() {
    if (albumFile.isPreprocessing) {
      return SnackBarManager.displayMessage(mediaFileProcessingMessage);
    }
    if (isEditingMode) {
      onMediaFileSelectStatusChanged(albumFile.id, !isSelected);
    } else {
      onImageTap();
    }
  }

  void _onMediaFileLongPressed() {
    onMediaFileLongPressed(albumFile.id);
  }

  void _onMenuTap() {
    if (isEditingMode) return;
    DebugManager.log('onMenuTap');
  }
}
