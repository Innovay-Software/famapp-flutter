import 'package:flutter/material.dart';

import 'app_bar_base.dart';

class InnoAppBarBlack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final bool showLeading;
  final double toolbarHeight;
  final Function()? onBackTap;

  @override
  final Size preferredSize;

  const InnoAppBarBlack(
    this.title,
    this.actions, {
    super.key,
    this.showLeading = true,
    this.toolbarHeight = 40,
    this.bottom,
    this.onBackTap,
  }) : preferredSize = const Size.fromHeight(40.0);

  @override
  Widget build(BuildContext context) {
    return InnoAppBarBase(
      Colors.black,
      Colors.white,
      title,
      actions,
      showLeading: showLeading,
      toolbarHeight: toolbarHeight,
      bottom: bottom,
      onBackTap: onBackTap,
    );
  }
}
