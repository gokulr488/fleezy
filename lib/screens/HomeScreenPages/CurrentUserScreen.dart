import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const TextStyle _kLabelTS =
    TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold);
const TextStyle _kFieldTS =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

class CurrentUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('User Info', style: kHeaderTextStyle),
        const Icon(
          Icons.account_circle,
          size: 100,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Icon(Icons.account_circle, size: 18),
                      SizedBox(width: 10),
                      Text('Name', style: _kLabelTS),
                    ],
                  ),
                  _EditNameWidget(),
                  const HorLine(),
                  Row(
                    children: const <Widget>[
                      Icon(Icons.phone, size: 18),
                      SizedBox(width: 10),
                      Text('Phone Number', style: _kLabelTS),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(appData.user?.phoneNumber ?? '', style: _kFieldTS),
                  const HorLine(),
                  Row(
                    children: const <Widget>[
                      Icon(Icons.info_outline, size: 18),
                      SizedBox(width: 10),
                      Text('User Type', style: _kLabelTS),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(appData.user?.roleName ?? '', style: _kFieldTS),
                  const HorLine(),
                ],
              ),
            ),
          ),
        ),
        RoundedButton(
            colour: kRedColor,
            title: 'Logout',
            onPressed: () {
              Authentication().logout();

              Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
              Navigator.pushReplacementNamed(context, StartScreen.id);
            })
      ],
    );
  }
}

class _EditNameWidget extends StatefulWidget {
  @override
  __EditNameWidgetState createState() => __EditNameWidgetState();
}

class __EditNameWidgetState extends State<_EditNameWidget> {
  bool isEditEnabled = false;

  TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    nameController = TextEditingController(text: appData.user.fullName ?? '');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (isEditEnabled)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: nameController,
              decoration: kTextFieldDecoration,
            ),
          )
        else
          Text(appData.user.fullName ?? '', style: _kFieldTS),
        IconButton(
            icon: Icon(isEditEnabled ? Icons.check_circle : Icons.edit),
            onPressed: () => onPressed(appData)),
      ],
    );
  }

  Future<void> onPressed(AppData appData) async {
    if (!isEditEnabled) {
      isEditEnabled = !isEditEnabled;
      setState(() {});
      return;
    }
    final ModelUser user = appData.user;
    user.fullName = nameController.text;
    final CallContext callContext = await Roles().updateRole(user);
    if (callContext.isError) {
      showErrorAlert(context, 'Unable to modify Name');
      return;
    }
    appData.setUser(user);
    isEditEnabled = !isEditEnabled;
    setState(() {});
  }
}
