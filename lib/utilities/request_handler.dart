import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../enumerations/request_method.dart';
import '../enumerations/response_status.dart';
import '../models/base.dart';

class RequestHandler {
  /// Sends a network request.
  static Future<Map<String, dynamic>> sendRequest(
    RequestMethod method,
    String domain,
    String path, [
    String sessionToken = '',
    Object? body,
    Map<String, String>? queryParameters,
  ]) async {
    const String unexpectedErrorMessage = 'An unexpected error occurred.';
    final String urlString =
        queryParameters == null
            ? 'http://$domain/$path'
            : 'http://$domain/$path?${Uri(queryParameters: queryParameters).query}';
    final Uri url = Uri.parse(urlString);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Session-Token': sessionToken,
    };
    final jsonBody = body is BaseModel ? body.toJson() : jsonEncode(body);
    Response response;

    try {
      switch (method) {
        case RequestMethod.post:
          response = await post(url, headers: headers, body: jsonBody);
          break;
        case RequestMethod.put:
          response = await put(url, headers: headers, body: jsonBody);
          break;
        case RequestMethod.get:
          response = await get(url, headers: headers);
          break;
        case RequestMethod.delete:
          response = await delete(url, headers: headers, body: jsonBody);
          break;
      }
    } on SocketException {
      throw 'Cannot connect to the internet. Please check your connection.';
    } on HttpException {
      throw 'Cannot reach the app service right now. Please try again later.';
    } on TimeoutException {
      throw 'The app service is taking too long to respond. Please try again later.';
    } on TlsException {
      throw 'Cannot create a secure connection. Please check your device settings.';
    } catch (e) {
      throw unexpectedErrorMessage;
    }

    final ResponseStatus status = ResponseStatus.fromCode(response.statusCode);
    Map<String, dynamic> responseBody;

    try {
      responseBody = jsonDecode(response.body);
    } catch (error) {
      responseBody = {};
    }

    if (status == ResponseStatus.okay) {
      return responseBody;
    } else {
      throw responseBody['message'] ?? unexpectedErrorMessage;
    }
  }
}
