import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/global_data.dart';
import '../../../../core/services/media_file_upload_background_service.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/album.dart';
import '../album_file_uploader_page.dart';

class AlbumHomeUploadBackgroundButton extends StatefulWidget {
  final List<Album> albums;
  final Album currentAlbum;
  final int Function() getCurrentAlbumId;

  const AlbumHomeUploadBackgroundButton({
    super.key,
    required this.albums,
    required this.currentAlbum,
    required this.getCurrentAlbumId,
  });

  @override
  State<AlbumHomeUploadBackgroundButton> createState() => _AlbumHomeUploadBackgroundButtonState();
}

class _AlbumHomeUploadBackgroundButtonState extends State<AlbumHomeUploadBackgroundButton> {
  final MediaFileUploadBackgroundService _mediaFileBackgroundUploader = InnoGlobalData.mediaFileBackgroundUploader;
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

  // @override
  // void dispose() {
  //   _periodicUpdateTimer.cancel();
  //   super.dispose();
  // }

  void _refreshPage() {
    // DebugManager.log("Upload background button.refresh ${_mediaFileBackgroundUploader.uploadItems.length}");
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var uploadProgress = _mediaFileBackgroundUploader.getCurrentUploadProgress();
    var size = 22.0;
    return Stack(clipBehavior: Clip.none, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: _onUploadMediaTap,
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
            width: 36,
            height: 36,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: Stack(children: [
              Icon(Icons.camera, color: InnoConfig.colors.primaryColor, size: 36),
              if (_mediaFileBackgroundUploader.uploadItemsMap.isNotEmpty)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: CircularProgressIndicator(
                        value: max(0.01, uploadProgress / 100.0),
                        valueColor: AlwaysStoppedAnimation<Color>(InnoConfig.colors.successColor),
                      ),
                    ),
                  ),
                ),
              if (_mediaFileBackgroundUploader.uploadItemsMap.isNotEmpty)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: InnoText(uploadProgress.toString(), fontSize: 8),
                      ),
                    ),
                  ),
                ),
            ]),
          ),
        ),
        // Padding(
        //     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15),
        //     child:
        //
        //     CircleAvatar(
        //         radius: 18,
        //         backgroundColor: Colors.white.withOpacity(0.9),
        //         child: IconButton(
        //           padding: EdgeInsets.zero,
        //           constraints: const BoxConstraints(),
        //           iconSize: 36,
        //           icon: Icon(Icons.camera, color:  InnovayConfig.colors.primaryColor),
        //           onPressed: onUploadMediaTap,
        //         )))
      ]),
    ]);
  }

  void _onUploadMediaTap() {
    if (_mediaFileBackgroundUploader.uploadItemsMap.isNotEmpty) {
      Navigator.push(
        InnoGlobalData.bottomNavigatorContext!,
        MaterialPageRoute(
          builder: (context) => const AlbumFileUploaderPage(),
        ),
      );
      return;
    }
    return _mediaFileBackgroundUploader.onPickMediaTap(widget.currentAlbum.id);
  }
}
