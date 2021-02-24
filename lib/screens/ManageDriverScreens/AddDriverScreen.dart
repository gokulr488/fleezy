import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _kHeaderTextStyle = TextStyle(
    fontSize: 30, fontWeight: FontWeight.bold, color: kHighlightColour);

class AddDriverScreen extends StatefulWidget {
  static const String id = 'AddDriverScreen';
  @override
  _AddDriverScreenState createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  ModelUser user = ModelUser(roleName: Constants.DRIVER);
  bool showLoading = false;
  String message = '';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        headerText: 'Add New User',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('User Details', style: _kHeaderTextStyle),
            SizedBox(height: 20),
            Expanded(
              child: ScrollableList(childrenHeight: 80, items: [
                TextField(
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      user.fullName = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: 'Full Name')),
                TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      user.phoneNumber = '+91' + value; //TODO change this impl
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Phone Number')),
                TextField(
                    onChanged: (value) {
                      user.userEmailId = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: 'Email ID')),
                DropDown(
                    defaultValue: Constants.DRIVER,
                    values: [Constants.ADMIN, Constants.DRIVER],
                    hintText: 'User Type',
                    onChanged: (String value) {
                      user.roleName = value;
                    }),
                showLoading ? LoadingDots(size: 80) : SizedBox(),
                Center(child: Text(message, style: TextStyle(fontSize: 16)))
              ]),
            ),
            ButtonCard(
                onTap: () {
                  _addDriverToDb(context);
                },
                buttonText: 'Add Driver')
          ],
        ));
  }

  _addDriverToDb(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (valid()) {
      showLoading = true;
      setState(() {});
      AppData appData = Provider.of<AppData>(context, listen: false);
      user.companyId = appData.user.companyId;
      user.state = Constants.ACTIVE;
      CallContext callContext = await Roles().addRole(user);
      if (!callContext.isError) {
        appData.addNewDriver(user);
        Navigator.pop(context);
        return;
      } else {
        showLoading = false;
        message = callContext.errorMessage;
        //setState(() {});
      }
    }
    setState(() {});
  }

  bool valid() {
    if (user.fullName == null || user.fullName.isEmpty) {
      message = 'No Name Provided';
      return false;
    }
    if (user.phoneNumber == null || user.phoneNumber.length != 13) {
      message = 'Enter Valid Phone Number';
      return false;
    }
    if (user.userEmailId == null ||
        !RegExp(Constants.EMAIL_PATTERN).hasMatch(user.userEmailId)) {
      message = 'Enter Valid Email ID';
      return false;
    }
    return true;
  }
}
