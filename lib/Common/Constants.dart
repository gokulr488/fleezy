class Constants {
  static const String COMPANIES = "Companies";
  static const String VEHICLES = "Vehicles";
  static const String USERS = "Users";
  static const String EXPENSE = "Expense";
  static const String TRIP = "Trip";
  static const String ADMIN = "Admin";
  static const String DRIVER = "Driver";
  static const String SUPERUSER = "SuperUser";
  static const String ACTIVE = "Active";
  static const String INACTIVE = "Inactive";
  static const String CANCELLED = 'Cancelled';

  static const String FUEL = 'Fuel';
  static const int MILLISECONDS_PER_MONTH = 2592000000;

  static const Pattern EMAIL_PATTERN =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
