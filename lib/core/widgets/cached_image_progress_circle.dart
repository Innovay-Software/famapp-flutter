import 'dart:math';

import 'package:flutter/material.dart';

import 'innovay_text.dart';

class InnovayCachedImageProgressCircle extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;

  const InnovayCachedImageProgressCircle({
    super.key,
    required this.progress,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(children: [
        Center(child: CircularProgressIndicator(value: max(0.05, progress))),
        Center(
          child: InnoText(
            '${(progress * 100).round()}%',
            color: foregroundColor,
            fontSize: 10,
          ),
        ),
      ]),
    );
  }
}
