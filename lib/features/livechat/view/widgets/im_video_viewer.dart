// import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/config.dart';

class ImVideoViewerWidget extends StatefulWidget {
  final String localThumbnailPath;
  final String videoUrl;
  final Map<String, String> videoUrlHeaders;

  const ImVideoViewerWidget({
    super.key,
    required this.localThumbnailPath,
    required this.videoUrl,
    this.videoUrlHeaders = const {},
  });

  @override
  State<ImVideoViewerWidget> createState() => _ImVideoViewerWidgetState();
}

class _ImVideoViewerWidgetState extends State<ImVideoViewerWidget> {
  final bool _isLoading = true;
  final double _loadingProgress = 0;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl), httpHeaders: widget.videoUrlHeaders)
      ..initialize().then((_) {
        _videoController.play();
        _videoController.setLooping(true);
        if (!mounted) return;
        setState(() {});
      });
    _videoController.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
  //
  // Widget _buildProgressWidget(BuildContext context, ImageChunkEvent? imageChunkEvent) {
  //   // return InnovayCachedImageProgressCircle(progress: progress.progress ?? 0);
  //   var children = <Widget>[
  //     Center(
  //       child: CachedNetworkImage(
  //         cacheKey: widget.folderFile.thumbnailUrl.split('?').first,
  //         imageUrl: widget.folderFile.thumbnailUrl,
  //       ),
  //     ),
  //     Center(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(100),
  //           color: Colors.white.withOpacity(0.5),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.8),
  //               spreadRadius: 2,
  //               blurRadius: 1,
  //               offset: Offset.zero, // changes position of shadow
  //             ),
  //           ],
  //         ),
  //         padding: const EdgeInsets.all(2),
  //         width: 50,
  //         height: 50,
  //         child: CircularProgressIndicator(
  //           value: imageChunkEvent == null || imageChunkEvent.expectedTotalBytes == null
  //               ? 0.01
  //               : 1.0 * imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes!,
  //           valueColor: AlwaysStoppedAnimation<Color>(InnovayConfig.colors.primaryColorLighter),
  //         ),
  //       ),
  //     )
  //   ];
  //   if (imageChunkEvent != null && imageChunkEvent.expectedTotalBytes != null) {
  //     children.add(Center(
  //         child: InnovayText(
  //       '${(1.0 * imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes! * 100).round()}%',
  //       fontSize: 10,
  //     )));
  //   }
  //   return Center(child: Stack(children: children));
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Stack(
        children: [
          if (_videoController.value.isInitialized)
            InteractiveViewer(
                child: Center(
                    child: AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ))),
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
          if (_videoController.value.isInitialized && !_videoController.value.isPlaying)
            const Center(child: Icon(Icons.play_circle, color: Colors.white, size: 60)),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                if (!_videoController.value.isInitialized) return;
                setState(() {
                  _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
                });
              },
            ),
          ),
          if (_videoController.value.isInitialized)
            Positioned(
              left: 30,
              right: 30,
              bottom: 0,
              child: VideoProgressIndicator(
                _videoController,
                allowScrubbing: true,
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                colors: VideoProgressColors(playedColor: InnoConfig.colors.primaryColor),
              ),
            ),
        ],
      ),
    );
  }
}
