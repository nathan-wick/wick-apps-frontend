import 'package:flutter/cupertino.dart';

import '../models/base.dart';
import '../utilities/local_storage.dart';
import '../utilities/string_formatter.dart';

abstract class WickProviderBase<Model extends WickModelBase>
    extends ChangeNotifier {
  /// The key used to locate the value in local storage.
  final String WickUtilityLocalStorageKey =
      WickUtilityStringFormatter.toSnakeCase(
        Model.toString().replaceAll('Model', ''),
      );
  final Model Function(Map<String, dynamic>) fromJson;

  /// The value of the provider.
  Model? _value;

  WickProviderBase(this.fromJson);

  /// Gets the value of the provider.
  Future<Model?> getValue() async {
    _value ??= await WickUtilityLocalStorage<Model>().getModelValue(
      WickUtilityLocalStorageKey,
      fromJson,
    );
    return _value;
  }

  /// Sets the value of the provider.
  Future<void> setValue(Model? value) async {
    _value = value;
    WickUtilityLocalStorage<Model>().setModelValue(
      WickUtilityLocalStorageKey,
      value,
    );
    notifyListeners();
  }
}
