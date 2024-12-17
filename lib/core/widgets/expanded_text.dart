import 'package:flutter/material.dart';

import 'innovay_text.dart';

class ExpandedText extends StatelessWidget {
  final int flex;
  final String text;
  final Color? color;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextStyle? style;

  const ExpandedText(
    this.text, {
    super.key,
    this.flex = 1,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.height = 1.15,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: InnoText(text,
            color: color,
            textAlign: textAlign,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            style: style));
  }
}
