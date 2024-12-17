import 'package:flutter/material.dart';

import '../config.dart';

class InnoText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextStyle? style;

  const InnoText(
    this.text, {
    super.key,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.height = 1.15,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style ??
          TextStyle(
            color: color ?? InnoConfig.colors.textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
          ),
    );
  }
}
