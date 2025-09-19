import 'base.dart';

class WickModelDashboardTileOption
    extends WickModelBase<WickModelDashboardTileOption> {
  final bool active;
  final String name;

  WickModelDashboardTileOption({required this.active, required this.name})
    : super({'active': active, 'name': name});
}
