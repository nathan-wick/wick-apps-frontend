import 'package:collection/collection.dart';

import '../enums/brightness.dart';
import '../enums/color.dart';
import '../enums/date_format.dart';
import '../models/base.dart';
import 'input_validator.dart';

class TypeConverter {
  /// Converts a dynamic value to a JSON-safe value.
  static Object? toJson(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value.toUtc().toIso8601String();
    if (value is List) return value.map((item) => toJson(item)).toList();
    if (value is BaseModel) return value.toJson();
    return value;
  }

  /// Converts a dynamic value to a string.
  static String? describe(dynamic value, [DateFormat? dateFormat]) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is DateTime) {
      if (dateFormat != null) {
        final year = value.year.toString().padLeft(4, '0');
        final month = value.month.toString().padLeft(2, '0');
        final day = value.day.toString().padLeft(2, '0');
        switch (dateFormat) {
          case DateFormat.yearMonthDay:
            return '$year/$month/$day';
          case DateFormat.dayMonthYear:
            return '$day/$month/$year';
          case DateFormat.monthDayYear:
            return '$month/$day/$year';
        }
      }
      return value.toString();
    }
    if (value is List) {
      final strings = value.map((item) => describe(item)).toList();
      if (strings.isEmpty) {
        return null;
      } else if (strings.length == 1) {
        return strings[0];
      } else if (strings.length == 2) {
        return '${strings[0]} and ${strings[1]}';
      } else {
        return '${strings.sublist(0, strings.length - 1).join(', ')}, and ${strings.last}';
      }
    }
    return value.toString();
  }

  /// Converts a dynamic value to an integer.
  static int? toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }

  /// Converts a dynamic value to a DateTime.
  static DateTime? toDate(dynamic value, [DateFormat? dateFormat]) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      if (dateFormat != null) {
        if (WickUtilityInputValidator.date(value, dateFormat) != null) {
          return DateTime.tryParse(value);
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
        return DateTime(year, month, day);
      }
      return DateTime.tryParse(value);
    }
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    if (value is double) return toDate(value.toInt());
    return null;
  }

  /// Converts a dynamic value to a color.
  static WickColor? toColor(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      return WickColor.values.firstWhereOrNull((color) => color.name == value);
    }
    return null;
  }

  /// Converts a dynamic value to a date format.
  static DateFormat? toDateFormat(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      return DateFormat.values.firstWhereOrNull(
        (dateFormat) => dateFormat.name == value,
      );
    }
    return null;
  }

  /// Converts a dynamic value to a theme.
  static WickBrightness? toBrightness(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      return WickBrightness.values.firstWhereOrNull(
        (brightness) => brightness.name == value,
      );
    }
    return null;
  }

  /// Converts a dynamic value to a bool.
  static bool? toBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return null;
  }
}
