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
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceDetailScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryDetailsScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryScreen.dart';
import 'package:fleezy/screens/ontrip/OnTripScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addexpense/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addfuel/AddFuelScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/StartNewTripScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/VehicleOverviewScreen.dart';
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
    providers: [
      ChangeNotifierProvider(create: (_) => AppData()),
      ChangeNotifierProvider(create: (_) => UiState()),
      ChangeNotifierProvider(create: (_) => ReportData()),
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
            primaryColor: kPrimaryColor,
            //brightness: Brightness.dark,
            textTheme: GoogleFonts.koHoTextTheme(
                ThemeData(brightness: Brightness.light).textTheme)),
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
          TripHistoryScreen.id: (context) => TripHistoryScreen(),
          TripHistoryDetailsScreen.id: (context) => TripHistoryDetailsScreen(),
          ReportsScreen.id: (context) => ReportsScreen(),
          PendingBalanceScreen.id: (context) => PendingBalanceScreen(),
          PendingBalanceDetailScreen.id: (context) =>
              PendingBalanceDetailScreen(),
          TaxPaymentScreen.id: (context) => TaxPaymentScreen(),
          InsurancePaymentScreen.id: (context) => InsurancePaymentScreen(),
        });
  }
}

bool _isLoggedIn(BuildContext context) {
  // FirebaseFirestore.instance.settings =
  //     Settings(host: '10.0.2.2:8080', sslEnabled: false);
  final _auth = FirebaseAuth.instance;
  if (_auth.currentUser != null) {
    //Provider.of<UiState>(context, listen: false).setIsAdmin(true);
    return true;
  } else {
    return false;
  }
}
