import 'dart:io';

// import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/config.dart';
import '../../../../core/global_data.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../../../features/album/model/album_file.dart';

class MediaSlideShowItemCleanCachedVideoPlayerWidget extends StatefulWidget {
  final AlbumFile albumFile;

  const MediaSlideShowItemCleanCachedVideoPlayerWidget({super.key, required this.albumFile});

  @override
  State<MediaSlideShowItemCleanCachedVideoPlayerWidget> createState() =>
      _MediaSlideShowItemCleanCachedVideoPlayerWidgetState();
}

class _MediaSlideShowItemCleanCachedVideoPlayerWidgetState
    extends State<MediaSlideShowItemCleanCachedVideoPlayerWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.albumFile.isPreprocessing) {
      return;
    }
    var url = widget.albumFile.fileUrl;
    var headers = widget.albumFile.fileUrlHeaders;
    if (InnoGlobalData.isHighQualityMediaFileModeOn) {
      url = widget.albumFile.originalFileUrl;
      headers = {};
    }
    DebugManager.log("MediaSlideShowVideoItem: $url, $headers");
    if (widget.albumFile.fileType != 'video') return;

    if (url.startsWith('http')) {
      DebugManager.log("is http video");
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url), httpHeaders: headers)
        ..initialize().then((_) {
          DebugManager.log("Video initialized, playing...");
          _videoController.play();
          _videoController.setLooping(true);
          if (!mounted) return;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            if (mounted) setState(() {});
          });
        }).onError((error, stackTrace) {
          DebugManager.log("VideoController error");
          DebugManager.log(error.toString());
          DebugManager.log(stackTrace.toString());
        });
    } else {
      DebugManager.log("is local file video");
      _videoController = VideoPlayerController.file(File(url))
        ..initialize().then((_) {
          _videoController.play();
          _videoController.setLooping(true);
          if (mounted) {
            setState(() {});
            Future.delayed(const Duration(milliseconds: 500)).then((value) {
              if (mounted) setState(() {});
            });
          }
        });
    }
  }

  @override
  void dispose() {
    try {
      _videoController.dispose();
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.albumFile.fileType != 'video') {
      return const SizedBox.shrink();
    }
    if (widget.albumFile.isPreprocessing) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 30),
        const SizedBox(height: 20),
        InnoText(AppLocalizations.of(context)!.processingInProgress, color: Colors.white),
      ]);
    }
    return Stack(children: [
      if (!_videoController.value.isInitialized || _videoController.value.isBuffering)
        Center(
          child: Stack(
            children: [
              // Center(child: CachedNetworkImage(imageUrl: thumbnailUrl)),
              Center(
                child: Container(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      if (_videoController.value.isInitialized)
        Center(
          child: AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          ),
        ),
      if (_videoController.value.isInitialized && !_videoController.value.isPlaying)
        const Center(child: Icon(Icons.play_circle, color: Colors.white, size: 60)),
      if (_videoController.value.isInitialized)
        Positioned(
          left: 30,
          right: 30,
          bottom: 88,
          child: VideoProgressIndicator(
            _videoController,
            allowScrubbing: true,
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            colors: VideoProgressColors(playedColor: InnoConfig.colors.primaryColorLighter),
          ),
        ),
      Positioned.fill(
        child: GestureDetector(
          onTap: () {
            if (!_videoController.value.isInitialized) return;
            setState(() {
              _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
            });
          },
        ),
      ),
    ]);
  }
}
