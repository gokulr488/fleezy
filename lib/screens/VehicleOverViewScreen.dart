import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';

class VehicleOverviewScreen extends StatefulWidget {
  static const String id = 'vehicleOverviewScreen';
  @override
  _VehicleOverviewScreenState createState() => _VehicleOverviewScreenState();
}

const TextStyle kButtonTextStyle = TextStyle(fontSize: 28);

class _VehicleOverviewScreenState extends State<VehicleOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    VehicleCard vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          vehicle,
          Button(buttonText: 'Start New Trip'),
          Button(buttonText: 'Add Fuel'),
          Button(buttonText: 'Add Expense'),
          Button(buttonText: 'Trip History'),
          Button(buttonText: 'Manage Vehicle')
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String buttonText;
  final Function onTap;

  const Button({this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      color: kHighlightColour,
      elevation: 4,
      onTap: onTap,
      cardChild: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            buttonText,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
