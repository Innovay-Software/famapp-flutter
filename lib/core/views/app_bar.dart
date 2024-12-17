import 'package:flutter/material.dart';

import '../config.dart';
import 'app_bar_base.dart';

class InnoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool usePrimaryColor;
  final String title;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final Widget? leadingWidget;
  final bool showLeading;
  final double toolbarHeight;
  final Function()? onBackTap;

  @override
  final Size preferredSize;

  const InnoAppBar(
    this.usePrimaryColor,
    this.title,
    this.actions, {
    super.key,
    this.showLeading = true,
    this.toolbarHeight = 40,
    this.bottom,
    this.onBackTap,
    this.leadingWidget,
  }) : preferredSize = const Size.fromHeight(40.0);

  @override
  Widget build(BuildContext context) {
    return InnoAppBarBase(
      usePrimaryColor ? InnoConfig.colors.primaryColor : InnoConfig.colors.backgroundColor,
      usePrimaryColor ? InnoConfig.colors.primaryColorTextColor : InnoConfig.colors.textColor,
      title,
      actions,
      leadingWidget: leadingWidget,
      showLeading: showLeading,
      toolbarHeight: toolbarHeight,
      bottom: bottom,
      onBackTap: onBackTap,
    );
  }
}
