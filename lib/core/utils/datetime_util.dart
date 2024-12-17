import 'package:intl/intl.dart';

class DatetimeUtils {
  static String formattedDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String formattedHourMinute(DateTime date) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }

  static String formattedHourMinuteSecond(DateTime date) {
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(date);
  }

  static String formattedHourMinuteMicroSecond(DateTime date) {
    final DateFormat formatter = DateFormat('HH:mm:ss.mmmuuu');
    return formatter.format(date);
  }

  static String formattedDateTime(DateTime date, {String dateTimeSeparator = ' '}) {
    final dateString = formattedDate(date);
    final timeString = formattedHourMinuteSecond(date);
    return '$dateString$dateTimeSeparator$timeString';
  }

  static String formattedDateTimeMicroSecond(DateTime date, {String dateTimeSeparator = ' '}) {
    final dateString = formattedDate(date);
    final timeString = formattedHourMinuteMicroSecond(date);
    return '$dateString$dateTimeSeparator$timeString';
  }

  static String formattedDateMonth(DateTime date, {String dateTimeSeparator = ' '}) {
    final DateFormat formatter = DateFormat('yyyy${dateTimeSeparator}mm');
    return formatter.format(date);
  }
}
