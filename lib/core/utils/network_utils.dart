import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:famapp/core/utils/dot_env_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../features/settings/viewmodel/user_viewmodel.dart';
import '../exceptions/inno_api_exception.dart';
import '../services/jwt_service.dart';
import 'debug_utils.dart';
import 'snack_bar_manager.dart';
import 'unit_utils.dart';

class NetworkManager {
  static final Map<String, Map<String, dynamic>> _accessTokenContentCache = <String, Map<String, dynamic>>{};

  static Future<Map<String, String>> getDefaultHeaders(Map<String, String> additionalHeaders) async {
    var headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptLanguageHeader: Platform.localeName,
    };

    final currentUser = UserViewmodel().currentUser;
    final accessToken = currentUser.getAccessToken();
    if (accessToken.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
      if (!_accessTokenContentCache.containsKey(accessToken)) {
        _accessTokenContentCache[accessToken] = JwtService.parseJwt(accessToken);
      }
      final accessTokenContent = _accessTokenContentCache[accessToken] ?? {};
      final exp = '${accessTokenContent['exp'] ?? 0}';
      final expTime = DateTime.fromMillisecondsSinceEpoch(int.parse(exp) * 1000);
      if (expTime.compareTo(DateTime.now()) < 0) {
        // Access Token expired, passing refresh token
        final refreshToken = currentUser.getRefreshToken();
        if (refreshToken.isNotEmpty) {
          headers['refresh-token'] = refreshToken;
        }
      }
    }
    headers.addAll(additionalHeaders);
    return headers;
  }

  static Map<String, dynamic> _processResponse(String url, http.Response response) {
    final logResponses = DotEnvField.LOG_NETWORK_RESPONSES.getDotEnvBool(false);
    if (logResponses) {
      DebugManager.rest("Response ${UnitUtils.formatByteLength(response.contentLength ?? 0)} of $url");
      DebugManager.rest(response.body);
    }
    if (response.statusCode != 200) {
      if (logResponses || true) {
        DebugManager.rest(
            "Request error: ${response.request?.url.toString()}, stats code = ${response.statusCode.toString()}");
        DebugManager.rest(
          response.body
        );
      }
      SnackBarManager.displayMessage('System error ${response.statusCode}');
      throw InnoApiException(url, '${response.statusCode} Error');
    }
    final res = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    if (!res['success']) {
      if (res['errorMessage'] != null) {
        SnackBarManager.displayMessage(res['errorMessage'].toString());
        if (kDebugMode) {
          // For debug purposes only:
          throw InnoApiException(url, res['errorMessage'].toString());
        }
      } else {
        throw InnoApiException(url, 'bodyBytes decode error');
      }
    }

    // Logging
    if (logResponses) {
      DebugManager.rest("Request success: ${response.request?.url.toString()}");
    }

    // Snackbar Message
    var snackBarMessage = res['snackBarMessage'] ?? '';
    if (snackBarMessage != null && snackBarMessage.isNotEmpty) {
      SnackBarManager.displayMessage(snackBarMessage);
    }

    // Token update
    var refreshToken = '${res['data']['refreshToken'] ?? ''}';
    var accessToken = '${res['data']['accessToken'] ?? ''}';
    if (refreshToken.isNotEmpty) {
      UserViewmodel().currentUser.setRefreshToken(refreshToken);
    }
    if (accessToken.isNotEmpty) {
      UserViewmodel().currentUser.setAccessToken(accessToken);
    }
    return res;
  }

  static Future<Map<String, dynamic>> postRequestSync(
    String url, {
    Map<String, dynamic> dataLoad = const {},
    Map<String, String> headers = const {},
    int retryCount = 0,
  }) async {
    final logResponses = DotEnvField.LOG_NETWORK_RESPONSES.getDotEnvBool(false);
    final completeHeaders = await getDefaultHeaders(headers);
    try {
      if (logResponses) {
        DebugManager.rest("Post request: $url");
        DebugManager.rest(dataLoad);
        DebugManager.rest(completeHeaders);
      }
      var res = await http
          .post(Uri.parse(url), headers: completeHeaders, body: jsonEncode(dataLoad))
          .timeout(const Duration(seconds: 10));

      return _processResponse(url, res);
    } on TimeoutException {
      // Automatic retry for two times before giving up
      if (retryCount < 2) {
        SnackBarManager.displayMessage("Request timed out, retrying...");
        postRequestSync(url, dataLoad: dataLoad, headers: headers);
      } else {
        SnackBarManager.displayMessage("Request timed out, please check your network connection");
      }
    }
    return {};
  }

  static Future<Map<String, dynamic>> getRequestSync(
    String url, {
    Map<String, String> headers = const {},
    int retryCount = 0,
  }) async {
    final logResponses = DotEnvField.LOG_NETWORK_RESPONSES.getDotEnvBool(false);
    final completeHeaders = await getDefaultHeaders(headers);
    try {
      if (logResponses) {
        DebugManager.rest("Get request: $url");
        DebugManager.rest(completeHeaders);
      }
      var res = await http.get(Uri.parse(url), headers: completeHeaders).timeout(const Duration(seconds: 10));

      return _processResponse(url, res);
    } on TimeoutException {
      // Automatic retry for two times before giving up
      if (retryCount < 2) {
        SnackBarManager.displayMessage("Request timed out, retrying...");
        getRequestSync(url, headers: headers);
      } else {
        SnackBarManager.displayMessage("Request timed out, please check your network connection");
      }
    }
    return {};
  }
}
