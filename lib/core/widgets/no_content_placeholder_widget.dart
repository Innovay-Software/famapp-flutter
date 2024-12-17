import 'package:flutter/material.dart';

import '../config.dart';
import 'innovay_text.dart';

class InnoNoContentPlaceholder extends StatelessWidget {
  final String contentText;
  const InnoNoContentPlaceholder({super.key, this.contentText = 'no contents...'});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/innovay/NoContent.png', width: 70, height: 70, fit: BoxFit.cover),
          const SizedBox(height: 20),
          InnoText(contentText, fontSize: 12, color: InnoConfig.colors.textColorLight9),
        ]);
  }
}
