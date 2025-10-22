import 'package:flutter/cupertino.dart';

import '../enums/log_type.dart';
import '../utilities/local_storage.dart';
import '../utilities/logger.dart';
import '../utilities/string_formatter.dart';

abstract class WickProviderBase<T> extends ChangeNotifier {
  /// The name of the model.
  final String modelName = WickUtilityStringFormatter.titleCase(
    T
        .toString()
        .replaceAll('Wick', '')
        .replaceAll('Model', '')
        .replaceAll('Provider', ''),
  );

  /// The key used to locate the value in local storage.
  final String localStorageKey =
      "provider_${WickUtilityStringFormatter.toSnakeCase(T.toString().replaceAll('Wick', '').replaceAll('Model', '').replaceAll('Provider', ''))}";

  /// The value of the provider.
  T? value;

  /// Gets the value of the provider.
  Future<T?> getValue(BuildContext context) async {
    value ??= await WickUtilityLocalStorage<T>().getModelValue(localStorageKey);
    WickUtilityLogger.log(context, WickEnumLogType.provider, {
      'provider': modelName,
      'method': 'getValue',
      'value': value,
      'localStorageKey': localStorageKey,
    });
    return value;
  }

  /// Sets the value of the provider.
  Future<void> setValue(BuildContext context, T? newValue) async {
    value = newValue;
    WickUtilityLocalStorage<T>().setModelValue(localStorageKey, newValue);
    WickUtilityLogger.log(context, WickEnumLogType.provider, {
      'provider': modelName,
      'method': 'setValue',
      'value': value,
      'localStorageKey': localStorageKey,
    });
    notifyListeners();
  }
}
