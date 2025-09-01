import 'package:flutter/cupertino.dart';

import '../enums/order_direction.dart';
import '../enums/request_method.dart';
import '../models/base.dart';
import '../models/paginated_response.dart';
import '../utilities/request_handler.dart';
import '../utilities/string_formatter.dart';

abstract class BaseController<Model extends BaseModel> {
  // TODO Get the real domain
  final String domain = 'localhost:3000';
  final String basePath = StringFormatter.toKebabCase(
    Model.toString().replaceAll('Model', ''),
  );
  final Model Function(Map<String, dynamic>) fromJson;

  BaseController(this.fromJson);

  Future<Model?> getByPrimaryKey(BuildContext context, int primaryKey) async {
    final Map<String, dynamic>? response = await RequestHandler.sendRequest(
      context,
      RequestMethod.get,
      domain,
      '$basePath/$primaryKey',
    );
    return response == null ? null : fromJson(response);
  }

  Future<PaginatedResponse<Model>?> get(
    BuildContext context, [
    int pageNumber = 1,
    int pageSize = 50,
    String? orderBy,
    OrderDirection orderDirection = OrderDirection.descending,
    String? where,
    List<String>? attributes,
  ]) async {
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
    final Map<String, dynamic>? response = await RequestHandler.sendRequest(
      context,
      RequestMethod.get,
      domain,
      basePath,
      null,
      queryParameters,
    );
    return response == null
        ? null
        : PaginatedResponse<Model>.fromJson(response, fromJson);
  }

  Future<Model?> create(BuildContext context, Model instance) async {
    final response = await RequestHandler.sendRequest(
      context,
      RequestMethod.post,
      domain,
      basePath,
      instance,
    );
    return response == null ? null : fromJson(response);
  }

  Future<Model?> edit(BuildContext context, Model instance) async {
    final Map<String, dynamic>? response = await RequestHandler.sendRequest(
      context,
      RequestMethod.put,
      domain,
      basePath,
      instance,
    );
    return response == null ? null : fromJson(response);
  }

  Future<bool> delete(BuildContext context, int primaryKey) async {
    final Map<String, dynamic>? response = await RequestHandler.sendRequest(
      context,
      RequestMethod.delete,
      domain,
      '$basePath/$primaryKey',
    );
    return response == null ? false : true;
  }
}
