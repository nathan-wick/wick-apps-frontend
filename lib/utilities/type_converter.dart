import 'package:collection/collection.dart';

import '../enumerations/brightness.dart';
import '../enumerations/color.dart';
import '../enumerations/date_format.dart';
import '../models/base.dart';

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
  static String? describe(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is DateTime) {
      final year = value.year.toString().padLeft(4, '0');
      final month = value.month.toString().padLeft(2, '0');
      final day = value.day.toString().padLeft(2, '0');
      // TODO: Pass in the user's preferred date format
      switch (DateFormat.yearMonthDay) {
        case DateFormat.yearMonthDay:
          return '$year/$month/$day';
        case DateFormat.dayMonthYear:
          return '$day/$month/$year';
        case DateFormat.monthDayYear:
          return '$month/$day/$year';
      }
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
  static DateTime? toDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
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
}
