// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'quiz.dart';

class QuizModel {
  String type;
  List<QuizAnswerModel>? answers;
  String message;
  String? description;

  QuizModel({
    required this.type,
    this.answers,
    required this.message,
    this.description,
  });

  QuizModel copyWith({
    String? text,
    String? type,
    List<QuizAnswerModel>? answers,
    String? message,
    String? description,
  }) {
    return QuizModel(
      type: type ?? this.type,
      answers: answers ?? this.answers,
      message: message ?? this.message,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'answers': answers?.map((x) => x.toMap()).toList(),
      'message': message,
      'description': description,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      type: map['type'] as String,
      answers: map['answers'] != null
          ? (() {
              var answers = List<QuizAnswerModel>.from(
                (map['answers'] as List<dynamic>).map<QuizAnswerModel?>(
                  (x) => QuizAnswerModel.fromMap(x as Map<String, dynamic>),
                ),
              );
              answers.shuffle();
              return answers;
            }).call()
          : null,
      message: map['message'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizModel(type: $type, answers: $answers, message: $message, description: $description)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        listEquals(other.answers, answers) &&
        other.message == message &&
        other.description == description;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        answers.hashCode ^
        message.hashCode ^
        description.hashCode;
  }
}
