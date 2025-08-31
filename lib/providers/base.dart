import 'package:flutter/cupertino.dart';

import '../models/base.dart';
import '../utilities/local_storage.dart';
import '../utilities/string_formatter.dart';

abstract class BaseProvider<Model extends BaseModel> extends ChangeNotifier {
  /// The key used to locate the value in local storage.
  final String localStorageKey = StringFormatter.toSnakeCase(
    Model.toString().replaceAll('Model', ''),
  );
  final Model Function(Map<String, dynamic>) fromJson;

  /// The value of the provider.
  Model? _value;

  BaseProvider(this.fromJson);

  /// Gets the value of the provider.
  Future<Model?> getValue() async {
    _value ??= await LocalStorage<Model>().getValue(localStorageKey, fromJson);
    return _value;
  }

  /// Sets the value of the provider.
  Future<void> setValue(Model? value) async {
    _value = value;
    LocalStorage<Model>().setValue(localStorageKey, value);
    notifyListeners();
  }
}
