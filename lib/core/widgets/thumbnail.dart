import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'cached_image_progress_circle.dart';

class InnoThumbnail extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double borderRadius;

  const InnoThumbnail(
    this.url,
    this.width,
    this.height, {
    super.key,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    var url = '${this.url}?type=thumbnail';
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        cacheKey: url.split('?').first,
        maxHeightDiskCache: 480,
        maxWidthDiskCache: 240,
        progressIndicatorBuilder: (context, str, progress) {
          return InnovayCachedImageProgressCircle(progress: progress.progress ?? 0);
        },
        imageUrl: url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Image.asset('assets/innovay/ImagePlaceholder.png', width: width, height: height, fit: BoxFit.contain);
        },
      ),
    );
  }
}
