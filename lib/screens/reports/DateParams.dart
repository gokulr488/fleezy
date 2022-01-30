import 'package:fleezy/DataModels/Quarters.dart';
import 'package:intl/intl.dart';

class DateParams {
  DateParams({int month, Quarter quarter}) {
    if (month != null) {
      _month = month;
      final date = DateTime(2022, month);
      _monthStr = DateFormat('MMM').format(date);
    }
    if (quarter != null) {
      _quarter = quarter;
      _quarterStr = quarter.getString();
    }
  }

  String get monthStr => _monthStr;
  String get quarterStr => _quarterStr;
  int get month => _month;
  Quarter get quarter => _quarter;

  set monthStr(String monthStr) {
    _monthStr = monthStr;
    for (int i = 1; i <= 12; i++) {
      final selecteDate = DateTime(2022, i);
      if (monthStr == DateFormat('MMM').format(selecteDate)) {
        _month = i;
        break;
      }
    }
  }

  set month(int month) {
    _month = month;
    final date = DateTime(2022, month);
    _monthStr = DateFormat('MMM').format(date);
  }

  set quarter(Quarter quarter) {
    _quarter = quarter;
    _quarterStr = quarter.getString();
  }

  String _monthStr;
  String _quarterStr;
  int _month;
  Quarter _quarter;
}
