import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/PaymentDetailsCard.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryDetailController.dart';
import 'package:flutter/material.dart';

const TextStyle _headingTS = TextStyle(
    fontSize: 20, color: kHighlightColour, fontWeight: FontWeight.bold);

class TripHistoryDetailsScreen extends StatelessWidget {
  static const String id = 'TripHistoryDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final ModelTrip tripDo =
        ModalRoute.of(context).settings.arguments as ModelTrip;
    return BaseScreen(
      headerText: 'Trip Summary',
      child: Column(
        children: [
          TripDetailCard(
            tripDo: tripDo,
            distance: tripDo.distance?.toDouble(),
          ),
          if (tripDo.status != Constants.STARTED) const HorLine(),
          if (tripDo.status != Constants.STARTED)
            const Text('Details', style: _headingTS),
          if (tripDo.status != Constants.STARTED)
            PaymentDetailsCard(trip: tripDo),
          const HorLine(),
          const Text('Expenses', style: _headingTS),
          FutureBuilder<List<ModelExpense>>(
            future: getExpenses(tripDo, context),
            builder: (BuildContext context,
                AsyncSnapshot<List<ModelExpense>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ScrollableList(
                      childrenHeight: 150, items: buildCards(snapshot.data)),
                );
              } else {
                return const LoadingDots(size: 100);
              }
            },
          ),
        ],
      ),
    );
  }
}
