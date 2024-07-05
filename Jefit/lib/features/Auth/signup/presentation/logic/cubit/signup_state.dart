import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';
@freezed
class SignupState with _$SignupState {
  const factory SignupState.initial() = _Initial;
  const factory SignupState.loading() = _Loading;
  const factory SignupState.success(String message) = _Success;
  const factory SignupState.error(String message) = _Error;
  
}
