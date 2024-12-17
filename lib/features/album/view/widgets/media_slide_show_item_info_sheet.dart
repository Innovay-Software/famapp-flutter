import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/config.dart';
import '../../../../core/global_data.dart';
import '../../../../core/utils/datetime_util.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/utils/snack_bar_manager.dart';
import '../../../../core/widgets/divider_dot.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/album_file.dart';

class MediaSlideShowItemInfoSheet extends StatelessWidget {
  final AlbumFile albumFile;
  const MediaSlideShowItemInfoSheet({super.key, required this.albumFile});

  @override
  Widget build(BuildContext context) {
    final textColor = InnoConfig.colors.textColorLight9;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: max(15, MediaQuery.of(context).padding.bottom),
        ),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        // child: Column(children: [SingleChildScrollView(child: Wrap(children: children))])),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
              ]),
              Row(children: [
                const SizedBox(width: 5),
                InnoText(
                  DatetimeUtils.formattedDateTime(albumFile.shotAt, dateTimeSeparator: ' @ '),
                  color: textColor,
                ),
                const Spacer(),
                // IconButton(
                //   color: Colors.white,
                //   icon: const Icon(Icons.download, color: Color(0xFFC850C0), size: 30),
                //   onPressed: () {
                //     _onDownloadMediaFileTap(false);
                //   },
                // ),
                IconButton(
                  onPressed: _onShareTap,
                  icon: const Icon(CupertinoIcons.share, size: 24),
                  color: Colors.lightBlueAccent,
                ),
                IconButton(
                  color: Colors.white,
                  icon: const Stack(clipBehavior: Clip.none, children: [
                    Icon(Icons.download, color: Color(0xFFC850C0), size: 30),
                    Positioned(
                      right: -10,
                      top: -5,
                      child: Icon(Icons.hd_outlined, color: Color(0xFFFFCC70), size: 22),
                    ),
                  ]),
                  onPressed: () {
                    _onDownloadMediaFileTap(true);
                  },
                ),
                const SizedBox(width: 5),
              ]),
              Divider(thickness: 1, color: InnoConfig.colors.backgroundColorTinted3),
              const SizedBox(height: 10),
              if (albumFile.fileType == 'image')
                Row(children: [
                  const SizedBox(width: 5),
                  InnoText(albumFile.fileName.split('.').last.toUpperCase(), color: textColor),
                  InnovayDividerDot(color: textColor),
                  InnoText(albumFile.getSizeString(), color: textColor),
                  InnovayDividerDot(color: textColor),
                  InnoText('${albumFile.metadata['dimension']}', color: textColor),
                  InnovayDividerDot(color: textColor),
                  InnoText('ID_${albumFile.id}', color: textColor),
                ]),
              if (albumFile.fileType == 'video')
                Row(children: [
                  const SizedBox(width: 5),
                  InnoText(albumFile.fileName.split('.').last.toUpperCase(), color: textColor),
                  InnovayDividerDot(color: textColor),
                  InnoText('${albumFile.getDurationString()} ', color: textColor),
                  InnovayDividerDot(color: textColor),
                  InnoText(albumFile.getSizeString(), color: textColor),
                  InnovayDividerDot(color: textColor),
                  InnoText('${albumFile.metadata['dimension']}', color: textColor),
                  InnovayDividerDot(color: textColor),
                  InnoText('ID_${albumFile.id}', color: textColor),
                ]),
              const SizedBox(height: 10),
              Row(children: [const SizedBox(width: 5), InnoText('Tap to share download link', color: textColor)]),
              const SizedBox(height: 3),
              Row(children: [
                const SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      ClipboardData data = ClipboardData(
                        text: albumFile.originalFileUrl,
                      );
                      await Clipboard.setData(data);
                      SnackBarManager.displayMessage('Copied');
                    },
                    child: Text(
                      albumFile.originalFileUrl,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0x99FFCC70)),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _onShareTap() async {
    var dir = await getTemporaryDirectory();
    DebugManager.log(dir.path);
    var filePath = '';
    if (albumFile.fileType == 'image') {
      var cacheKey = albumFile.cacheKeyFile;
      filePath = "${dir.path}/cacheimage/$cacheKey";
      DebugManager.log("path = $filePath");
    } else {
      var cacheFile = await DefaultCacheManager().getSingleFile(albumFile.fileUrl, headers: albumFile.fileUrlHeaders);
      filePath = cacheFile.path;
    }
    var file = File(filePath);
    if (!file.existsSync()) {
      Share.shareUri(Uri.parse(albumFile.originalFileUrl));
      return;
    }
    Share.shareXFiles([XFile(file.path)]);
  }

  void _onDownloadMediaFileTap(bool downloadOriginal) {
    InnoGlobalData.mediaFileDownloader.add(albumFile, downloadOriginal);
  }
}
