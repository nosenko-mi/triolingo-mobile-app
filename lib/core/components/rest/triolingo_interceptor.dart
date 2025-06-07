import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:triolingo/core/core.dart';


class TriolingoInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
        '${options.method} => ${options.uri} \n Extras: ${options.extra} \n Headers: ${options.headers} \n Query: ${options.queryParameters} \n Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        '${response.statusCode} - ${response.statusMessage} ${response.requestOptions.uri}: ${toJson(response.data)}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode ?? 'Unknown Status Code'}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
  
}