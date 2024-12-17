import 'package:flutter/material.dart';

import '../../config.dart';
import '../expanded_children_row.dart';
import 'bottom_picker_action_button.dart';

class InnovayBottomPickerActionButtonRow extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final double borderTop;
  final double borderBottom;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayBottomPickerActionButtonRow(
    this.text,
    this.textColor,
    this.onTap, {
    super.key,
    this.fontSize = 16,
    this.prefixWidget,
    this.postfixWidget,
    this.borderTop = 1,
    this.borderBottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedChildrenRow(children: [
      Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: borderTop, color: InnoConfig.colors.dividerLineColor),
            bottom: BorderSide(width: borderBottom, color: InnoConfig.colors.dividerLineColor),
          )),
          child: InnovayBottomPickerActionButton(text, textColor, onTap,
              fontSize: fontSize, prefixWidget: prefixWidget, postfixWidget: postfixWidget))
    ]);
  }
}
