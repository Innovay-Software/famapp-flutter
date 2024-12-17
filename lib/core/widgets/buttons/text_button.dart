import 'package:flutter/material.dart';

class InnovayTextButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function() onTap;

  const InnovayTextButton(
    this.text,
    this.onTap, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = const Color(0xFF1A9FFC),
    this.prefixWidget,
    this.postfixWidget,
  });

  TextStyle getTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      prefixWidget ?? const SizedBox.shrink(),
      Text(text, style: getTextStyle()),
      postfixWidget ?? const SizedBox.shrink(),
    ];
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(bottom: 2),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      child: Row(children: children),
    );
  }
}
