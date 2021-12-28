class Constants {
  static const String COMPANIES = 'Companies';
  static const String VEHICLES = 'Vehicles';
  static const String USERS = 'Users';
  static const String EXPENSE = 'Expense';
  static const String REPORT = 'Report';
  static const String TRIP = 'Trip';
  static const String ADMIN = 'Admin';
  static const String DRIVER = 'Driver';
  static const String SUPERUSER = 'SuperUser';
  static const String ACTIVE = 'Active';
  static const String INACTIVE = 'Inactive';
  static const String STARTED = 'Started';
  static const String CANCELLED = 'Cancelled';
  static const String ENDED = 'Ended';

  static const String FUEL_BILLS_FOLDER = 'fuel_bills/';

  static const String FUEL = 'Fuel';
  static const String SERVICE = 'Service';
  static const String REPAIR = 'Repair';
  static const String SPARE_PARTS = 'Spare Parts';
  static const String FINES = 'Fines';
  static const String FASTAG = 'Fastag';
  static const String DRIVER_SALARY = 'Driver Salary';
  static const String OTHER_EXP = 'Other Expense';
  static const String TAX_EXP = 'Tax Payment';
  static const String INSURANCE_EXP = 'Insurance Payment';

  static const String MONTHLY = 'Monthly';
  static const String QUARTERLY = 'Quarterly';
  static const String YEARLY = 'Yearly';

  static const String Q1 = 'Jan-Mar';
  static const String Q2 = 'Apr-Jun';
  static const String Q3 = 'Jul-Sep';
  static const String Q4 = 'Oct-Dec';

  static const List<String> EXPENSE_TYPES = [
    SERVICE,
    REPAIR,
    SPARE_PARTS,
    FINES,
    OTHER_EXP
  ];

  static const int MILLISECONDS_PER_MONTH = 2592000000;

  static const String EMAIL_PATTERN =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
