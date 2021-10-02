import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {
  const Alerts({
    this.title,
    this.actions,
  });
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        actions: actions,
        backgroundColor: kAlertColor,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))));
  }
}

void showSendingDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Alerts(
        title: 'Submitting...',
        actions: <Widget>[LoadingDots(size: 50)],
      );
    },
  );
}

void showSubmitResponse(BuildContext context, String resp) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alerts(title: resp, actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'))
      ]);
    },
  );
}

void showErrorAlert(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alerts(
        title: 'ERROR',
        actions: <Widget>[
          Text(errorMessage, style: const TextStyle(fontSize: 18)),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'))
        ],
      );
    },
  );
}

void showWarningAlert(
    BuildContext context, String errorMessage, Function onConfirmed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alerts(
        title: 'Warning',
        actions: <Widget>[
          Text(errorMessage, style: const TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No')),
              TextButton(onPressed: onConfirmed, child: const Text('Yes'))
            ],
          ),
        ],
      );
    },
  );
}
