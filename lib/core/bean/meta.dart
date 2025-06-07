// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class Meta {
  final int code;
  final String statusMessage;
  String? message;
  

  Meta({
    required this.code,
    required this.statusMessage,
    this.message
  });

  static Meta parseMeta({required Response<dynamic> response}) =>
      Meta(code: response.statusCode!, statusMessage: response.statusMessage!);
}
