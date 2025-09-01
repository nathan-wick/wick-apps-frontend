import 'package:wick_apps/utilities/regular_expression.dart';

import '../enums/date_format.dart';

class WickUtilityInputValidator {
  static String? date(String value, DateFormat dateFormat) {
    if (!WickUtilityRegularExpression.date.hasMatch(value)) {
      return "Date must be in ${dateFormat.value} format.";
    }
    final valueParts = value.split('/');
    int year;
    int month;
    int day;
    switch (dateFormat) {
      case DateFormat.yearMonthDay:
        year = int.parse(valueParts[0]);
        month = int.parse(valueParts[1]);
        day = int.parse(valueParts[2]);
        break;
      case DateFormat.dayMonthYear:
        day = int.parse(valueParts[0]);
        month = int.parse(valueParts[1]);
        year = int.parse(valueParts[2]);
        break;
      case DateFormat.monthDayYear:
        month = int.parse(valueParts[0]);
        day = int.parse(valueParts[1]);
        year = int.parse(valueParts[2]);
        break;
    }
    if (month < 1 || month > 12) {
      return "Month must be between 01 and 12.";
    }
    List<int> daysInMonth = [
      31, // January
      28, // February (non-leap year)
      31, // March
      30, // April
      31, // May
      30, // June
      31, // July
      31, // August
      30, // September
      31, // October
      30, // November
      31, // December
    ];
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
      daysInMonth[1] = 29; // February in a leap year
    }
    if (day < 1 || day > daysInMonth[month - 1]) {
      return "Day must be between 01 and ${daysInMonth[month - 1]}.";
    }
    return null;
  }
}
