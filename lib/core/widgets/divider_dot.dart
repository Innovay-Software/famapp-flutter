import 'package:flutter/material.dart';


class InnovayDividerDot extends StatelessWidget {
  final Color? color;
  final double width;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;

  const InnovayDividerDot({
    super.key,
    this.color = Colors.black,
    this.width = 5,
    this.height = 5,
    this.horizontalPadding = 10,
    this.verticalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 5,
      height: 5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
    );
  }
}
