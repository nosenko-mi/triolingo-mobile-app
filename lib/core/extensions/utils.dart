import '../bean/bean.dart';
import 'extensions.dart';
import 'dart:convert';

bool isSuccessMeta({required Meta meta}) => successResponseRange.containsElement(meta.code);

String toJson(Object object) => json.encode(object);
T fromJson<T>(String jsonString) => json.decode(jsonString);