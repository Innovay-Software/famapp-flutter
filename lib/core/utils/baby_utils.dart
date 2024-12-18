import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BabyUtils {
  static String getBabyAgeText(BuildContext ctx, DateTime birthDate, DateTime targetDate) {
    var diff = targetDate.difference(birthDate);
    switch (diff.inDays) {
      case 7:
        return '1 week';
      case 14:
        return '2 weeks';
      case 21:
        return '3 weeks';
      case 28:
        return '4 weeks';
    }
    var year = targetDate.year - birthDate.year;
    var months = targetDate.month - birthDate.month;
    var days = targetDate.day - birthDate.day;

    if (days < 0) {
      if (targetDate.month == 1) {
        days += 31;
        months -= 1;
      } else {
        // var days = getDaysInMonth(targetDate.year, targetDate.month);
        days += _getDaysInMonth(targetDate.year, targetDate.month - 1);
        months -= 1;
      }
    }

    if (months < 0) {
      months += 12;
      year -= 1;
    }
    return '${year > 0 ? '$year Y ' : ''}$months M ${days > 0 ? '$days D' : ''}';
  }

  static List<String> getSpecialDateText(DateTime birthDate, DateTime targetDate) {
    if (targetDate.isBefore(birthDate)) {
      return ['Pregnancy', 'birthday-girl.png'];
    }
    if (targetDate.compareTo(birthDate) == 0) {
      return ['Birth', 'balloons1.png'];
    }
    var diff = targetDate.difference(birthDate);
    if (diff.inDays < 7) {
      return ['${diff.inDays} Days', 'birthday-cake3.png'];
    }
    switch (diff.inDays) {
      case 7:
        return ['1 week', 'birthday-cake3.png'];
      case 14:
        return ['2 weeks', 'birthday-cake3.png'];
      case 21:
        return ['3 weeks', 'birthday-cake3.png'];
      case 28:
        return ['4 weeks', 'birthday-cake3.png'];
    }

    if (diff.inDays == _getDaysInMonth(birthDate.year, birthDate.month)) {
      return ['1 months', 'birthday-cake1.png'];
    }

    if (targetDate.month == birthDate.month && targetDate.day == birthDate.day) {
      var year = targetDate.year - birthDate.year;
      return ['$year years old', 'birthday-cake2.png'];
    }

    if (targetDate.day == birthDate.day) {
      var year = targetDate.year - birthDate.year;
      var months = targetDate.month - birthDate.month;
      if (months < 0) {
        months += 12;
        year -= 1;
      }
      return ['${year > 0 ? '$year Y' : ''}$months M', 'balloons2.png'];
    }

    return [];
  }

  // Get days in month. Month is indexed at 1
  static int _getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 100 == 0 && year % 400 == 0) || (year % 100 != 0 && year % 4 == 0);
      return isLeapYear ? 29 : 28;
    }

    return <int>[1, 3, 5, 7, 8, 10, 12].contains(month) ? 31 : 30;
  }
}
