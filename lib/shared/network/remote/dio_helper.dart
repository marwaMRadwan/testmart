import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/constants.dart';

class DioHelper {
  static late Dio _dio;
  static Map<String, dynamic> headers = {
    'Connection': 'keep-alive',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

  static init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
        // connectTimeout: 30000,
        // sendTimeout: 30000,
        // receiveTimeout: 30000,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    removeToken = false,
  }) async {
    if (removeToken) {
      _dio.options.headers = null;
    } else {
      _dio.options.headers = headers
        ..addAll(
          {'Authorization': accessToken},
        );
    }
    print('removing: $removeToken');
    debugPrint('headers: ${_dio.options.headers}');
    debugPrint('url: ${_dio.options.baseUrl + url}');

    return await _dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    removeToken = false,
    required data,
  }) async {
    if (removeToken) {
      _dio.options.headers = null;
    } else {
      _dio.options.headers = headers
        ..addAll(
          {'Authorization': accessToken},
        );
    }
    debugPrint('headers: ${_dio.options.headers}');
    debugPrint('url: ${_dio.options.baseUrl + url}');
    debugPrint('request data: $data');
    final response = await _dio.post(
      url,
      queryParameters: query,
      data: data,
    );
    return response;
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String token = '',
  }) async {
    _dio.options.headers = headers
      ..addAll(
        {'lang': lang, 'Authorization': token},
      );

    final response = await _dio.put(
      url,
      queryParameters: query,
      data: data,
    );
    return response;
  }
}
