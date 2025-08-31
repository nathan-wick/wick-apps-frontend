import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../enumerations/order_direction.dart';
import '../enumerations/request_method.dart';
import '../models/base.dart';
import '../models/paginated_response.dart';
import '../providers/session.dart';
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

  Future<Model> getByPrimaryKey(BuildContext context, int primaryKey) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.get,
      domain,
      '$basePath/$primaryKey',
      sessionToken,
    );

    return fromJson(response);
  }

  Future<PaginatedResponse<Model>> get(
    BuildContext context, [
    int pageNumber = 1,
    int pageSize = 50,
    String? orderBy,
    OrderDirection orderDirection = OrderDirection.descending,
    String? where,
    List<String>? attributes,
  ]) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
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
    final response = await RequestHandler.sendRequest(
      RequestMethod.get,
      domain,
      basePath,
      sessionToken,
      null,
      queryParameters,
    );

    return PaginatedResponse<Model>.fromJson(response, fromJson);
  }

  Future<Model> create(BuildContext context, Model instance) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    final response = await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      basePath,
      sessionToken,
      instance,
    );

    return fromJson(response);
  }

  Future<Model> edit(BuildContext context, Model instance) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    final response = await RequestHandler.sendRequest(
      RequestMethod.put,
      domain,
      basePath,
      sessionToken,
      instance,
    );
    return fromJson(response);
  }

  Future<void> delete(BuildContext context, int primaryKey) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    await RequestHandler.sendRequest(
      RequestMethod.delete,
      domain,
      '$basePath/$primaryKey',
      sessionToken,
    );
  }
}
