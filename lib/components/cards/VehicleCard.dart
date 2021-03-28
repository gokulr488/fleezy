import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/VehicleOverviewScreen.dart';
import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  static const TextStyle _kRegistrationNumberTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  static const TextStyle _kDriverTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  static const TextStyle _kMessagesTextStyle =
      TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold);
  final Color color;
  final String registrationNumber;
  final String currentDriver;
  final String message;

  const VehicleCard(
      {this.color, this.currentDriver, this.message, this.registrationNumber});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 150,
              height: 120,
              child: Image.asset(
                'assets/images/startPageImage.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(registrationNumber ?? '',
                  style: _kRegistrationNumberTextStyle),
              Text('Driver: ' + currentDriver, style: _kDriverTextStyle),
              message != null
                  ? Text(
                      message,
                      style: _kMessagesTextStyle,
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
      elevation: 4,
      color: color,
      onTap: () {
        Navigator.pushNamed(context, VehicleOverviewScreen.id, arguments: this);
      },
    );
  }
}
