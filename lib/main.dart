import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ListVehiclesScreen.dart';
import 'package:fleezy/screens/LoginScreen.dart';
import 'package:fleezy/screens/ManageDriverScreens/AddDriverScreen.dart';
import 'package:fleezy/screens/ManageDriverScreens/ManageDriversScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/AddVehicleScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/InsurancePaymentScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehicleScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehiclesScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/TaxPaymentScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/StartNewTripScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/VehicleOverviewScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addexpense/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addfuel/AddFuelScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceDetailScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryDetailsScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryScreen.dart';
import 'package:fleezy/screens/ontrip/OnTripScreen.dart';
import 'package:fleezy/screens/reports/ReportsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//flutter build  apk --target-platform android-arm
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    // ignore: always_specify_types
    providers: [
      ChangeNotifierProvider<AppData>(create: (_) => AppData()),
      ChangeNotifierProvider<UiState>(create: (_) => UiState()),
      ChangeNotifierProvider<ReportData>(create: (_) => ReportData()),
    ],
    child: FleezyApp(),
  ));
}

class FleezyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'Fleezy',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            //brightness: Brightness.dark,
            textTheme: GoogleFonts.koHoTextTheme(
                ThemeData(brightness: Brightness.light).textTheme)),
        initialRoute: _isLoggedIn(context) ? HomeScreen.id : StartScreen.id,
        routes: <String, Widget Function(BuildContext)>{
          HomeScreen.id: (BuildContext context) => HomeScreen(),
          ListVehiclesScreen.id: (BuildContext context) => ListVehiclesScreen(),
          StartScreen.id: (BuildContext context) => StartScreen(),
          CreateCompanyScreen.id: (BuildContext context) =>
              CreateCompanyScreen(),
          LoginScreen.id: (BuildContext context) => LoginScreen(),
          AddVehicleScreen.id: (BuildContext context) => AddVehicleScreen(),
          VehicleOverviewScreen.id: (BuildContext context) =>
              VehicleOverviewScreen(),
          StartNewTripScreen.id: (BuildContext context) => StartNewTripScreen(),
          AddFuelScreen.id: (BuildContext context) => AddFuelScreen(),
          AddExpenseScreen.id: (BuildContext context) => AddExpenseScreen(),
          ManageVehicleScreen.id: (BuildContext context) =>
              ManageVehicleScreen(),
          ManageVehiclesScreen.id: (BuildContext context) =>
              ManageVehiclesScreen(),
          ManageDriversScreen.id: (BuildContext context) =>
              ManageDriversScreen(),
          AddDriverScreen.id: (BuildContext context) => AddDriverScreen(),
          OnTripScreen.id: (BuildContext context) => OnTripScreen(),
          TripHistoryScreen.id: (BuildContext context) => TripHistoryScreen(),
          TripHistoryDetailsScreen.id: (BuildContext context) =>
              TripHistoryDetailsScreen(),
          ReportsScreen.id: (BuildContext context) => ReportsScreen(),
          PendingBalanceScreen.id: (BuildContext context) =>
              PendingBalanceScreen(),
          PendingBalanceDetailScreen.id: (BuildContext context) =>
              PendingBalanceDetailScreen(),
          TaxPaymentScreen.id: (BuildContext context) => TaxPaymentScreen(),
          InsurancePaymentScreen.id: (BuildContext context) =>
              InsurancePaymentScreen(),
        });
  }
}

bool _isLoggedIn(BuildContext context) {
  // FirebaseFirestore.instance.settings =
  //     Settings(host: '10.0.2.2:8080', sslEnabled: false);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  if (_auth.currentUser != null) {
    //Provider.of<UiState>(context, listen: false).setIsAdmin(true);
    return true;
  } else {
    return false;
  }
}
