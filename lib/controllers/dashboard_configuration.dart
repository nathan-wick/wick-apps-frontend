import '../models/dashboard_configuration.dart';
import 'base.dart';

class DashboardConfigurationController
    extends BaseController<DashboardConfigurationModel> {
  DashboardConfigurationController()
    : super(DashboardConfigurationModel.fromJson);
}
