import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryDetailsScreen.dart';
import 'package:flutter/material.dart';

const TextStyle _labelTS = TextStyle(
    fontSize: 16, color: kHighlightColour, fontWeight: FontWeight.bold);

class TripOverviewCard extends StatelessWidget {
  const TripOverviewCard({@required this.tripDo});
  final ModelTrip tripDo;

  @override
  Widget build(BuildContext context) {
    Color color;
    if (tripDo.status == Constants.STARTED) {
      color = kActiveCardColor;
    } else if (tripDo.status == Constants.CANCELLED) {
      color = kCancelledCardColor;
    }
    return BaseCard(
      onTap: () => onTap(context),
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(tripDo.startingFrom, style: _labelTS),
              const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
              Text(tripDo.destination, style: _labelTS)
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Driver: ${tripDo.driverName}', style: _labelTS),
                Text('Party: ${tripDo.customerName}', style: _labelTS),
              ]),
          Text(Utils.getFormattedTimeStamp(tripDo.startDate, kDateFormat),
              style: _labelTS)
        ],
      ),
      color: color,
    );
  }

  void onTap(BuildContext context) {
    Navigator.pushNamed(context, TripHistoryDetailsScreen.id,
        arguments: tripDo);
  }
}
