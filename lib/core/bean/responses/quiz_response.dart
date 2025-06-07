// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../bean.dart';

class QuizResponse extends BaseResponse {
  
  int id;
  String? source;
  String? fragment;
  String? error;
  String message;
  List<QuizModel> quizzes;

  factory QuizResponse.fromResponse({required Response response, required Meta meta}){
    Map<String, dynamic> json = response.data as Map<String, dynamic>;
    QuizResponse quizResponse = QuizResponse.fromMap(json);
    quizResponse.body = json;
    quizResponse.meta = meta;
    return quizResponse;
  }

  QuizResponse({
    required this.id,
    this.source,
    this.fragment,
    this.error,
    required this.message,
    required this.quizzes,
  });

  QuizResponse copyWith({
    int? id,
    String? source,
    String? fragment,
    String? error,
    String? message,
    List<QuizModel>? quizzes,
  }) {
    return QuizResponse(
      id: id ?? this.id,
      source: source ?? this.source,
      fragment: fragment ?? this.fragment,
      error: error ?? this.error,
      message: message ?? this.message,
      quizzes: quizzes ?? this.quizzes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'source': source,
      'fragment': fragment,
      'error': error,
      'message': message,
      'quizzes': quizzes.map((x) => x.toMap()).toList(),
    };
  }

  factory QuizResponse.fromMap(Map<String, dynamic> map) {
    return QuizResponse(
      id: map['id'] as int,
      source: map['source'] != null ? map['source'] as String : null,
      fragment: map['fragment'] != null ? map['fragment'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] as String,
      quizzes: List<QuizModel>.from((map['quizzes'] as List<dynamic>).map<QuizModel>((x) => QuizModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizResponse.fromJson(String source) => QuizResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizResponse(id: $id, source: $source, fragment: $fragment, error: $error, message: $message, quizzes: $quizzes)';
  }

  @override
  bool operator ==(covariant QuizResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.source == source &&
      other.fragment == fragment &&
      other.error == error &&
      other.message == message &&
      listEquals(other.quizzes, quizzes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      source.hashCode ^
      fragment.hashCode ^
      error.hashCode ^
      message.hashCode ^
      quizzes.hashCode;
  }
}
