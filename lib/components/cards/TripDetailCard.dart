import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

class TripDetailCard extends StatelessWidget {
  static const TextStyle _kRegistrationNumberTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: kLightYellow);
  static const TextStyle _kDriverTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: kLightYellow);
  static const TextStyle _ktimerTextStyle =
      TextStyle(fontSize: 45, color: kLightYellow, fontWeight: FontWeight.bold);
  static const TextStyle _kLocationTextStyle =
      TextStyle(fontSize: 30, color: kLightYellow);
  static const TextStyle _kDetailsTextStyle =
      TextStyle(fontSize: 20, color: kLightYellow, fontWeight: FontWeight.bold);
  final ModelTrip tripDo;

  const TripDetailCard({@required this.tripDo});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('01:20', style: _ktimerTextStyle),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tripDo.vehicleRegNo ?? '',
                        style: _kRegistrationNumberTextStyle),
                    Text('Driver: ' + tripDo.driverName,
                        style: _kDriverTextStyle),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tripDo.startingFrom ?? '', style: _kLocationTextStyle),
                Icon(Icons.arrow_right_alt, size: 40),
                Text(tripDo.destination ?? '', style: _kLocationTextStyle)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Distance: ${tripDo.distance ?? 0}',
                    style: _kDetailsTextStyle),
                Text('Customer: ${tripDo.customerName ?? ''}',
                    style: _kDetailsTextStyle)
              ],
            ),
          ],
        ),
      ),
      elevation: 4,
      color: Colors.grey[900],
      onTap: () {},
    );
  }
}
