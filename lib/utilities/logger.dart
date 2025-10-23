import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wick_apps/utilities/string_formatter.dart';
import 'package:wick_apps/utilities/type_converter.dart';

import '../enums/log_type.dart';

class WickUtilityLogger {
  static void log(
    BuildContext? context,
    WickEnumLogType logType,
    dynamic content,
  ) {
    // TODO Check if we should log the current type. If not, return.
    final String logTypeDisplayName = WickUtilityStringFormatter.titleCase(
      logType.name,
    );
    final String contentString = WickUtilityTypeConverter.convert(
      content,
      blockLogging: true,
    );
    if (kDebugMode) {
      debugPrint('$logTypeDisplayName: $contentString');
    }
    // TODO Save the log to the backend. Be careful of an infinite loop with outgoingRequests.
  }
}
