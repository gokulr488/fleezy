import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ListVehiclesScreen.dart';
import 'package:fleezy/screens/LoginScreen.dart';
import 'package:fleezy/screens/ManageDriverScreens/AddDriverScreen.dart';
import 'package:fleezy/screens/ManageDriverScreens/ManageDriversScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/AddVehicleScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehicleScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehiclesScreen.dart';
import 'package:fleezy/screens/ontrip/OnTripScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addfuel/AddFuelScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/StartNewTripScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/VehicleOverviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//flutter build apk --split-per-abi
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppData()),
      ChangeNotifierProvider(create: (_) => UiState())
    ],
    child: FleezyApp(),
  ));
}

class FleezyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'Fleezy',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: _isLoggedIn(context) ? HomeScreen.id : StartScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          ListVehiclesScreen.id: (context) => ListVehiclesScreen(),
          StartScreen.id: (context) => StartScreen(),
          CreateCompanyScreen.id: (context) => CreateCompanyScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          AddVehicleScreen.id: (context) => AddVehicleScreen(),
          VehicleOverviewScreen.id: (context) => VehicleOverviewScreen(),
          StartNewTripScreen.id: (context) => StartNewTripScreen(),
          AddFuelScreen.id: (context) => AddFuelScreen(),
          AddExpenseScreen.id: (context) => AddExpenseScreen(),
          ManageVehicleScreen.id: (context) => ManageVehicleScreen(),
          ManageVehiclesScreen.id: (context) => ManageVehiclesScreen(),
          ManageDriversScreen.id: (context) => ManageDriversScreen(),
          AddDriverScreen.id: (context) => AddDriverScreen(),
          OnTripScreen.id: (context) => OnTripScreen(),
        });
  }
}

bool _isLoggedIn(BuildContext context) {
  final _auth = FirebaseAuth.instance;
  if (_auth.currentUser != null) {
    Provider.of<UiState>(context, listen: false).setIsAdmin(true);
    return true;
  } else {
    return false;
  }
}
