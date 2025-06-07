// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class RegistartionRequest {

  final String email;
  final String password;
  
  RegistartionRequest({
    required this.email,
    required this.password,
  });

  RegistartionRequest copyWith({
    String? email,
    String? password,
  }) {
    return RegistartionRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory RegistartionRequest.fromMap(Map<String, dynamic> map) {
    return RegistartionRequest(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistartionRequest.fromJson(String source) => RegistartionRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RegistartionRequest(email: $email, password: $password)';

  @override
  bool operator ==(covariant RegistartionRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
