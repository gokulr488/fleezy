import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final Function onChanged;
  final String defaultValue;
  final List<String> values;
  final String hintText;

  const DropDown(
      {this.onChanged, this.defaultValue, this.values, this.hintText});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: kHighlightColour,
      ),
      iconSize: 25,
      decoration: kTextFieldDecoration.copyWith(labelText: hintText ?? ''),
      value: defaultValue,
      onChanged: onChanged,
      items: values
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
    );
  }
}
