import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/PaymentDetailsCard.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryDetailController.dart';
import 'package:flutter/material.dart';

class TripHistoryDetailsScreen extends StatelessWidget {
  static const String id = 'TripHistoryDetailsScreen';

  @override
  Widget build(BuildContext context) {
    ModelTrip tripDo = ModalRoute.of(context).settings.arguments as ModelTrip;
    return BaseScreen(
      headerText: 'Trip Summary',
      child: Column(
        children: [
          TripDetailCard(
            tripDo: tripDo,
            distance: tripDo.distance?.toDouble(),
          ),
          if (tripDo.status != Constants.STARTED) HorLine(),
          if (tripDo.status != Constants.STARTED)
            Text('Details', style: TextStyle(fontSize: 20, color: kWhite80)),
          if (tripDo.status != Constants.STARTED)
            PaymentDetailsCard(trip: tripDo),
          HorLine(),
          Text('Expenses', style: TextStyle(fontSize: 20, color: kWhite80)),
          FutureBuilder(
            future: getExpenses(tripDo, context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ScrollableList(
                      childrenHeight: 150, items: buildCards(snapshot.data)),
                );
              } else {
                return LoadingDots(size: 100);
              }
            },
          ),
        ],
      ),
    );
  }
}
