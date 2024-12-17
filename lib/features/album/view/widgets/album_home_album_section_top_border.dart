import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import '../../../../core/config.dart';

class AlbumHomeAlbumSectionTopBorder extends StatelessWidget {
  final double height;

  const AlbumHomeAlbumSectionTopBorder({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BottomTab0AlbumSectionTopBorderPainter(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
      ),
    );
  }
}

class BottomTab0AlbumSectionTopBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = Colors.white.withOpacity(0.99);
    var initialOffsetY = 25.0;
    var borderWidth = 4.0;
    var radius = 800.0;
    var customPath1 = Path()
      ..moveTo(0, initialOffsetY)
      ..arcToPoint(
        Offset(size.width, initialOffsetY),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width, initialOffsetY + borderWidth)
      ..arcToPoint(Offset(0, initialOffsetY + borderWidth), radius: const Radius.circular(1000), clockwise: false);
    canvas.drawPath(customPath1, paint1);

    final paint2 = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.5, 0),
        Offset(size.width * 0.5, size.height),
        [
          const Color(0xFFDDDDDD),
          InnoConfig.colors.backgroundColorTinted3,
        ],
      );

    // ..color = InnovayConfig.colors.backgroundColorTinted3;
    var customPath2 = Path()
      ..moveTo(0, initialOffsetY + borderWidth)
      ..arcToPoint(
        Offset(size.width, initialOffsetY + borderWidth),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    canvas.drawPath(customPath2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
