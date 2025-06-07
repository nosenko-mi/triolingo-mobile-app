// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:dio/dio.dart';
import '../bean.dart';

class LoginResponse extends BaseResponse {

  final UserModel user;
  final TokenModel token;

  factory LoginResponse.fromResponse({required Response response, required Meta meta}){
    Map<String, dynamic> json = response.data as Map<String, dynamic>;
    LoginResponse loginResponse = LoginResponse.fromMap(json);
    loginResponse.body = json;
    loginResponse.meta = meta;
    return loginResponse;
  }
  
  LoginResponse({
    required this.user,
    required this.token,
  });

  int code() {
    return meta?.code ?? 400;
  }

  LoginResponse copyWith({
    UserModel? user,
    TokenModel? token,
  }) {
    return LoginResponse(
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

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      user: UserModel.fromMap(map['user'] as Map<String,dynamic>),
      token: TokenModel.fromMap(map['token'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponse(user: $user, token: $token)';

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.user == user &&
      other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
