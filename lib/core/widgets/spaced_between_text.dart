import 'package:flutter/material.dart';

import 'innovay_text.dart';

class InnovaySpacedBetweenText extends StatelessWidget {
  final String text;
  final double width;
  final TextStyle textStyle;

  const InnovaySpacedBetweenText({
    super.key,
    required this.text,
    required this.width,
    this.textStyle = const TextStyle(),
  });

  List<Widget> buildTextList() {
    List<Widget> list = [];
    var textParts = text.split('');
    for (var i = 0; i < textParts.length; i++) {
      list.add(InnoText(textParts[i], style: textStyle));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buildTextList(),
      ),
    );
  }
}
