// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:dio/dio.dart';
import '../bean.dart';

class RegistrationResponse extends BaseResponse {

  final UserModel user;
  final TokenModel token;

  factory RegistrationResponse.fromResponse({required Response response, required Meta meta}){
    Map<String, dynamic> json = response.data as Map<String, dynamic>;
    RegistrationResponse registrationResponse = RegistrationResponse.fromMap(json);
    registrationResponse.body = json;
    registrationResponse.meta = meta;
    return registrationResponse;
  }

  RegistrationResponse({
    required this.user,
    required this.token,
  });

  int code() {
    return meta?.code ?? 400;
  }
  

  RegistrationResponse copyWith({
    UserModel? user,
    TokenModel? token,
  }) {
    return RegistrationResponse(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token.toMap(),
    };
  }

  factory RegistrationResponse.fromMap(Map<String, dynamic> map) {
    return RegistrationResponse(
      user: UserModel.fromMap(map['user'] as Map<String,dynamic>),
      token: TokenModel.fromMap(map['token'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationResponse.fromJson(String source) => RegistrationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RegistrationResponse(user: $user, token: $token)';

  @override
  bool operator ==(covariant RegistrationResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.user == user &&
      other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
