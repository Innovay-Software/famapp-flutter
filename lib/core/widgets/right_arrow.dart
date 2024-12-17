import 'package:flutter/material.dart';

import '../config.dart';

class InnovayRightArrow extends StatelessWidget {
  final Color? color;
  final Function()? onTap;

  const InnovayRightArrow({super.key, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    var contentWidget = SizedBox(
        width: 30,
        height: 30,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios_rounded, size: 15, color: color ?? InnoConfig.colors.textColorLight9)
          ],
        ));

    if (onTap == null) {
      return contentWidget;
    }

    return GestureDetector(onTap: onTap, child: contentWidget);
  }
}
