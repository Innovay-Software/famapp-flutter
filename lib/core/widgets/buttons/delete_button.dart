import 'package:flutter/material.dart';

import '../../config.dart';
import 'base_button.dart';

class InnovayDeleteButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayDeleteButton(
    this.text,
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
      backgroundColor: InnoConfig.colors.deleteColor,
      foregroundColor: InnoConfig.colors.deleteColorTextColor,
      borderColor: InnoConfig.colors.deleteColor,
      onTap: onTap,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
    );
  }
}
