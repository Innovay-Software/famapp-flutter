import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config.dart';
import '../utils/calculation_utils.dart';

class InnoAppStatusBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final bool usePrimaryColor;
  final Color? overrideBackgroundColor;

  @override
  final Size preferredSize;

  const InnoAppStatusBar(
    this.context,
    this.usePrimaryColor, {
    super.key,
    this.overrideBackgroundColor,
  }) : preferredSize = const Size.fromHeight(-10.0);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = usePrimaryColor ? InnoConfig.colors.primaryColor : InnoConfig.colors.backgroundColor;
    if (overrideBackgroundColor != null) {
      backgroundColor = overrideBackgroundColor!;
    }
    var isDarkBackground = CalculationUtils.isColorDark(backgroundColor);

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: backgroundColor,
        statusBarIconBrightness: isDarkBackground ? Brightness.light : Brightness.dark, // For Android
        statusBarBrightness: isDarkBackground ? Brightness.dark : Brightness.light, // For iOS
      ),
      toolbarHeight: 0,
      backgroundColor: backgroundColor,
      foregroundColor: isDarkBackground ? Colors.white : Colors.black,
      elevation: 0,
    );
  }
}
