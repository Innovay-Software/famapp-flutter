import 'package:flutter/material.dart';

import '../config.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final bool readonly;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final String initialValue;
  final TextAlign textAlign;
  final String hintText;
  final String textFieldStyle;
  final double fontSize;
  final Color? textColor;
  final Color? backgroundColor;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? postfixIcon;
  final Function(String)? onChange;
  final Function(String)? onComplete;
  final TextEditingController? textEditingController;

  const CustomTextFieldWidget({
    super.key,
    this.readonly = false,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.initialValue = '',
    this.textAlign = TextAlign.center,
    this.hintText = '',
    this.textFieldStyle = 'outline',
    this.fontSize = 14,
    this.textColor,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.prefixIcon,
    this.postfixIcon,
    this.onChange,
    this.onComplete,
    this.textEditingController,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  String _currentValue = '';

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  EdgeInsetsGeometry getPadding() {
    return const EdgeInsets.only(top: 12, bottom: 8, left: 5, right: 5);
  }

  Widget buildReadonlyContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? InnoConfig.colors.backgroundColorTinted,
        borderRadius: BorderRadius.circular(114),
      ),
      child: child,
    );
  }

  Widget buildOutlineContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? InnoConfig.colors.backgroundColorTinted,
        borderRadius: BorderRadius.circular(114),
        border: Border.all(width: 1, color: widget.backgroundColor ?? InnoConfig.colors.dividerLineColor),
      ),
      child: child,
    );
  }

  Widget buildUnderlineContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? InnoConfig.colors.backgroundColorTinted,
          // borderRadius: BorderRadius.circular(114),
          border: Border(bottom: BorderSide(width: 1, color: InnoConfig.colors.dividerLineColor)),
        ),
        child: child);
  }

  Widget buildNoBordersContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? InnoConfig.colors.backgroundColorTinted,
          borderRadius: BorderRadius.circular(114),
          border: Border.all(width: 0, color: widget.backgroundColor ?? InnoConfig.colors.backgroundColor),
        ),
        child: child);
  }

  Widget buildContainer(Widget child) {
    var children = <Widget>[widget.prefixIcon ?? const SizedBox.shrink(), Expanded(child: child), widget.postfixIcon ?? const SizedBox.shrink()];

    child = Row(crossAxisAlignment: CrossAxisAlignment.center, children: children);

    if (widget.readonly) return buildReadonlyContainer(child);
    switch (widget.textFieldStyle) {
      case 'noBorders':
        return buildNoBordersContainer(child);
      case 'underline':
        return buildUnderlineContainer(child);
    }
    return buildOutlineContainer(child);
  }

  @override
  Widget build(BuildContext context) {
    var textColor = widget.textColor ?? InnoConfig.colors.textColor;

    return Focus(
      canRequestFocus: true,
      onFocusChange: (hasFocus) {
        if (!hasFocus && widget.onComplete != null) {
          if (widget.readonly) return;
          widget.onComplete!(_currentValue);
        }
      },
      child: buildContainer(
        TextField(
          style: TextStyle(
            fontSize: widget.fontSize,
            height: 1.25,
            color: textColor,
          ),
          obscureText: widget.obscureText,
          cursorHeight: widget.fontSize * 1.25,
          autofocus: false,
          readOnly: widget.readonly,
          minLines: 1,
          maxLines: widget.maxLines,

          // textInputAction: widget.multiline ? TextInputAction.newline : TextInputAction.go,
          onChanged: (val) {
            _currentValue = val;
            if (widget.onChange != null) {
              widget.onChange!(val);
            }
          },
          controller: widget.textEditingController ??
              TextEditingController.fromValue(
                TextEditingValue(
                  text: _currentValue,
                  selection: TextSelection.collapsed(offset: _currentValue.length),
                ),
              ),
          textAlign: widget.textAlign,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            // icon: widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: widget.fontSize, color: InnoConfig.colors.textColorLight9),
            contentPadding: getPadding(),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          keyboardType: widget.maxLines > 1 ? TextInputType.multiline : widget.textInputType,
          // keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}
