import '../utilities/type_converter.dart';
import 'base.dart';

class PaginatedResponse<Model extends BaseModel> extends BaseModel {
  final List<Model> instances;
  final int totalInstances;

  PaginatedResponse({required this.instances, required this.totalInstances})
    : super({'instances': instances, 'totalInstances': totalInstances});

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    Model Function(Map<String, dynamic>) fromJson,
  ) {
    return PaginatedResponse(
      instances:
          // TODO Add a method to TypeConverter for toList
          json['instances']
              .map((instance) => fromJson(instance as Map<String, dynamic>))
              .toList(),
      totalInstances: TypeConverter.toInt(json['totalInstances']) ?? 0,
    );
  }
}
