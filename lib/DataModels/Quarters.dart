enum Quarter { Jan_Mar, Apr_Jun, Jul_Sep, Oct_Dec }

extension ParseToString on Quarter {
  String getString() {
    return toString().split('.').last.replaceAll('_', ' ');
  }
}
