import 'package:flutter/material.dart';

import 'innovay_text.dart';

class SizedText extends StatelessWidget {
  final double width;
  final String text;
  final Color? color;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextStyle? style;

  const SizedText(
    this.width,
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
    return SizedBox(
        width: width,
        child: InnoText(text,
            color: color,
            textAlign: textAlign ?? TextAlign.start,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            style: style));
  }
}
