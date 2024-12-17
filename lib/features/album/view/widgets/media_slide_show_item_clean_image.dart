import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/global_data.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/album_file.dart';

class MediaSlideShowItemCleanImageWidget extends StatefulWidget {
  final AlbumFile albumFile;
  const MediaSlideShowItemCleanImageWidget({super.key, required this.albumFile});

  @override
  State<MediaSlideShowItemCleanImageWidget> createState() => _MediaSlideShowItemCleanImageWidgetState();
}

class _MediaSlideShowItemCleanImageWidgetState extends State<MediaSlideShowItemCleanImageWidget> {
  bool _isLoading = true;
  String _url = '';
  Map<String, String> _headers = {};
  String _cacheKey = '';

  @override
  void initState() {
    super.initState();
    _url = widget.albumFile.fileUrl;
    _headers = widget.albumFile.fileUrlHeaders;
    _cacheKey = widget.albumFile.cacheKeyFile;
    if (InnoGlobalData.isHighQualityMediaFileModeOn) {
      _url = widget.albumFile.originalFileUrl;
      _headers = {};
      _cacheKey = widget.albumFile.cacheKeyOriginalFile;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.albumFile.fileType != 'image') {
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
      if (_isLoading)
        Center(
          child: InnovayCachedImage(
            widget.albumFile.thumbnailUrl,
            cacheKey: widget.albumFile.cacheKeyThumbnail,
            httpHeaders: widget.albumFile.thumbnailUrlHeaders,
            fit: BoxFit.contain,
            loadingBackgroundColor: Colors.black,
            loadingForegroundColor: Colors.white,
            placeholderWidget: const SizedBox.shrink(),
          ),
        ),
      Positioned.fill(
        child: ExtendedImage.network(
          _url,
          cacheKey: _cacheKey,
          headers: _headers,
          fit: BoxFit.contain,
          cacheMaxAge: const Duration(days: 365),
          handleLoadingProgress: true,
          loadStateChanged: (ExtendedImageState state) {
            if (state.extendedImageLoadState == LoadState.loading) {
              return Center(child: LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 30));
            }
            if (_isLoading && state.extendedImageLoadState == LoadState.completed) {
              _isLoading = false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() {});
              });
              return null;
            }
            if (state.extendedImageLoadState == LoadState.failed) {
              DebugManager.error("Error loading image: $_url");
            }
            return null;
          },
        ),
      ),
    ]);
  }
}
