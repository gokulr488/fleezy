import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFFefefef);
const Color kTextColor = Color(0xFF000000);
const Color kPrimaryColor = Color(0xFFffa000);
const Color kHighlightColour = Color(0xFFf9a825);
const Color kRedColor = Color(0xFFd32f2f);
const Color kBlueColor = Color(0xFF0d47a1);
const Color kButtonCardColor = Color(0xFF222222);
const String kDateFormat = 'dd-MM-yy';
const String kTimeFormat = 'hh:mm dd-MM-yy';
const Color kAlertColor = Color(0xFFfbe9e7);
const Color kActiveTextColor = Color(0xFF000000);
const Color kActiveCardColor = Color(0xFFdce775);

const Color kCancelledCardColor = Color(0xffffccbc);

const List<Shadow> shadow = <Shadow>[
  Shadow(offset: Offset(2, 2), blurRadius: 7)
];

const Duration kAnimDuraction = Duration(milliseconds: 350);
const Cubic kAnimCurve = Curves.easeOut;

const InputDecoration kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(fontSize: 18),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kHighlightColour),
    borderRadius: BorderRadius.all(Radius.circular(25)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFd84315), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(25)),
  ),
);

const InputDecoration kDropDownDecoration = InputDecoration(
    labelStyle: TextStyle(fontSize: 18, color: kHighlightColour),
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0x00000000)),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ));

const Map<int, Color> kCardOverlay = <int, Color>{
  1: Color(0xFFffffe5),
  2: Color(0xFFffffe5),
  3: Color(0xFFffffe5),
  4: Color(0xFFffffe5),
  6: Color(0xFFffffe5),
  8: Color(0xFFffffe5),
  12: Color(0xFFffffe5),
  16: Color(0xFFffffe5),
  24: Color(0xFFffffe5),
};

const TextStyle kHeaderTextStyle = TextStyle(fontSize: 30, color: kTextColor);

const TextStyle kReportCardHeaderTS = TextStyle(
    fontSize: 20, color: kHighlightColour, fontWeight: FontWeight.bold);
