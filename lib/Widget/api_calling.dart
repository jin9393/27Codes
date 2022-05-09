import 'dart:async';
import 'dart:convert';
import 'package:code_27/Utils/constants.dart';

import 'api_result.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall {

  // final String baseUrl = "https://27code.madxpanel.com/api/v1/client";
  final String baseUrl = "https://developing27code.madxpanel.com/api/v1/client";
  final Dio _dio = Dio();
  late SharedPreferences prefs;

  Future<RestApiResult> get({
    required String method,
    String token = '',
    // String token = '32NcrJEk25jxLELHtIMhfZ3esWIf4KEIevqTDepVLfYCRrG7tIhfmh9pWiWzBhgx6nvIVNGj7St8PJJP',
    Map<String, String> arg = const {},
    Map<String, String> header = const {},
  }) async {
    return _call(method: method, token: token, arg: arg,header: header, getOrPost: 'get');
  }

  Future<RestApiResult> post({
    required String method,
    String token = '',
    Map<String, String> arg = const {},
    Map<String, String> header = const {},
  }) async {
    return _call(method: method, token: token, arg: arg, getOrPost: 'post',header: header);
  }

  Future<RestApiResult> _call({
    required String method,
    String token = '',
    Map<String, String> arg = const {},
    Map<String, String> header = const {},
    required String getOrPost,
  }) async {
    // final prefs = await SharedPreferences.getInstance();

    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.PREF_TOKEN) ?? '';
    header['appkey'] = 'fUPvZAmZnIArSZl9TauXbtVyTJHEaik6gju4qWDU';
    header['Accept'] = 'application/json';
    // header['Authorization'] = 'Bearer $token';
    String url = "$baseUrl/$method";
    // String url = "$baseUrl";
    print(arg);
    print(header);
    print(url);
    // arg['app_id'] = ApiConfig.apiId;
    // arg['token'] = token;
    // arg['version'] = version;
    // arg['device'] = Platform.isAndroid ? 'android' : 'ios';
    // arg['lang'] = lang;
    // arg['sign'] = _sign(method, arg);

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      Response response;
      if (getOrPost.toLowerCase() == 'post') {
        response = await _dio.post(url, data: FormData.fromMap(arg),options: Options(headers: header));
      } else {
        response = await _dio.get(url, queryParameters: arg,options: Options(headers: header));
      }
      return _handleResponse(new Map<String, dynamic>.from(response.data));
    } catch (error) {
      return _handleError(error);
    }
  }

  RestApiResult _handleResponse(Map<String, dynamic> map) {
    if (map['status'] == false) {
      return RestApiResult(
        status: false,
        code: map['code'],
        message: map['message'],
      );
    }
    return RestApiResult(status: true,code: map['code'], data: map['data'], message: map['message']);
  }

  RestApiResult _handleError(error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          return RestApiResult(
            status: false,
            message: 'Cancel',
          );
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          return RestApiResult(
            status: false,
            message: 'Connection Timeout',
          );
        case DioErrorType.other:
          return RestApiResult(
            status: false,
            message: 'On Internet',
          );
        case DioErrorType.response:
          return RestApiResult(
            status: false,
            code: error.response!.statusCode,
            message: 'Invalid code',
          );
      }
    }
    return RestApiResult(
      status: false,
        message: 'Unknown error',
    );
  }

}
