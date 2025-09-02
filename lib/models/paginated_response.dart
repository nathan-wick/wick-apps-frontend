import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelPaginatedResponse<Model extends WickModelBase>
    extends WickModelBase {
  final List<Model> instances;
  final int totalInstances;

  WickModelPaginatedResponse({
    required this.instances,
    required this.totalInstances,
  }) : super({'instances': instances, 'totalInstances': totalInstances});

  factory WickModelPaginatedResponse.fromJson(
    Map<String, dynamic> json,
    Model Function(Map<String, dynamic>) fromJson,
  ) {
    return WickModelPaginatedResponse(
      instances:
          // TODO Add a method to WickUtilityTypeConverter for toList
          json['instances']
              .map((instance) => fromJson(instance as Map<String, dynamic>))
              .toList(),
      totalInstances:
          WickUtilityTypeConverter.toInt(json['totalInstances']) ?? 0,
    );
  }
}
