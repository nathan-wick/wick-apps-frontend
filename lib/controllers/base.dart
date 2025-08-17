import '../enumerations/order_direction.dart';
import '../enumerations/request_method.dart';
import '../models/base.dart';
import '../models/paginated_response.dart';
import '../utilities/request_handler.dart';

abstract class BaseController<Model extends BaseModel> {
  // TODO Get the real domain
  final String domain = 'localhost:3000';
  final String basePath =
      Model.toString().replaceAll('Model', '').toLowerCase();
  final Model Function(Map<String, dynamic>) fromJson;

  BaseController(this.fromJson);

  Future<Model> getByPrimaryKey(int primaryKey) async {
    // TODO Pass in session token
    final sessionToken = '';
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.get,
      domain,
      '$basePath/$primaryKey',
      sessionToken,
    );

    return fromJson(response);
  }

  Future<PaginatedResponse<Model>> get([
    int pageNumber = 1,
    int pageSize = 50,
    String? orderBy,
    OrderDirection orderDirection = OrderDirection.descending,
    String? where,
    List<String>? attributes,
  ]) async {
    // TODO Pass in session token
    final sessionToken = '';
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

  Future<Model> create(Model instance) async {
    // TODO Pass in session token
    final sessionToken = '';
    final response = await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      basePath,
      sessionToken,
      instance,
    );

    return fromJson(response);
  }

  Future<Model> edit(Model instance) async {
    // TODO Pass in session token
    final sessionToken = '';
    final response = await RequestHandler.sendRequest(
      RequestMethod.put,
      domain,
      basePath,
      sessionToken,
      instance,
    );
    return fromJson(response);
  }

  Future<void> delete(int primaryKey) async {
    // TODO Pass in session token
    final sessionToken = '';
    await RequestHandler.sendRequest(
      RequestMethod.delete,
      domain,
      '$basePath/$primaryKey',
      sessionToken,
    );
  }
}
