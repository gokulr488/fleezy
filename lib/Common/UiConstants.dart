import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFF121212);
//const Color kHighlightColour = Color(0xFFcc3200);
const Color kHighlightColour = Color(0xFFc8a415);
const Color kLightYellow = Color(0xFFf9a825);
//const Color kDarkYellow = Color(0xFFc17900);
const Color kRedColor = Color(0xFF7f0000);
const Color kBlueColor = Color(0xFF002171);
const Color kGreenColor = Color(0xFF2E7D32);
const Color kButtonCardColor = Color(0xFF222222);
const String kDateFormat = 'yyyy-MM-dd';
const Color kInActiveColor = Color(0xFF1F1B24);
const Color kActiveColor = Color(0xFF003300);

const kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(fontSize: 18),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFc17900), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFd84315), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
