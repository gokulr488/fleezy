// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CallContext {
  String _message;
  bool isError = false;
  dynamic data;
  String _errorMessage;
  DocumentSnapshot pageInfo;

  String get message => _message;
  String get errorMessage => _errorMessage;

  void setError(String msg) {
    debugPrint(msg);
    _message = msg;
    _errorMessage = msg;
    isError = true;
  }

  void setSuccess(String msg) {
    debugPrint(msg);
    _message = msg;
    isError = false;
  }

  // void showSilentAlerts(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 2,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  void showConfirmationAlerts(BuildContext context) {}
}
