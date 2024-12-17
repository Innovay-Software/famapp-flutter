import 'package:flutter/material.dart';

import '../../config.dart';
import 'base_button.dart';

class InnovayBackgroundButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color? backgroundColor;
  final double fontSize;
  final double vExtraPadding;
  final double hExtraPadding;
  final bool zeroPadding;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayBackgroundButton(
    this.text,
    this.textColor,
    this.onTap, {
    super.key,
    this.fontSize = 14,
    this.prefixWidget,
    this.postfixWidget,
    this.backgroundColor,
    this.vExtraPadding = 0,
    this.hExtraPadding = 0,
    this.zeroPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return InnovayBaseButton(
      text: text,
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      backgroundColor: backgroundColor ?? InnoConfig.colors.backgroundColor,
      foregroundColor: textColor,
      borderColor: backgroundColor ?? InnoConfig.colors.backgroundColor,
      onTap: onTap,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
      zeroPadding: zeroPadding,
      vExtraPadding: vExtraPadding,
      hExtraPadding: hExtraPadding,
    );
  }
}
