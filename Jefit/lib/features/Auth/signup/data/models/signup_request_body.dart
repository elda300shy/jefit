import 'package:json_annotation/json_annotation.dart';
part 'signup_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String username;
  final String password;
  final String confirmPassword;
  final String name;
  final String birthday;

  SignupRequestBody({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.birthday,
  });
  factory SignupRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
