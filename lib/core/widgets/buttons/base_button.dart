import 'package:flutter/material.dart';

class InnovayBaseButton extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double fontSize;
  final double borderWidth;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double vExtraPadding;
  final double hExtraPadding;
  final bool zeroPadding;
  final Widget? prefixWidget;
  final Widget? postfixWidget;
  final Function()? onTap;

  const InnovayBaseButton({
    super.key,
    this.text = '',
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.blue,
    this.borderColor = Colors.blue,
    this.borderWidth = 1,
    this.topLeftRadius = 40,
    this.topRightRadius = 40,
    this.bottomLeftRadius = 40,
    this.bottomRightRadius = 40,
    this.vExtraPadding = 0,
    this.hExtraPadding = 0,
    this.zeroPadding = false,
    this.prefixWidget,
    this.postfixWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: borderWidth),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: zeroPadding
            ? const EdgeInsets.all(0)
            : EdgeInsets.only(
                top: fontSize * 0.6 + vExtraPadding,
                bottom: fontSize * 0.6 + vExtraPadding,
                left: fontSize * 0.6 + hExtraPadding,
                right: fontSize * 0.6 + hExtraPadding),
        enableFeedback: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
          ),
        ),
      ),
      onPressed: onTap,
      child: prefixWidget == null && postfixWidget == null
          ? Text(text, style: TextStyle(color: foregroundColor, fontSize: fontSize, fontWeight: fontWeight))
          : Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              prefixWidget != null
                  ? Container(margin: EdgeInsets.only(right: text.isEmpty ? 0 : fontSize * 0.3), child: prefixWidget)
                  : const SizedBox.shrink(),
              // Expanded(flex: 1, child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight))),
              Text(text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: foregroundColor, fontSize: fontSize, fontWeight: fontWeight, height: 1.2)),
              postfixWidget != null
                  ? Container(margin: EdgeInsets.only(left: text.isEmpty ? 0 : fontSize * 0.3), child: postfixWidget)
                  : const SizedBox.shrink(),
            ]),
    );
  }
}
