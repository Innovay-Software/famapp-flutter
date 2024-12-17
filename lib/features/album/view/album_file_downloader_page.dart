import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/services/media_file_download_service.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/bottom_picker_action_button_row.dart';
import '../../../core/widgets/cached_image.dart';
import '../../../core/widgets/no_content_placeholder_widget.dart';

class AlbumFileDownloaderPage extends StatefulWidget {
  const AlbumFileDownloaderPage({super.key});

  @override
  State<StatefulWidget> createState() => _AlbumFileDownloaderPageState();
}

class _AlbumFileDownloaderPageState extends State<AlbumFileDownloaderPage> {
  final MediaFileDownloadService _mediaFileDownloader = InnoGlobalData.mediaFileDownloader;
  late Timer _periodicUpdateTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _periodicUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _refreshPage();
      });
    });
  }

  @override
  void dispose() {
    _periodicUpdateTimer.cancel();
    super.dispose();
  }

  void _refreshPage() {
    // DebugManager.log("_refreshPage");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var jobs = <MediaFileDownloadJob>[];
    for (var item in _mediaFileDownloader.jobs.reversed) {
      jobs.add(item);
    }
    var spacing = 2.0;
    var rowItemCount = 3;
    var size = ((MediaQuery.of(context).size.width - spacing * (rowItemCount + 1)) / 3).floorToDouble();
    return Scaffold(
      appBar: InnoAppBar(false, 'Download Progress', [
        IconButton(
          onPressed: () {
            _mediaFileDownloader.startNextAvailableJob();
          },
          icon: Icon(Icons.refresh, color: InnoConfig.colors.primaryColor),
        ),
      ]),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: jobs.isEmpty
          ? const Center(
              child: InnoNoContentPlaceholder(
              contentText: 'No downloads',
            ))
          : Container(
              color: InnoConfig.colors.backgroundColorTinted3,
              padding: EdgeInsets.all(spacing),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowItemCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                ),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  var downloadJob = jobs[index];
                  return Stack(children: [
                    InnovayCachedImage(
                      downloadJob.albumFile.thumbnailUrl,
                      httpHeaders: downloadJob.albumFile.thumbnailUrlHeaders,
                      width: size,
                      height: size,
                    ),
                    Container(
                      width: size,
                      height: size,
                      color: InnoConfig.colors.loadingGreyTransparentBackgroundColor,
                    ),
                    if (downloadJob.error != null) const Center(child: Icon(Icons.error_outline, color: Colors.red)),
                    if (downloadJob.progress < 100)
                      Center(
                        child: SizedBox(
                          width: size * .3,
                          height: size * .3,
                          child: CircularProgressIndicator(
                            color: InnoConfig.colors.primaryColorLighter,
                            backgroundColor: Colors.white,
                            value: downloadJob.progress / 100,
                            semanticsLabel: '${downloadJob.progress}%',
                            semanticsValue: '${downloadJob.progress}%',
                          ),
                        ),
                      ),
                    if (downloadJob.progress >= 100)
                      const Center(child: Icon(Icons.check_circle_outline, size: 28, color: Colors.white)),
                    GestureDetector(
                        onTap: () {
                          _onDownloaderJobLongPress(downloadJob.albumFile.id);
                        },
                        child: Container(width: size, height: size, color: Colors.transparent))
                  ]);
                },
              ),
            ),
    );
  }

  void _onDownloaderJobLongPress(int albumFileId) {
    DebugManager.log("onDownloaderJobLongPress: $albumFileId");
    CommonUtils.displayBottomPicker(context, '', [
      InnovayBottomPickerActionButtonRow(
        '',
        prefixWidget: Icon(CupertinoIcons.delete_simple, color: InnoConfig.colors.deleteColor),
        InnoConfig.colors.deleteColor,
        () {
          Navigator.pop(context);
          CommonUtils.displayCustomDialog(
            context,
            'Delete download task?',
            [],
            Icon(Icons.cancel_outlined, color: InnoConfig.colors.textColorLight9),
            null,
            Icon(CupertinoIcons.delete_simple, color: InnoConfig.colors.deleteColor),
            () => null,
            () {
              _onDeleteJobTap(albumFileId);
            },
            true,
          );
        },
      )
    ]);
  }

  void _onDeleteJobTap(int albumFileId) {
    for (var item in _mediaFileDownloader.jobs) {
      if (item.albumFile.id == albumFileId) {
        _mediaFileDownloader.delete(item);
        break;
      }
    }
  }
}
