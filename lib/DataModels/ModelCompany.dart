import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';

class ModelCompany {
  String companyName;
  String companyEmail;
  String password;
  String phoneNumber;
  Map<String, ModelVehicle> vehicles;
  Map<String, ModelUser> users;
  Map<String, ModelExpense> expenses;
  Map<String, ModelTrip> trips;

  ModelCompany(
      {this.trips,
      this.users,
      this.expenses,
      this.companyName,
      this.companyEmail,
      this.password,
      this.phoneNumber,
      this.vehicles});
}
