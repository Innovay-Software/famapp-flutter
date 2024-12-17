import 'package:flutter/material.dart';

import '../../config.dart';
import 'base_button.dart';

class InnovayBottomPickerActionButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayBottomPickerActionButton(
    this.text,
    this.textColor,
    this.onTap, {
    super.key,
    this.fontSize = 16,
    this.prefixWidget,
    this.postfixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InnovayBaseButton(
        text: text,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        backgroundColor: InnoConfig.colors.backgroundColor,
        foregroundColor: textColor,
        borderColor: InnoConfig.colors.backgroundColor,
        borderWidth: 0,
        onTap: onTap,
        prefixWidget: prefixWidget,
        postfixWidget: postfixWidget,
        topLeftRadius: 0,
        topRightRadius: 0,
        bottomLeftRadius: 0,
        bottomRightRadius: 0,
        vExtraPadding: 10);
  }
}
