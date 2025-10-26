import 'package:flutter/cupertino.dart';

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
    return await WickUtilityRequestHandler.sendRequest<T>(
      context,
      WickEnumRequestMethod.get,
      domain,
      '$basePath/$primaryKey',
    );
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
    return await WickUtilityRequestHandler.sendRequest<
      WickModelPaginatedResponse<T>
    >(
      context,
      WickEnumRequestMethod.get,
      domain,
      basePath,
      null,
      queryParameters,
    );
  }

  Future<T?> create(BuildContext context, T instance) async {
    return await WickUtilityRequestHandler.sendRequest<T>(
      context,
      WickEnumRequestMethod.post,
      domain,
      basePath,
      instance,
    );
  }

  Future<T?> edit(BuildContext context, T instance) async {
    return await WickUtilityRequestHandler.sendRequest<T>(
      context,
      WickEnumRequestMethod.put,
      domain,
      basePath,
      instance,
    );
  }

  Future<bool> delete(BuildContext context, int primaryKey) async {
    return await WickUtilityRequestHandler.sendRequest<bool>(
          context,
          WickEnumRequestMethod.delete,
          domain,
          '$basePath/$primaryKey',
        ) ??
        false;
  }
}
