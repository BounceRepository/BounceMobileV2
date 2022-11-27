import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static Future<String?> pickDate(BuildContext context) async {
    final initialDate = DateTime(DateTime.now().year - 18);
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 150),
      lastDate: initialDate,
    );

    if (date == null) return null;

    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  static DateTime getDate(String str) {
    return DateFormat('yyyy-MM-dd').parse(str);
  }

  static String getDayOfWeek(DateTime date) => DateFormat('EEE').format(date);

  static String getDayOfMonth(DateTime date) => DateFormat('dd').format(date);

  static String getMonth(DateTime date) => DateFormat('MMMM, yyyy').format(date);

  static String getDateStr(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  static String getDateFullStr(DateTime date) => DateFormat.yMMMMd('en_US').format(date);

  static String convertDateTimeToAMPM(DateTime date) =>
      DateFormat('hh:mm a').format(date);

  static TimeOfDay parseTimeOfDay(String t) {
    final dateTime = DateFormat("HH:mm a").parse(t);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  static String convertTimeOfDayToAMPM(TimeOfDay time) {
    final tempDate =
        DateFormat("hh:mm").parse(time.hour.toString() + ":" + time.minute.toString());
    final dateFormat = DateFormat("h:mm a");
    return (dateFormat.format(tempDate));
  }
}
