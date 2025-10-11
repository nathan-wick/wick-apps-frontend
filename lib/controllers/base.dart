import 'package:flutter/cupertino.dart';

import '../enums/order_direction.dart';
import '../enums/request_method.dart';
import '../models/base.dart';
import '../models/paginated_response.dart';
import '../utilities/request_handler.dart';
import '../utilities/string_formatter.dart';

abstract class WickControllerBase<Model extends WickModelBase<Model>> {
  // TODO Get the real domain
  final String domain = 'localhost:3000';
  final String basePath = WickUtilityStringFormatter.toKebabCase(
    Model.toString().replaceAll('Wick', '').replaceAll('Model', ''),
  );
  final Model Function(Map<String, dynamic>) fromJson;

  WickControllerBase(this.fromJson);

  Future<Model?> getByPrimaryKey(BuildContext context, int? primaryKey) async {
    if (primaryKey == null || primaryKey <= 0) return null;
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.get,
          domain,
          '$basePath/$primaryKey',
        );
    return response == null ? null : fromJson(response);
  }

  Future<WickModelPaginatedResponse<Model>?> get(
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
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.get,
          domain,
          basePath,
          null,
          queryParameters,
        );
    return response == null
        ? null
        : WickModelPaginatedResponse<Model>.fromJson(response, fromJson);
  }

  Future<Model?> create(BuildContext context, Model instance) async {
    final response = await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.post,
      domain,
      basePath,
      instance,
    );
    return response == null ? null : fromJson(response);
  }

  Future<Model?> edit(BuildContext context, Model instance) async {
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.put,
          domain,
          basePath,
          instance,
        );
    return response == null ? null : fromJson(response);
  }

  Future<bool> delete(BuildContext context, int primaryKey) async {
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.delete,
          domain,
          '$basePath/$primaryKey',
        );
    return response == null ? false : true;
  }
}
