import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFF000000);
const Color kHighlightColour = Color(0xFFcc3200);
const Color kRedColor = Color(0xFF7f0000);
const Color kBlueColor = Color(0xFF002171);
const String kDateFormat = 'yyyy-MM-dd';
const Color kInActiveVehicleColor = Color(0xFF212121);
const Color kActiveVehicleColor = Color(0xFF2E7D32);

const kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(fontSize: 18),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF005005), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFd84315), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
