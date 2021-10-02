import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({this.user});
  final ModelUser user;

  @override
  Widget build(BuildContext context) {
    final TextStyle _kDriverNameTextStyle = TextStyle(
        fontSize: 18,
        color: user.state == Constants.ACTIVE ? kActiveTextColor : kTextColor,
        fontWeight: FontWeight.bold);
    return BaseCard(
      cardChild: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(user.fullName ?? '', style: _kDriverNameTextStyle),
                      Text(user.phoneNumber ?? '', style: _kDriverNameTextStyle)
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RoundedButton(
                        onPressed: edit,
                        title: 'Edit',
                        width: 130,
                        colour: kCardOverlay[8],
                      ),
                      RoundedButton(
                          colour: kCardOverlay[8],
                          onPressed: () {
                            deactivate(context);
                          },
                          title: user.state == Constants.ACTIVE
                              ? 'De-Activate'
                              : 'Activate',
                          width: 130)
                    ])
              ])),
      color:
          user.state == Constants.ACTIVE ? kActiveCardColor : kCardOverlay[4],
    );
  }

  void edit() {}

  Future<void> deactivate(BuildContext context) async {
    user.state == Constants.INACTIVE
        ? user.state = Constants.ACTIVE
        : user.state = Constants.INACTIVE;
    final CallContext callContect = await Roles().updateRole(user);
    if (callContect.isError) {
      // show warning pop up
    } else {
      final AppData appData = Provider.of<AppData>(context, listen: false);
      appData.updateDriver(user);
    }
  }
}
