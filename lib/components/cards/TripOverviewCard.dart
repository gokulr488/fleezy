import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

const TextStyle _labelTS = TextStyle(fontSize: 16, color: kHighlightColour);

class TripOverviewCard extends StatelessWidget {
  final ModelTrip tripDo;
  final Function onTap;

  const TripOverviewCard({@required this.tripDo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(tripDo.startingFrom, style: _labelTS),
              Icon(Icons.keyboard_arrow_right_outlined, size: 30),
              Text(tripDo.destination, style: _labelTS)
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Driver: ' + tripDo.driverName, style: _labelTS),
            Text('Party: ' + tripDo.customerName, style: _labelTS),
            Text(Utils.getFormattedTimeStamp(tripDo.startDate), style: _labelTS)
          ])
        ],
      ),
    );
  }
}
