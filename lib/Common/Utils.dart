import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static Timestamp getTimeStamp(DateTime date) {
    return Timestamp.fromDate(date);
  }

  static String getFormattedDate(DateTime date, String format) {
    if (date == null) return null;
    DateFormat formatter = DateFormat(format);
    return formatter.format(date);
  }

  static String getFormattedTimeStamp(Timestamp timestamp, String format) {
    if (timestamp == null) return null;
    return getFormattedDate(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch),
        format);
  }

  static Future<DateTime> pickDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        //initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      return picked;
    }
    return selectedDate;
  }

  static bool isWarningPeriod(Timestamp timestamp) {
    if (timestamp == null) {
      return false;
    }
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime + Constants.MILLISECONDS_PER_MONTH >=
        timestamp.millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }

  static Timestamp getStartOfDay(DateTime date) {
    DateTime start = DateTime(date.year, date.month, date.day);
    return Timestamp.fromDate(start);
  }

  static Timestamp getEndOfDay(DateTime date) {
    DateTime end = DateTime(date.year, date.month, date.day + 1);
    return Timestamp.fromDate(end);
  }

  static Timestamp getStartOfMonth(DateTime dayOfMonth) {
    DateTime start = DateTime(dayOfMonth.year, dayOfMonth.month);
    return Timestamp.fromDate(start);
  }

  static Timestamp getEndOfMonth(DateTime dayOfMonth) {
    int millis =
        DateTime(dayOfMonth.year, dayOfMonth.month + 1).millisecondsSinceEpoch -
            1;
    DateTime end = DateTime.fromMillisecondsSinceEpoch(millis);
    return Timestamp.fromDate(end);
  }
}
