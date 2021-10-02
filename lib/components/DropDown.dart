import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  const DropDown(
      {this.onChanged, this.defaultValue, this.values, this.hintText});
  final Function onChanged;
  final String defaultValue;
  final List<String> values;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: kHighlightColour,
      ),
      iconSize: 25,
      decoration: kTextFieldDecoration.copyWith(labelText: hintText ?? ''),
      value: defaultValue,
      onChanged: onChanged,
      items: values
          .map((String value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList(),
    );
  }
}
