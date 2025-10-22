import 'package:flutter/cupertino.dart';
import 'package:wick_apps/utilities/type_converter.dart';

import '../enums/order_direction.dart';
import '../enums/request_method.dart';
import '../models/paginated_response.dart';
import '../utilities/request_handler.dart';
import '../utilities/string_formatter.dart';

abstract class WickControllerBase<T> {
  // TODO Get the real domain
  final String domain = 'localhost:3000';
  final String basePath = WickUtilityStringFormatter.toKebabCase(
    T.toString().replaceAll('Wick', '').replaceAll('Model', ''),
  );

  Future<T?> getByPrimaryKey(BuildContext context, int? primaryKey) async {
    if (primaryKey == null || primaryKey <= 0) return null;
    final String? response = await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.get,
      domain,
      '$basePath/$primaryKey',
    );
    return WickUtilityTypeConverter.fromJson(response);
  }

  Future<WickModelPaginatedResponse<T>?> get(
    BuildContext context, {
    int pageNumber = 1,
    int pageSize = 50,
    String? orderBy,
    WickEnumOrderDirection orderDirection = WickEnumOrderDirection.ascending,
    String? where,
    List<String>? attributes,
  }) async {
    final queryParameters = <String, String>{
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
      'orderDirection': orderDirection.value,
    };
    if (orderBy != null) queryParameters['orderBy'] = orderBy;
    if (where != null) queryParameters['where'] = Uri.encodeComponent(where);
    if (attributes != null) {
      queryParameters['attributes'] = attributes.join(",");
    }
    final String? response = await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.get,
      domain,
      basePath,
      null,
      queryParameters,
    );
    return WickUtilityTypeConverter.fromJson(response);
  }

  Future<T?> create(BuildContext context, T instance) async {
    final response = await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.post,
      domain,
      basePath,
      instance,
    );
    return WickUtilityTypeConverter.fromJson(response);
  }

  Future<T?> edit(BuildContext context, T instance) async {
    final String? response = await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.put,
      domain,
      basePath,
      instance,
    );
    return WickUtilityTypeConverter.fromJson(response);
  }

  Future<bool> delete(BuildContext context, int primaryKey) async {
    final String? response = await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.delete,
      domain,
      '$basePath/$primaryKey',
    );
    return response == null ? false : true;
  }
}
