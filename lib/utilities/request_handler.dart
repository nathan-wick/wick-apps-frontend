import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../enums/notification_type.dart';
import '../enums/request_method.dart';
import '../enums/response_status.dart';
import '../models/base.dart';
import '../providers/session.dart';
import 'notification_handler.dart';

class WickUtilityRequestHandler {
  /// Sends a network request.
  static Future<Map<String, dynamic>?> sendRequest(
    BuildContext context,
    WickEnumRequestMethod method,
    String domain,
    String path, [
    Object? body,
    Map<String, String>? queryParameters,
  ]) async {
    final String urlString =
        queryParameters == null
            ? 'http://$domain/$path'
            : 'http://$domain/$path?${Uri(queryParameters: queryParameters).query}';
    final Uri url = Uri.parse(urlString);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Session-Token':
          (await Provider.of<WickProviderSession>(
                context,
                listen: false,
              ).getValue())
              ?.token ??
          '',
    };
    final jsonBody = body is WickModelBase ? body.toJson() : jsonEncode(body);
    Response response;
    try {
      switch (method) {
        case WickEnumRequestMethod.post:
          response = await post(url, headers: headers, body: jsonBody);
          break;
        case WickEnumRequestMethod.put:
          response = await put(url, headers: headers, body: jsonBody);
          break;
        case WickEnumRequestMethod.get:
          response = await get(url, headers: headers);
          break;
        case WickEnumRequestMethod.delete:
          response = await delete(url, headers: headers, body: jsonBody);
          break;
      }
    } on SocketException {
      handleErrorResponse(
        context,
        'Cannot connect to the internet. Please check your connection.',
      );
      return null;
    } on HttpException {
      handleErrorResponse(
        context,
        'Cannot reach the app service right now. Please try again later.',
      );
      return null;
    } on TimeoutException {
      handleErrorResponse(
        context,
        'The app service is taking too long to respond. Please try again later.',
      );
      return null;
    } on TlsException {
      handleErrorResponse(
        context,
        'Cannot create a secure connection. Please check your device settings.',
      );
      return null;
    } catch (error) {
      handleErrorResponse(context);
      return null;
    }
    final WickEnumResponseStatus status = WickEnumResponseStatus.fromCode(
      response.statusCode,
    );
    Map<String, dynamic> responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (error) {
      responseBody = {};
    }
    if (status == WickEnumResponseStatus.okay) {
      return responseBody;
    } else {
      handleErrorResponse(context, responseBody['message']);
      return null;
    }
  }

  /// Handles an error response.
  static void handleErrorResponse(
    BuildContext context, [
    String message = 'An unexpected error occurred.',
  ]) {
    WickUtilityNotificationHandler.displayNotification(
      context,
      WickEnumNotificationType.error,
      message,
    );
  }
}
