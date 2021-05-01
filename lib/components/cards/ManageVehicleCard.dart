import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehicleScreen.dart';
import 'package:flutter/material.dart';

class ManageVehicleCard extends StatelessWidget {
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
  final ModelVehicle vehicle;

  const ManageVehicleCard(
      {this.color,
      this.currentDriver,
      this.message,
      this.registrationNumber,
      this.vehicle});

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
              Text(registrationNumber, style: _kRegistrationNumberTextStyle),
              Text('Driver: ' + currentDriver, style: _kDriverTextStyle),
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(message ?? '', style: _kMessagesTextStyle)))
            ],
          )
        ],
      ),
      elevation: 4,
      color: color,
      onTap: () {
        Navigator.pushNamed(context, ManageVehicleScreen.id, arguments: this);
      },
    );
  }
}
