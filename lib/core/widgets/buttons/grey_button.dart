import 'package:flutter/material.dart';

import '../../config.dart';
import 'base_button.dart';

class InnovayGreyButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayGreyButton(
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
      backgroundColor: InnoConfig.colors.greyColor,
      foregroundColor: InnoConfig.colors.greyColorTextColor,
      borderColor: InnoConfig.colors.greyColor,
      onTap: onTap,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
    );
  }
}
