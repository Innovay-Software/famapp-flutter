import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'innovay_text.dart';

class InnovayCachedImage extends StatefulWidget {
  final String url;
  final String errorText;
  final String? cacheKey;
  final Color loadingBackgroundColor;
  final Color loadingForegroundColor;
  final Color errorBackgroundColor;
  final Color errorForegroundColor;
  final double errorTextSize;
  final bool clearCache;
  final bool allowLongPress;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final Map<String, String>? httpHeaders;

  const InnovayCachedImage(
    this.url, {
    super.key,
    this.errorText = '',
    this.cacheKey,
    this.loadingBackgroundColor = Colors.white,
    this.loadingForegroundColor = Colors.black,
    this.errorBackgroundColor = Colors.grey,
    this.errorForegroundColor = Colors.white,
    this.errorTextSize = 20,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholderWidget,
    this.errorWidget,
    this.httpHeaders,
    this.clearCache = false,
    this.allowLongPress = true,
  });

  @override
  State<InnovayCachedImage> createState() => _InnovayCachedImageState();
}

class _InnovayCachedImageState extends State<InnovayCachedImage> {
  bool _clearCache = false;
  bool _clearCacheCompleted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _clearCache = widget.clearCache;
    if (_clearCache) {
      _clearCacheCompleted = false;
      _removeCache();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.isEmpty) {
      if (widget.placeholderWidget != null) {
        return widget.placeholderWidget!;
      }
      return const Center(child: Icon(Icons.image_outlined));
    }
    if (_clearCache && !_clearCacheCompleted) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(color: Colors.blueGrey),
      );
    }
    // DebugManager.log(widget.url);
    return GestureDetector(
      child: Container(
        color: widget.loadingBackgroundColor,
        child: _isLocalFile()
            ? Image.file(
                File(widget.url),
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
              )
            : ExtendedImage.network(
                widget.url,
                cache: true,
                cacheKey: widget.cacheKey,
                width: widget.width,
                height: widget.height,
                headers: widget.httpHeaders,
                fit: widget.fit,
                printError: false,
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
                    // DebugManager.log("Failed to load image: ${widget.url}, headers: ${widget.httpHeaders}");
                    if (widget.errorWidget != null) {
                      return widget.errorWidget;
                    }
                    return const Center(child: InnoText("Error"));
                  }
                  return null;
                },
              ),
      ),
    );
  }

  void _removeCache() async {
    if (widget.cacheKey != null) {
      var file = await getCachedImageFile(widget.url, cacheKey: widget.cacheKey);
      if (file != null) {
        // DebugManager.log("file path = ${file.path} for ${widget.url}");
        var data = await getNetworkImageData(widget.url, useCache: false);
        if (data != null) {
          await file.writeAsBytes(data);
        }
      } else {
        // DebugManager.log("File is null: ${widget.url}");
      }
    }
    clearMemoryImageCache();
    // After evict completed, set _clearCache to false and reload
    _clearCache = false;
    _clearCacheCompleted = true;

    setState(() {});
  }

  bool _isLocalFile() {
    return !widget.url.startsWith('http');
  }
}
