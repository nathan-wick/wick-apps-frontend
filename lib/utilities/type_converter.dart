import 'dart:convert';

import 'package:collection/collection.dart';

import '../enums/date_format.dart';
import '../enums/log_type.dart';
import 'enum_helper.dart';
import 'input_validator.dart';
import 'logger.dart';
import 'model_registry.generated.dart';

class WickUtilityTypeConverter {
  /// Converts a value to a specified type.
  static T convert<T>(
    dynamic value, {
    WickEnumDateFormat? dateFormat,
    bool blockLogging = false,
  }) {
    T result;
    if (value == null && null is T) {
      result = null as T;
    } else if (value is T) {
      result = value;
    } else {
      result = switch (T) {
        int => _toInt(value) as T,
        double => _toDouble(value) as T,
        bool => _toBool(value) as T,
        String => _toString(value, dateFormat) as T,
        DateTime => _toDateTime(value, dateFormat) as T,
        List => _toList(value) as T,
        Map => _toMap<T>(value) as T,
        Enum => _toEnum<T>(value) as T,
        Object => _toModel<T>(value) as T,
        _ => value as T,
      };
    }
    if (!blockLogging) {
      WickUtilityLogger.log(null, WickEnumLogType.typeConversion, {
        'method': 'convert',
        'inValue': value,
        'inType': value.runtimeType.toString(),
        'outValue': result,
        'outType': T.toString(),
      });
    }
    return result;
  }

  /// Converts a dynamic value to a JSON string.
  static String toJson(dynamic value, {bool blockLogging = false}) {
    final String json = jsonEncode(_toJsonSafeValue(value));
    if (!blockLogging) {
      WickUtilityLogger.log(null, WickEnumLogType.typeConversion, {
        'method': 'toJson',
        'inValue': value,
        'inType': value.runtimeType.toString(),
        'outValue': json,
      });
    }
    return json;
  }

  /// Converts a dynamic value to a JSON-safe value.
  static Object? _toJsonSafeValue(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value.toUtc().toIso8601String();
    if (value is Enum) return value.name;
    if (value is List) {
      return value.map((item) => _toJsonSafeValue(item)).toList();
    }
    if (value is Map) {
      return value.map(
        (key, val) => MapEntry(key.toString(), _toJsonSafeValue(val)),
      );
    }
    return convert<String>(value, blockLogging: true);
  }

  /// Converts a JSON string to a typed value.
  static T? fromJson<T>(String? json) {
    if (json == null || json.isEmpty) return null;
    final Map<String, dynamic> decoded = jsonDecode(json);
    final constructor = WickUtilityModelRegistry.constructors[T];
    final result = constructor == null ? null : constructor(decoded) as T;
    WickUtilityLogger.log(null, WickEnumLogType.typeConversion, {
      'method': 'fromJson',
      'inValue': json,
      'outValue': result,
      'outType': T.toString(),
    });
    return result;
  }

  /// Converts value to integer.
  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is DateTime) return value.millisecondsSinceEpoch;
    if (value is Enum) return value.index;
    if (value is Object) return toJson(value, blockLogging: true).hashCode;
    if (value is List) return value.length;
    if (value is Map) return value.length;
    return 0;
  }

  /// Converts value to double.
  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is bool) return value ? 1.0 : 0.0;
    if (value is String) return double.tryParse(value) ?? 0;
    if (value is DateTime) return value.millisecondsSinceEpoch.toDouble();
    if (value is Enum) return value.index.toDouble();
    if (value is Object)
      return toJson(value, blockLogging: true).hashCode.toDouble();
    if (value is List) return value.length.toDouble();
    if (value is Map) return value.length.toDouble();
    return 0;
  }

  /// Converts value to boolean.
  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value > 0;
    if (value is double) return value > 0;
    if (value is String) {
      final lower = value.toLowerCase().trim();
      if (lower == 'true' || lower == '1' || lower == 'yes' || lower == 'y') {
        return true;
      }
      if (lower == 'false' ||
          lower == '0' ||
          lower == 'no' ||
          lower == 'n' ||
          lower.isEmpty) {
        return false;
      }
      return value.isNotEmpty;
    }
    if (value is DateTime) return DateTime.now().isBefore(value);
    if (value is Enum) return value.index > 0;
    if (value is Object) return true;
    if (value is List) return value.isNotEmpty;
    if (value is Map) return value.isNotEmpty;
    return false;
  }

  /// Converts value to String.
  static String _toString(dynamic value, [WickEnumDateFormat? dateFormat]) {
    if (value is String) return value;
    if (value is DateTime) {
      if (dateFormat != null) {
        return _formatDateTime(value, dateFormat);
      }
      return value.toIso8601String();
    }
    if (value is Enum) return value.name;
    if (value is Object) {
      final json = toJson(value, blockLogging: true);
      return json.toString();
    }
    if (value is List) {
      return _formatList(value);
    }
    if (value is Map) {
      return value.toString();
    }
    return value.toString();
  }

  /// Formats a DateTime according to the specified format.
  static String _formatDateTime(DateTime value, WickEnumDateFormat dateFormat) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    switch (dateFormat) {
      case WickEnumDateFormat.yearMonthDay:
        return '$year/$month/$day';
      case WickEnumDateFormat.dayMonthYear:
        return '$day/$month/$year';
      case WickEnumDateFormat.monthDayYear:
        return '$month/$day/$year';
    }
  }

  /// Formats a list as a human-readable string.
  static String _formatList(List value) {
    final strings = value.map((item) => _toString(item)).toList();
    if (strings.isEmpty) return '';
    if (strings.length == 1) return strings[0];
    if (strings.length == 2) return '${strings[0]} and ${strings[1]}';
    return '${strings.sublist(0, strings.length - 1).join(', ')}, and ${strings.last}';
  }

  /// Converts value to DateTime.
  static DateTime _toDateTime(dynamic value, [WickEnumDateFormat? dateFormat]) {
    if (value is DateTime) return value;
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is double) {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt());
    }
    if (value is String) {
      if (dateFormat != null) {
        return _parseDateTime(value, dateFormat);
      }
      final isoDate = DateTime.tryParse(value);
      if (isoDate != null) return isoDate;
    }
    return DateTime.now();
  }

  /// Parses a date string according to the specified format.
  static DateTime _parseDateTime(String value, WickEnumDateFormat dateFormat) {
    if (WickUtilityInputValidator.date(value, dateFormat) == null) {
      return DateTime.now();
    }
    final valueParts = value.split('/');
    if (valueParts.length != 3) return DateTime.now();
    try {
      int year, month, day;
      switch (dateFormat) {
        case WickEnumDateFormat.yearMonthDay:
          year = int.parse(valueParts[0]);
          month = int.parse(valueParts[1]);
          day = int.parse(valueParts[2]);
          break;
        case WickEnumDateFormat.dayMonthYear:
          day = int.parse(valueParts[0]);
          month = int.parse(valueParts[1]);
          year = int.parse(valueParts[2]);
          break;
        case WickEnumDateFormat.monthDayYear:
          month = int.parse(valueParts[0]);
          day = int.parse(valueParts[1]);
          year = int.parse(valueParts[2]);
          break;
      }
      return DateTime(year, month, day);
    } catch (error) {
      return DateTime.now();
    }
  }

  /// Converts value to List.
  static List _toList(dynamic value) {
    if (value is List) return value;
    if (value is String) {
      try {
        final trimmed = value.trim();
        if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
          return [value];
        }
      } catch (error) {
        // Fall through
      }
      if (value.contains(',')) {
        return value.split(',').map((s) => s.trim()).toList();
      }
      return [value];
    }
    if (value is Map) return value.values.toList();
    return [value];
  }

  /// Converts value to Map.
  static Map _toMap<T>(dynamic value) {
    if (value is Map) {
      final typeString = T.toString();
      if (typeString.contains('Map')) {
        try {
          // TODO This can be improved
          if (typeString == 'Map<String, String>') {
            return value
                .map(
                  (key, val) => MapEntry(
                    convert<String>(key, blockLogging: true),
                    convert<String>(val, blockLogging: true),
                  ),
                )
                .cast<String, String>();
          }
          if (typeString == 'Map<String, int>') {
            return value
                .map(
                  (key, val) => MapEntry(
                    convert<String>(key, blockLogging: true),
                    convert<int>(val, blockLogging: true),
                  ),
                )
                .cast<String, int>();
          }
          if (typeString == 'Map<String, double>') {
            return value
                .map(
                  (key, val) => MapEntry(
                    convert<String>(key, blockLogging: true),
                    convert<double>(val, blockLogging: true),
                  ),
                )
                .cast<String, double>();
          }
          if (typeString == 'Map<String, bool>') {
            return value
                .map(
                  (key, val) => MapEntry(
                    convert<String>(key, blockLogging: true),
                    convert<bool>(val, blockLogging: true),
                  ),
                )
                .cast<String, bool>();
          }
          return value.cast<String, dynamic>();
        } catch (error) {
          return {};
        }
      }
    }
    return {};
  }

  /// Converts value to Enum.
  static T? _toEnum<T>(dynamic value) {
    final enumValues = WickUtilityEnumHelper.getValues(T);
    if (value is String) {
      return enumValues.firstWhereOrNull(
            (enumValue) => enumValue.name.toLowerCase() == value.toLowerCase(),
          )
          as T?;
    }
    if (value is int) {
      if (value >= 0 && value < enumValues.length) {
        return enumValues[value] as T?;
      }
    }
    return null;
  }

  /// Converts value to WickModelBase.
  static T? _toModel<T>(dynamic value) {
    final constructor = WickUtilityModelRegistry.constructors[T];
    if (constructor == null) return null;
    if (value is Map<String, dynamic>) {
      final result = constructor(value);
      return result as T?;
    }
    if (value is String) {
      try {
        final trimmed = value.trim();
        if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
          return null;
        }
      } catch (error) {
        return null;
      }
    }
    if (value is Object && value is T) {
      return value as T;
    }
    return null;
  }
}
