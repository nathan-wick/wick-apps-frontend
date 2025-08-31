import '../models/preferences.dart';
import 'base.dart';

class PreferencesProvider extends BaseProvider<PreferencesModel> {
  PreferencesProvider() : super(PreferencesModel.fromJson);
}
