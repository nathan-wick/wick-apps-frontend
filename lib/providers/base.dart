import 'package:flutter/cupertino.dart';

import '../enums/log_type.dart';
import '../models/base.dart';
import '../utilities/local_storage.dart';
import '../utilities/logger.dart';
import '../utilities/string_formatter.dart';

abstract class WickProviderBase<Model extends WickModelBase>
    extends ChangeNotifier {
  /// The name of the model.
  final String modelName = WickUtilityStringFormatter.titleCase(
    Model.toString()
        .replaceAll('Wick', '')
        .replaceAll('Model', '')
        .replaceAll('Provider', ''),
  );

  /// The key used to locate the value in local storage.
  final String localStorageKey =
      "provider_${WickUtilityStringFormatter.toSnakeCase(Model.toString().replaceAll('Wick', '').replaceAll('Model', '').replaceAll('Provider', ''))}";
  final Model Function(Map<String, dynamic>) fromJson;

  /// The value of the provider.
  Model? value;

  WickProviderBase(this.fromJson);

  /// Gets the value of the provider.
  Future<Model?> getValue(BuildContext context) async {
    value ??= await WickUtilityLocalStorage<Model>().getModelValue(
      localStorageKey,
      fromJson,
    );
    WickUtilityLogger.log(context, WickEnumLogType.provider, {
      'provider': modelName,
      'method': 'getValue',
      'value': value,
      'localStorageKey': localStorageKey,
    });
    return value;
  }

  /// Sets the value of the provider.
  Future<void> setValue(BuildContext context, Model? newValue) async {
    value = newValue;
    WickUtilityLocalStorage<Model>().setModelValue(localStorageKey, newValue);
    WickUtilityLogger.log(context, WickEnumLogType.provider, {
      'provider': modelName,
      'method': 'setValue',
      'value': value,
      'localStorageKey': localStorageKey,
    });
    notifyListeners();
  }
}
