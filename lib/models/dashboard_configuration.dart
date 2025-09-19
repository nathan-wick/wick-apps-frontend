import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelDashboardConfiguration
    extends WickModelBase<WickModelDashboardConfiguration> {
  final int id;
  final int userId;
  final String dashboard;
  final String configuration;

  WickModelDashboardConfiguration({
    required this.id,
    required this.userId,
    required this.dashboard,
    required this.configuration,
  }) : super({
         'id': id,
         'userId': userId,
         'dashboard': dashboard,
         'configuration': configuration,
       });

  factory WickModelDashboardConfiguration.fromJson(Map<String, dynamic> json) {
    return WickModelDashboardConfiguration(
      id: WickUtilityTypeConverter.toInt(json['id']) ?? 0,
      userId: WickUtilityTypeConverter.toInt(json['userId']) ?? 0,
      dashboard: WickUtilityTypeConverter.describe(json['dashboard']) ?? '',
      configuration:
          WickUtilityTypeConverter.describe(json['configuration']) ?? '',
    );
  }

  @override
  WickModelDashboardConfiguration newInstance(
    Map<String, dynamic> newAttributes,
  ) => WickModelDashboardConfiguration.fromJson(newAttributes);
}
