import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'cached_image_progress_circle.dart';

class InnovayCachedImageWithOnTap extends StatelessWidget {
  final String uri;
  final String? cacheKey;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Function() onTap;

  const InnovayCachedImageWithOnTap(
    this.uri, {
    super.key,
    required this.onTap,
    this.cacheKey,
    this.width,
    this.height,
    this.fit,
  });

  bool isLocalFile() {
    return !uri.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isLocalFile()
          ? Image.file(
              File(uri),
              width: width,
              height: height,
              fit: fit ?? BoxFit.cover,
            )
          : CachedNetworkImage(
              cacheKey: cacheKey ?? uri.split('?').first,
              imageUrl: uri,
              width: width,
              height: height,
              fit: fit ?? BoxFit.cover,
              progressIndicatorBuilder: (context, str, progress) {
                return InnovayCachedImageProgressCircle(progress: progress.progress ?? 0);
              }),
    );
  }
}
