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
    var formatter = DateFormat(format);
    return formatter.format(date);
  }

  static String getFormattedTimeStamp(Timestamp timestamp, String format) {
    if (timestamp == null) return null;
    return getFormattedDate(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch),
        format);
  }

  static Future<DateTime> pickDate(BuildContext context) async {
    var selectedDate = DateTime.now();
    final picked = await showDatePicker(
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
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime + Constants.MILLISECONDS_PER_MONTH >=
        timestamp.millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }

  static Timestamp getStartOfDay(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    return Timestamp.fromDate(start);
  }

  static Timestamp getEndOfDay(DateTime date) {
    final end = DateTime(date.year, date.month, date.day + 1);
    return Timestamp.fromDate(end);
  }

  static DateTime getStartOfMonth(DateTime dayOfMonth) {
    final start = DateTime(dayOfMonth.year, dayOfMonth.month);
    return start;
  }

  static DateTime getEndOfMonth(DateTime dayOfMonth) {
    final millis =
        DateTime(dayOfMonth.year, dayOfMonth.month + 1).millisecondsSinceEpoch -
            1;
    final end = DateTime.fromMillisecondsSinceEpoch(millis);
    return end;
  }

  static final curFormat = NumberFormat('##,##,##,##0.00');

  static String formatDouble(double value) {
    if (value == null) return '0.00';
    return curFormat.format(value);
  }

  static String formatInt(int value) {
    if (value == null) return '0';
    return value.toStringAsFixed(0);
  }
}
