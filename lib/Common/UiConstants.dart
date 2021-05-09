import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFF121212);
const Color kWhite25 = Color(0x40FFFFFF);
const Color kWhite80 = Color(0xCCFFFFFF);
const Color kHighlightColour = Color(0xFFc8a415);
const Color kRedColor = Color(0xFF7f0000);
const Color kBlueColor = Color(0xFF002171);
const Color kGreenColor = Color(0xFF2E7D32);
const Color kButtonCardColor = Color(0xFF222222);
const String kDateFormat = 'yyyy-MM-dd';
const Color kAlertColor = Color(0xFF1F1B24);
const Color kActiveTextColor = Color(0xFFffee58);
const Color kActiveCardColor = Color(0x40ffee58);
const Color kCancelledCardColor = Color(0x40ff5252);

const kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(fontSize: 18),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kHighlightColour, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFd84315), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const Map<int, Color> kCardOverlay = {
  1: Color(0x0DFFFFFF),
  2: Color(0x12FFFFFF),
  3: Color(0x14FFFFFF),
  4: Color(0x17FFFFFF),
  6: Color(0x1CFFFFFF),
  8: Color(0x1FFFFFFF),
  12: Color(0x24FFFFFF),
  16: Color(0x26FFFFFF),
  24: Color(0x29FFFFFF),
};
