import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';

class ModelCompany {
  final String companyName;
  final String companyEmail;
  final String password;
  final String phoneNumber;
  final List<ModelVehicle> vehicles;
  final List<ModelUser> users;
  final List<ModelExpense> expenses;
  final List<ModelTrip> trips;
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
