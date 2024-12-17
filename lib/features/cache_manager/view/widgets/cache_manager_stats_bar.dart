import 'package:flutter/cupertino.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/innovay_text.dart';

class CacheManagerStatsBar extends StatelessWidget {
  final Icon icon;
  final String title;
  final String content;
  final Widget? actionButton;

  const CacheManagerStatsBar({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        // border: Border(bottom: BorderSide(color: InnovayConfig.colors.dividerLineColor)),
        color: InnoConfig.colors.backgroundColor,
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 20),
          InnoText(title, fontSize: 14),
          const Spacer(),
          InnoText(
            content,
            color: InnoConfig.colors.textColorLight7,
            fontSize: 12,
          ),
          const SizedBox(width: 20),
          actionButton ?? const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }
}
