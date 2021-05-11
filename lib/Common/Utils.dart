import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static Timestamp getTimeStamp(DateTime date) {
    return Timestamp.fromDate(date);
  }

  static String getFormattedTime(DateTime date) {
    DateFormat formatter = DateFormat(kTimeFormat);
    return formatter.format(date);
  }

  static String getFormattedTimeTimeStamp(Timestamp timestamp) {
    return getFormattedTime(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
  }

  static String getFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat(kDateFormat);
    return formatter.format(date);
  }

  static String getFormattedTimeStamp(Timestamp timestamp) {
    return getFormattedDate(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
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
}
