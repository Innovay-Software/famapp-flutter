import 'package:flutter/material.dart';

import '../../config.dart';
import 'base_button.dart';

class InnovayBackgroundOutlineButton extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayBackgroundOutlineButton(
    this.text,
    this.color,
    this.onTap, {
    super.key,
    this.fontSize = 14,
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
        foregroundColor: color,
        borderColor: InnoConfig.colors.dividerLineColor,
        onTap: onTap,
        prefixWidget: prefixWidget,
        postfixWidget: postfixWidget);
  }
}
