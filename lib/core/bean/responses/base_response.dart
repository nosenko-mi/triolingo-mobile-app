// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../bean.dart';

class BaseResponse {

  Map<String, dynamic>? body;
  Meta? meta;

  BaseResponse({
    this.body,
    this.meta,
  });

  
}
