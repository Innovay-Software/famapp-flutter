import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/services/media_file_upload_background_service.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/bottom_picker_action_button_row.dart';
import '../../../core/widgets/cached_image.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../../core/widgets/no_content_placeholder_widget.dart';
import '../model/album_file_upload_item_model_v2.dart';

class AlbumFileUploaderPage extends StatefulWidget {
  const AlbumFileUploaderPage({super.key});

  @override
  State<StatefulWidget> createState() => _AlbumFileUploaderPageState();
}

class _AlbumFileUploaderPageState extends State<AlbumFileUploaderPage> {
  final MediaFileUploadBackgroundService _mediaFileUploader = InnoGlobalData.mediaFileBackgroundUploader;
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
    var spacing = 2.0;
    var rowItemCount = 3;
    var size = ((MediaQuery.of(context).size.width - spacing * (rowItemCount + 1)) / 3).floorToDouble();
    var uploadItems = _mediaFileUploader.getUploadItems();

    return Scaffold(
      appBar: const InnoAppBar(false, 'Upload Tasks', []),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: _mediaFileUploader.uploadItemsMap.isEmpty
          ? const Center(
              child: InnoNoContentPlaceholder(
              contentText: 'No upload tasks',
            ))
          : Container(
              padding: EdgeInsets.all(spacing),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowItemCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                ),
                itemCount: uploadItems.length,
                itemBuilder: (context, index) {
                  var uploadJob = uploadItems[index];
                  var uploadProgress = uploadJob.getUploadProgress();
                  return Stack(children: [
                    InnovayCachedImage(
                      uploadJob.isVideoFile() ? uploadJob.localThumbnailPath : uploadJob.originalPath,
                      width: size,
                      height: size,
                    ),
                    Container(
                      width: size,
                      height: size,
                      color: InnoConfig.colors.loadingGreyTransparentBackgroundColor,
                    ),
                    // if (downloadJob.error != null) const Center(child: Icon(Icons.error_outline, color: Colors.red)),
                    if (uploadJob.isCancelled)
                      const Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.remove_circle_outline, size: 28, color: Colors.redAccent),
                          SizedBox(height: 5),
                          InnoText(
                            'Cancelled',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ]),
                      ),
                    if (!uploadJob.isCancelled && uploadProgress < 100)
                      Center(
                        child: SizedBox(
                          width: size * .5,
                          height: size * .5,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            value: uploadProgress / 100,
                            semanticsLabel: '$uploadProgress%',
                            semanticsValue: '$uploadProgress%',
                          ),
                        ),
                      ),
                    if (!uploadJob.isCancelled && uploadProgress < 100)
                      Center(
                        child: InnoText(
                          '${uploadJob.getCompletedTaskIds()}/${uploadJob.getTotalTaskIds()}',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (!uploadJob.isCancelled && uploadProgress >= 100)
                      const Center(child: Icon(Icons.check_circle_outline, size: 28, color: Colors.greenAccent)),

                    Positioned(
                      top: 1,
                      right: 1,
                      child: InnoText('AID: ${uploadJob.targetAlbumId}', color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        _onJobTap(uploadJob);
                      },
                      child: Container(width: size, height: size, color: Colors.transparent),
                    )
                  ]);
                },
              ),
            ),
    );
  }

  void _onJobTap(AlbumFileUploadItemModelV2 uploadJob) {
    CommonUtils.displayBottomPicker(context, '', [
      InnovayBottomPickerActionButtonRow(
        '',
        prefixWidget: Icon(CupertinoIcons.pause_circle_fill, color: InnoConfig.colors.deleteColor),
        InnoConfig.colors.deleteColor,
        () {
          Navigator.pop(context);
          CommonUtils.displayCustomDialog(
            context,
            'Cancel upload task？',
            [],
            Icon(Icons.cancel_outlined, color: InnoConfig.colors.textColorLight9),
            null,
            Icon(CupertinoIcons.delete_simple, color: InnoConfig.colors.deleteColor),
            () => null,
            () {
              _mediaFileUploader.cancelJob(uploadJob);
            },
            true,
          );
        },
      )
    ]);
  }
}
