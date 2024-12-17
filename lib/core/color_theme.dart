import 'package:flutter/material.dart';

class InnoColorTheme {
  Color color0 = const Color(0xFF000000);
  Color color1 = const Color(0xFF111111);
  Color color2 = const Color(0xFF222222);
  Color color3 = const Color(0xFF333333);
  Color color4 = const Color(0xFF444444);
  Color color5 = const Color(0xFF555555);
  Color color6 = const Color(0xFF666666);
  Color color7 = const Color(0xFF777777);
  Color color8 = const Color(0xFF888888);
  Color color9 = const Color(0xFF999999);
  Color colorA = const Color(0xFFAAAAAA);
  Color colorB = const Color(0xFFBBBBBB);
  Color colorC = const Color(0xFFCCCCCC);
  Color colorD = const Color(0xFFDDDDDD);
  Color colorE = const Color(0xFFEEEEEE);
  Color colorF = const Color(0xFFFFFFFF);

  Color primaryColor = const Color(0xFF3F51B5);
  Color primaryColorLighter = const Color(0xFFA7B4FA);
  // Color primaryColorLighter2 = const Color(0xFF8A2BE2);
  // Color primaryColorLighter3 = const Color(0xFFA862EA);
  Color primaryColorDarker = const Color(0xFF0E25A1);
  Color primaryColorTextColor = const Color(0xFFFFFFFF);

  Color headerPrimaryBackgroundColor = const Color(0xFF410f70);
  Color headerPrimaryTextColor = const Color(0xFFFFFFFF);
  Color headerSecondaryBackgroundColor = const Color(0xFFFFFFFF);
  Color headerSecondaryTextColor = const Color(0xFF666666);

  final Color notificationColor = const Color(0xFFD8001B);
  final Color notificationTextColor = const Color(0xFFFFFFFF);
  final Color moneyColor = const Color(0xFFFF4241);
  final Color successColor = const Color(0xFF0CCE3A);
  final Color successColorTextColor = const Color(0xFFFFFFFF);
  final Color deleteColor = const Color(0xFFFF5D6C);
  final Color deleteColorTextColor = const Color(0xFFFFFFFF);
  final Color greyColor = const Color(0xFFF2F2F2);
  final Color greyColorTextColor = const Color(0xFF333333);
  final Color logoutColor = const Color(0xFFC72827);
  final Color logoutTextColor = const Color(0xFFFFFFFF);
  final Color shareColor = const Color(0xFFFC8F57);
  final Color shareColorTextColor = const Color(0xFFFFFFFF);
  final Color voiceCallOnColor = const Color(0xFFF75855);
  final Color voiceCallOffColor = const Color(0xFF1A9FFC);
  final Color disabledColor = const Color(0xFFF2F2F2);
  final Color disabledTextColor = const Color(0xFF999999);

  Color messageBadgeBackgroundColor = const Color(0xFFFF4241);
  Color messageBadgeTextColor = const Color(0xFFFFFFFF);
  Color messageToastBackgroundColor = const Color(0xAA000000);
  Color messageToastTextColor = const Color(0xFFFFFFFF);
  Color imagePlaceHolderColor = const Color(0xFFF2F2F2);
  Color imageProcessBarColor = const Color(0xA0000000);
  Color loadingGreyTransparentBackgroundColor = const Color(0x80000000);
  Color backgroundColor = const Color(0xFFFFFFFF);
  Color backgroundColorTinted = const Color(0xFFF7F6FB);
  Color backgroundColorTinted2 = const Color(0xFFEFEFEF);
  Color backgroundColorTinted3 = const Color(0xFFF8F8F8);
  Color backgroundColorTinted4 = const Color(0xFFEDEDED);
  Color backgroundColorTinted5 = const Color(0xFFE6E6E6);
  Color textInputBorderColor = const Color(0xFFE6E6E6);
  Color dividerLineColor = const Color(0xFFF1F1F1);
  Color dividerLineSectionColor = const Color(0xFFE6E6E6);
  Color createOrderTipBackgroundColor = const Color(0xFFFEFCED);
  Color createOrderTipTextColor = const Color(0xFFFC8F57);
  Color textColorDark3 = const Color(0xFF000000);
  Color textColorDark2 = const Color(0xFF111111);
  Color textColorDark1 = const Color(0xFF222222);
  Color textColor = const Color(0xFF333333);
  Color textColorLight1 = const Color(0xFF333333);
  Color textColorLight2 = const Color(0xFF444444);
  Color textColorLight3 = const Color(0xFF555555);
  Color textColorLight4 = const Color(0xFF666666);
  Color textColorLight5 = const Color(0xFF777777);
  Color textColorLight6 = const Color(0xFF888888);
  Color textColorLight7 = const Color(0xFF999999);
  Color textColorLight8 = const Color(0xFFAAAAAA);
  Color textColorLight9 = const Color(0xFFBBBBBB);
  Color textColorLight10 = const Color(0xFFCCCCCC);
  Color textColorLight11 = const Color(0xFFDDDDDD);
  Color textColorLight12 = const Color(0xFFEEEEEE);
  Color textColorInverted = const Color(0xFFFFFFFF);

  void syncThemeColor(BuildContext context) {
    // DebugManager.log("SYncThemeColor", repeatTime: 10);
    // var themeData = Theme.of(context);
    // primaryColor = themeData.primaryColor;
    // primaryColorLighter = themeData.primaryColorLight;
    // primaryColorDarker = themeData.primaryColorDark;
  }

  void setLightColorTheme() {
    color0 = const Color(0xFF000000);
    color1 = const Color(0xFF111111);
    color2 = const Color(0xFF222222);
    color3 = const Color(0xFF333333);
    color4 = const Color(0xFF444444);
    color5 = const Color(0xFF555555);
    color6 = const Color(0xFF666666);
    color7 = const Color(0xFF777777);
    color8 = const Color(0xFF888888);
    color9 = const Color(0xFF999999);
    colorA = const Color(0xFFAAAAAA);
    colorB = const Color(0xFFBBBBBB);
    colorC = const Color(0xFFCCCCCC);
    colorD = const Color(0xFFDDDDDD);
    colorE = const Color(0xFFEEEEEE);
    colorF = const Color(0xFFFFFFFF);

    primaryColor = const Color(0xFF3F51B5);
    primaryColorTextColor = const Color(0xFFFFFFFF);
    primaryColorLighter = const Color(0xFFA7B4FA);
    // primaryColorLighter2 = const Color(0xFFB5E1FF);

    messageBadgeBackgroundColor = const Color(0xFFFF4241);
    messageBadgeTextColor = const Color(0xFFFFFFFF);

    messageToastBackgroundColor = const Color(0xAA000000);
    messageToastTextColor = const Color(0xFFFFFFFF);

    imagePlaceHolderColor = const Color(0xFFF2F2F2);
    imageProcessBarColor = const Color(0xA0000000);

    loadingGreyTransparentBackgroundColor = const Color(0x80000000);

    backgroundColor = const Color(0xFFFFFFFF);
    backgroundColorTinted = const Color(0xFFF7F6FB);
    backgroundColorTinted2 = const Color(0xFFEFEFEF);
    backgroundColorTinted3 = const Color(0xFFEEEEEE);
    backgroundColorTinted5 = const Color(0xFFE6E6E6);

    textInputBorderColor = const Color(0xFFE6E6E6);
    dividerLineColor = const Color(0xFFF1F1F1);
    dividerLineSectionColor = const Color(0xFFE6E6E6);

    createOrderTipBackgroundColor = const Color(0xFFFEFCED);
    createOrderTipTextColor = const Color(0xFFFC8F57);

    textColorDark3 = const Color(0xFF000000);
    textColorDark2 = const Color(0xFF111111);
    textColorDark1 = const Color(0xFF222222);
    textColor = const Color(0xFF333333);
    textColorLight1 = const Color(0xFF333333);
    textColorLight2 = const Color(0xFF444444);
    textColorLight3 = const Color(0xFF555555);
    textColorLight4 = const Color(0xFF666666);
    textColorLight5 = const Color(0xFF777777);
    textColorLight6 = const Color(0xFF888888);
    textColorLight7 = const Color(0xFF999999);
    textColorLight8 = const Color(0xFFAAAAAA);
    textColorLight9 = const Color(0xFFBBBBBB);
    textColorLight10 = const Color(0xFFCCCCCC);
    textColorLight11 = const Color(0xFFDDDDDD);
    textColorLight12 = const Color(0xFFEEEEEE);

    textColorInverted = const Color(0xFFFFFFFF);
  }

  void setDarkColorTheme() {
    color0 = const Color(0xFFFFFFFF);
    color1 = const Color(0xFFEEEEEE);
    color2 = const Color(0xFFDDDDDD);
    color3 = const Color(0xFFCCCCCC);
    color4 = const Color(0xFFBBBBBB);
    color5 = const Color(0xFFAAAAAA);
    color6 = const Color(0xFF999999);
    color7 = const Color(0xFF888888);
    color8 = const Color(0xFF777777);
    color9 = const Color(0xFF666666);
    colorA = const Color(0xFF555555);
    colorB = const Color(0xFF444444);
    colorC = const Color(0xFF333333);
    colorD = const Color(0xFF222222);
    colorE = const Color(0xFF111111);
    colorF = const Color(0xFF000000);

    primaryColor = const Color(0xFF4C84D0);
    primaryColorTextColor = const Color(0xFFFFFFFF);
    primaryColorLighter = const Color(0xFFE3F2FC);
    // primaryColorLighter2 = const Color(0xFFB5E1FF);
    messageBadgeBackgroundColor = const Color(0xFFFF4241);
    messageBadgeTextColor = const Color(0xFFFFFFFF);

    messageToastBackgroundColor = const Color(0xAA000000);
    messageToastTextColor = const Color(0xFFFFFFFF);

    imagePlaceHolderColor = const Color(0xFFF2F2F2);
    imageProcessBarColor = const Color(0xA0000000);

    loadingGreyTransparentBackgroundColor = const Color(0x80000000);

    backgroundColor = const Color(0xFF222738);
    backgroundColorTinted = const Color(0xFF0A0D15);
    backgroundColorTinted2 = const Color(0xFF373F5A);
    backgroundColorTinted3 = const Color(0xFF2D344B);
    backgroundColorTinted4 = const Color(0xFF0A0D15);
    backgroundColorTinted5 = const Color(0xFF0A0D15);

    textInputBorderColor = const Color(0xFFE6E6E6);
    dividerLineColor = const Color(0xFF4C5266);
    dividerLineSectionColor = const Color(0xFF4C5266);

    createOrderTipBackgroundColor = const Color(0xFFFEFCED);
    createOrderTipTextColor = const Color(0xFFFC8F57);

    textColorDark3 = const Color(0xFFDDDDDD);
    textColorDark2 = const Color(0xFFCDCDCD);
    textColorDark1 = const Color(0xFFCDCDCD);
    textColor = const Color(0xFFCDCDCD);
    textColorLight1 = const Color(0xFFBBBBBB);
    textColorLight2 = const Color(0xFFAAAAAA);
    textColorLight3 = const Color(0xFF999999);
    textColorLight4 = const Color(0xFF888888);
    textColorLight5 = const Color(0xFF777777);
    textColorLight6 = const Color(0xFF666666);
    textColorLight7 = const Color(0xFFBBBBBB);
    textColorLight8 = const Color(0xFFCDCDCD);
    textColorLight9 = const Color(0xFFBBBBBB);
    textColorLight10 = const Color(0xFFCCCCCC);
    textColorLight11 = const Color(0xFFDDDDDD);
    textColorLight12 = const Color(0xFFEEEEEE);

    textColorInverted = const Color(0xFF333333);
  }
}
