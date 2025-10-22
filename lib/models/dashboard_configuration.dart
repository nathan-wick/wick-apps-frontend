import 'annotations/primary_key.dart';

class WickModelDashboardConfiguration {
  @WickModelAnnotationPrimaryKey()
  final int id;
  final int userId;
  final String dashboard;
  final String configuration;

  WickModelDashboardConfiguration({
    required this.id,
    required this.userId,
    required this.dashboard,
    required this.configuration,
  });
}
