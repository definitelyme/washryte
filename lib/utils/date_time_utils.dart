library date_time_utils.dart;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin DateTimeUtils {
  static String getDayOfMonthSuffix(DateTime date, {bool prefixDay = true}) {
    final dayNum = date.day;

    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return '${dayNum}th';
    }

    switch (dayNum % 10) {
      case 1:
        return '${dayNum}st';
      case 2:
        return '${dayNum}nd';
      case 3:
        return '${dayNum}rd';
      default:
        return '${dayNum}th';
    }
  }

  static String dayOfMonth(DateTime date, [String Function(String)? pattern]) {
    // var suffix = 'th';
    // var digit = date.day % 10;
    // if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
    //   suffix = ['st', 'nd', 'rd'][digit - 1];
    // }
    final suffix = getDayOfMonthSuffix(date, prefixDay: false);
    final _pattern = pattern?.call(suffix) ?? '$suffix';
    print('suffix: $_pattern');
    return DateFormat("EE, MMM '$suffix', yyyy").format(date);
    // return DateFormat('$_pattern').format(date);
  }

  static String to12HrsFormat(String time, {bool local = true}) {
    final tempDate = DateFormat('hh:mm').parse(time);
    final dateFormat = DateFormat('h:mm:ss a'); // you can change the format here
    final utcDate = dateFormat.format(tempDate); // pass the UTC time here
    final String localDate;
    if (local)
      localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    else
      localDate = dateFormat.parse(utcDate, true).toUtc().toString();
    return dateFormat.format(DateTime.parse(localDate));
  }

  static DateTime? tryParseTime(String time, {Duration offset = Duration.zero}) {
    final formatted = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final date = DateTime.tryParse('${formatted}T${time}Z')?.toUtc();

    if (date != null) {
      final nowTimeofDay = TimeOfDay.now();
      final timeOfDay = TimeOfDay.fromDateTime(date);

      if (nowTimeofDay.hour > timeOfDay.hour) {
        return date.add(offset);
      } else {
        return date;
      }
    }

    return date;
  }
}
