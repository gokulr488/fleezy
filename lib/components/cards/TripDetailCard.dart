import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

class TripDetailCard extends StatelessWidget {
  static const TextStyle _kRegistrationNumberTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: kHighlightColour);
  static const TextStyle _kDriverTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17, color: kHighlightColour);
  static const TextStyle _ktimerTextStyle = TextStyle(
      fontSize: 45, color: kHighlightColour, fontWeight: FontWeight.bold);
  static const TextStyle _kLocationTextStyle =
      TextStyle(fontSize: 28, color: kHighlightColour);
  static const TextStyle _kDetailsTextStyle = TextStyle(
      fontSize: 20, color: kHighlightColour, fontWeight: FontWeight.bold);
  final double distance;
  final ModelTrip tripDo;
  final Function onTap;

  const TripDetailCard({@required this.tripDo, this.distance, this.onTap});

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
                Text(_getTimeSpent(), style: _ktimerTextStyle),
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
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(tripDo.startingFrom ?? '',
                        style: _kLocationTextStyle),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                      tripDo.isRoundTrip
                          ? Icons.compare_arrows
                          : Icons.arrow_right_alt,
                      size: 35),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(tripDo.destination ?? '',
                        style: _kLocationTextStyle),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kms: ${distance?.toStringAsFixed(2) ?? 0}',
                      style: _kDetailsTextStyle),
                  Text('Party: ${tripDo.customerName ?? ''}',
                      style: _kDetailsTextStyle)
                ],
              ),
            ),
          ],
        ),
      ),
      elevation: 4,
      color: kCardOverlay[4],
      onTap: onTap,
    );
  }

  String _getTimeSpent() {
    if (tripDo.status == Constants.CANCELLED) return '00:00';
    int millisSpent;
    if (tripDo.endDate != null) {
      millisSpent = tripDo.endDate.millisecondsSinceEpoch -
          tripDo.startDate.millisecondsSinceEpoch;
    } else {
      millisSpent = Timestamp.now().millisecondsSinceEpoch -
          tripDo.startDate.millisecondsSinceEpoch;
    }

    int minutes = (millisSpent / 60000).truncate();
    int hour = 0;
    if (minutes > 59) {
      hour = (minutes / 60).truncate();
      minutes = minutes - (hour * 60);
    }
    String hr = '';
    String min = '';
    hour < 10 ? hr = '0$hour' : hr = '$hour';
    minutes < 10 ? min = '0$minutes' : min = '$minutes';
    int seconds = (millisSpent / 1000).truncate();
    if (seconds % 2 != 0) {
      return '$hr:$min';
    } else {
      return '$hr $min';
    }
  }
}
