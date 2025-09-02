import '../models/preferences.dart';
import 'base.dart';

class WickProviderPreferences extends WickProviderBase<WickModelPreferences> {
  WickProviderPreferences() : super(WickModelPreferences.fromJson);
}
