

import 'package:json_annotation/json_annotation.dart';
part 'login_response_body.g.dart';
@JsonSerializable()
class LoginResponseBody{
  final String? token;
  final UserLoginResponseBody? user;
  LoginResponseBody({  this.token,  this.user});
  factory LoginResponseBody.fromJson(Map<String, dynamic> json) => _$LoginResponseBodyFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
} 

@JsonSerializable()
class UserLoginResponseBody{
 
  final String? id;
  final String? username;
  final String? password;
  final String? name;
  final String? birthday;
  UserLoginResponseBody({
     this.id,
     this.username,
     this.password,
     this.name,
     this.birthday,
  });
 
  factory UserLoginResponseBody.fromJson(Map<String, dynamic> json) => _$UserLoginResponseBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginResponseBodyToJson(this);
}   