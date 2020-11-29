import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFF1a1a1a);
const Color kHighlightColour = Color(0xFFE65100);
const String kDateFormat = 'yyyy-MM-dd';
const Color kInActiveVehicleColor = Color(0xFF424242);
const Color kActiveVehicleColor = Color(0xFF2E7D32);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE65100), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE65100), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
