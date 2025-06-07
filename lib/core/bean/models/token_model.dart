// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenModel {

  final String createdAt;
  final String value;
  
  TokenModel({
    required this.createdAt,
    required this.value,
  });

  TokenModel copyWith({
    String? createdAt,
    String? value,
  }) {
    return TokenModel(
      createdAt: createdAt ?? this.createdAt,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'value': value,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      createdAt: map['createdAt'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) => TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TokenModel(createdAt: $createdAt, value: $value)';

  @override
  bool operator ==(covariant TokenModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.createdAt == createdAt &&
      other.value == value;
  }

  @override
  int get hashCode => createdAt.hashCode ^ value.hashCode;
}
