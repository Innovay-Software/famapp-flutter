import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../model/album.dart';
import '../../model/album_file.dart';
import 'album_media_card.dart';

class AlbumMediaRow extends StatelessWidget {
  final int startingAlbumFileIndex;
  final double rowHeight;
  final double mediaCardSize;
  final Album album;
  final List<AlbumFile> albumFiles;
  final List<int> editingSelectedIds;
  final bool isEditingMode;
  final String mediaFileProcessingMessage;
  final Function(int) onMediaFileLongPressed;
  final Function(int, bool) onMediaFileSelectStatusChanged;
  final Function() onNavigateBackToAlbumHome;

  const AlbumMediaRow({
    super.key,
    required this.startingAlbumFileIndex,
    required this.rowHeight,
    required this.mediaCardSize,
    required this.album,
    required this.albumFiles,
    required this.editingSelectedIds,
    required this.isEditingMode,
    required this.mediaFileProcessingMessage,
    required this.onMediaFileLongPressed,
    required this.onMediaFileSelectStatusChanged,
    required this.onNavigateBackToAlbumHome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: InnoConfig.colors.backgroundColorTinted3,
      height: rowHeight,
      padding: const EdgeInsets.only(left: 36, bottom: 20),
      // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Row(children: [
        // Container(color: Colors.red, width: 30, height: 30),
        if (albumFiles.isNotEmpty)
          AlbumMediaCard(
            key: Key('AlbumMediaCard.${albumFiles[0].id}'),
            albumFileIndex: startingAlbumFileIndex,
            mediaCardSize: mediaCardSize,
            album: album,
            albumFile: albumFiles[0],
            isEditingMode: isEditingMode,
            isEditingSelected: editingSelectedIds.contains(albumFiles[0].id),
            mediaFileProcessingMessage: mediaFileProcessingMessage,
            onMediaFileLongPressed: onMediaFileLongPressed,
            onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
            onNavigateBackToAlbumHome: onNavigateBackToAlbumHome,
          ),
        const SizedBox(width: 20),
        if (albumFiles.length > 1)
          AlbumMediaCard(
            key: Key('AlbumMediaCard.${albumFiles[1].id}'),
            albumFileIndex: startingAlbumFileIndex + 1,
            mediaCardSize: mediaCardSize,
            album: album,
            albumFile: albumFiles[1],
            isEditingMode: isEditingMode,
            isEditingSelected: editingSelectedIds.contains(albumFiles[1].id),
            mediaFileProcessingMessage: mediaFileProcessingMessage,
            onMediaFileLongPressed: onMediaFileLongPressed,
            onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
            onNavigateBackToAlbumHome: onNavigateBackToAlbumHome,
          ),
        const SizedBox(width: 20),
        if (albumFiles.length > 2)
          AlbumMediaCard(
            key: Key('AlbumMediaCard.${albumFiles[2].id}'),
            albumFileIndex: startingAlbumFileIndex + 2,
            mediaCardSize: mediaCardSize,
            album: album,
            albumFile: albumFiles[2],
            isEditingMode: isEditingMode,
            isEditingSelected: editingSelectedIds.contains(albumFiles[2].id),
            mediaFileProcessingMessage: mediaFileProcessingMessage,
            onMediaFileLongPressed: onMediaFileLongPressed,
            onMediaFileSelectStatusChanged: onMediaFileSelectStatusChanged,
            onNavigateBackToAlbumHome: onNavigateBackToAlbumHome,
          ),
      ]),
    );
  }
}
