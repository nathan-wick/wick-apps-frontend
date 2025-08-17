import '../models/preferences.dart';
import 'base.dart';

class PreferencesController extends BaseController<PreferencesModel> {
  PreferencesController() : super(PreferencesModel.fromJson);
}
