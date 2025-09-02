import '../models/preferences.dart';
import 'base.dart';

class WickControllerPreferences
    extends WickControllerBase<WickModelPreferences> {
  WickControllerPreferences() : super(WickModelPreferences.fromJson);
}
