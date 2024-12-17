import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculationUtils {
  static bool isColorDark(Color color) {
    return 0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue < 255.0 * 0.6;
  }

  static String randomString(int length) {
    final random = Random();
    const availableChars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length, (index) => availableChars[random.nextInt(availableChars.length)]).join();

    return randomString;
  }

  static String createdAtToTimeAgo(String dateStr, BuildContext context) {
    var now = DateTime.now();
    var dateTime = DateTime.parse(dateStr);
    var days = now.difference(dateTime).inDays;
    var hours = now.difference(dateTime).inHours;
    if (hours < 24) return AppLocalizations.of(context)!.hoursAgo(hours);
    return AppLocalizations.of(context)!.daysAgo(days);
  }
}
