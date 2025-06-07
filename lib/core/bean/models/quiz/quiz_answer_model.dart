// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class QuizAnswerModel {
  
  bool correct;
  String text;

  QuizAnswerModel({
    required this.correct,
    required this.text,
  });

  QuizAnswerModel copyWith({
    bool? correct,
    String? text,
  }) {
    return QuizAnswerModel(
      correct: correct ?? this.correct,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'correct': correct,
      'text': text,
    };
  }

  factory QuizAnswerModel.fromMap(Map<String, dynamic> map) {
    return QuizAnswerModel(
      correct: map['correct'] as bool,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizAnswerModel.fromJson(String source) => QuizAnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuizAnswerModel(correct: $correct, text: $text)';

  @override
  bool operator ==(covariant QuizAnswerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.correct == correct &&
      other.text == text;
  }

  @override
  int get hashCode => correct.hashCode ^ text.hashCode;
}
