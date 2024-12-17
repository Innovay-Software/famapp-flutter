import 'package:flutter/material.dart';

class LoginBackgroundSectionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = Colors.white.withOpacity(0.3);
    final points1 = [
      const Offset(0, 0),
      Offset(size.width, size.height - 20),
      Offset(size.width, size.height),
      Offset(0, size.height),
    ];
    final customPath1 = Path()
      ..moveTo(points1[0].dx, points1[0].dy)
      ..cubicTo(
        points1[0].dx + 150,
        points1[0].dy - 50,
        points1[1].dx - 100,
        points1[1].dy,
        points1[1].dx,
        points1[1].dy,
      )
      ..lineTo(points1[2].dx, points1[2].dy)
      ..lineTo(points1[3].dx, points1[3].dy)
      ..lineTo(points1[0].dx, points1[0].dy);

    canvas.drawPath(customPath1, paint1);

    final paint2 = Paint()..color = Colors.white;
    final points2 = [
      const Offset(0, 50),
      Offset(size.width, size.height - 10),
      Offset(size.width, size.height),
      Offset(0, size.height),
    ];

    final customPath2 = Path()
      ..moveTo(points2[0].dx, points2[0].dy)
      ..cubicTo(
        points2[0].dx + 100,
        points2[0].dy - 50,
        points2[1].dx - 100,
        points2[1].dy,
        points2[1].dx,
        points2[1].dy,
      )
      ..lineTo(points2[2].dx, points2[2].dy)
      ..lineTo(points2[3].dx, points2[3].dy)
      ..lineTo(points2[0].dx, points2[0].dy);

    canvas.drawPath(customPath2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LoginBackgroundSectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final points1 = [
      const Offset(0, 0),
      Offset(size.width, size.height - 20),
      Offset(size.width, size.height),
      Offset(0, size.height),
    ];

    return Path()
      ..moveTo(points1[0].dx, points1[0].dy)
      ..cubicTo(
        points1[0].dx + 150,
        points1[0].dy - 50,
        points1[1].dx - 100,
        points1[1].dy,
        points1[1].dx,
        points1[1].dy,
      )
      ..lineTo(points1[2].dx, points1[2].dy)
      ..lineTo(points1[3].dx, points1[3].dy)
      ..lineTo(points1[0].dx, points1[0].dy);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
