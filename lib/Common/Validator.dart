import 'package:fleezy/Common/Alerts.dart';
import 'package:flutter/material.dart';

class Validator {
  bool odometerReading(int userInput, int lastReading, BuildContext context) {
    if (userInput == null || userInput == 0 || userInput < lastReading) {
      showErrorAlert(context, 'Incorrect Odometer Reading');
      throw new Exception('Incorrect Odometer Reading');
    }
    return true;
  }

  bool stringField(String value, String errorMessage, BuildContext context) {
    if (value == null || value.isEmpty) {
      showErrorAlert(context, errorMessage);
      throw new Exception(errorMessage);
    }
    return true;
  }
}
