import 'package:flutter/material.dart';

import '../../config.dart';
import 'base_button.dart';

class InnovayPrimaryButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayPrimaryButton(
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
      backgroundColor: InnoConfig.colors.primaryColor,
      foregroundColor: Colors.white,
      borderColor: InnoConfig.colors.primaryColor,
      onTap: onTap,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
    );
  }
}
