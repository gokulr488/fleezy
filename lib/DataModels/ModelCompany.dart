import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';

class ModelCompany {
  String companyName;
  String companyEmail;
  String password;
  String phoneNumber;
  List<ModelVehicle> vehicles = [];
  List<ModelUser> users = [];
  List<ModelExpense> expenses = [];
  List<ModelTrip> trips = [];

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
