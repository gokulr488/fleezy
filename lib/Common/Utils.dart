import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static Timestamp getTimeStamp(DateTime date) {
    return Timestamp.fromDate(date);
  }

  static String getFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat(kDateFormat);
    return formatter.format(date);
  }

  static getFormattedTimeStamp(Timestamp timestamp) {
    return getFormattedDate(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
  }

  static Future<DateTime> pickDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      return picked;
    }
    return selectedDate;
  }
}
