import '../utilities/type_converter.dart';
import 'base.dart';

class DashboardConfigurationModel extends BaseModel {
  final int id;
  final int userId;
  final String dashboard;
  final String configuration;

  DashboardConfigurationModel({
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

  factory DashboardConfigurationModel.fromJson(Map<String, dynamic> json) {
    return DashboardConfigurationModel(
      id: TypeConverter.toInt(json['id']) ?? 0,
      userId: TypeConverter.toInt(json['userId']) ?? 0,
      dashboard: TypeConverter.describe(json['dashboard']) ?? '',
      configuration: TypeConverter.describe(json['configuration']) ?? '',
    );
  }
}
