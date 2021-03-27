import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  Alerts({
    this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(this.title),
        actions: this.actions,
        backgroundColor: kInActiveColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))));
  }
}

void showSendingDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Alerts(
        title: 'Submitting...',
        actions: [LoadingDots(size: 50)],
      );
    },
  );
}

void showSubmitResponse(BuildContext context, String resp) {
  showDialog(
    context: context,
    builder: (context) {
      return Alerts(
        title: resp,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
        ],
      );
    },
  );
}
