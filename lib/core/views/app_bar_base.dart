import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:famapp/core/utils/calculation_utils.dart';

import '../widgets/expanded_text.dart';

class InnoAppBarBase extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String title;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final Widget? leadingWidget;
  final bool showLeading;
  final double toolbarHeight;
  final Function()? onBackTap;

  @override
  final Size preferredSize;

  const InnoAppBarBase(
    this.backgroundColor,
    this.foregroundColor,
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
    var isDarkBackground = CalculationUtils.isColorDark(backgroundColor);
    return AppBar(
      scrolledUnderElevation: 0.0,
      toolbarHeight: toolbarHeight,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: backgroundColor,
        statusBarIconBrightness: isDarkBackground ? Brightness.light : Brightness.dark, // For Android
        statusBarBrightness: isDarkBackground ? Brightness.dark : Brightness.light, // For iOS
      ),
      bottom: bottom,
      leadingWidth: 56,
      leading: !showLeading
          ? const SizedBox.shrink()
          : (GestureDetector(
              onTap: onBackTap ??
                  () {
                    Navigator.pop(context, false);
                  },
              child: Container(
                color: Colors.white.withOpacity(.001),
                child: leadingWidget ?? Icon(CupertinoIcons.back, size: 22, color: foregroundColor),
              ),
            )),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      title: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 56.0 * actions.length),
            child: Row(children: [
              ExpandedText(title, fontSize: 16, textAlign: TextAlign.start, color: foregroundColor),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: actions,
          ),
        ],
      ),
    );
  }
}
