import 'package:flutter/material.dart';

class CallContext {
  String _message;
  bool isError = false;
  dynamic data;
  String _errorMessage;

  String get message => _message;
  String get errorMessage => _errorMessage;

  setError(String msg) {
    print(msg);
    this._message = msg;
    this._errorMessage = msg;
    isError = true;
  }

  setSuccess(String msg) {
    print(msg);
    this._message = msg;
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
