// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseBody _$LoginResponseBodyFromJson(Map<String, dynamic> json) =>
    LoginResponseBody(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : UserLoginResponseBody.fromJson(
              json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseBodyToJson(LoginResponseBody instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

UserLoginResponseBody _$UserLoginResponseBodyFromJson(
        Map<String, dynamic> json) =>
    UserLoginResponseBody(
      id: json['id'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      birthday: json['birthday'] as String?,
    );

Map<String, dynamic> _$UserLoginResponseBodyToJson(
        UserLoginResponseBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'birthday': instance.birthday,
    };
