import 'package:freezed_annotation/freezed_annotation.dart';
part 'signup_reposnse_body.g.dart';

@JsonSerializable()
class SignupResponseBody {
  final String message;
  SignupResponseBody({
    required this.message,
  });
  factory SignupResponseBody.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SignupResponseBodyToJson(this);
}
