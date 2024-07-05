
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jefit/core/networking/api_result.dart';
import 'package:jefit/features/Auth/signup/data/models/signup_reposnse_body.dart';
import 'package:jefit/features/Auth/signup/data/models/signup_request_body.dart';
import 'package:jefit/features/Auth/signup/data/repo/signup_repo.dart';
import 'package:jefit/features/Auth/signup/presentation/logic/cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.repo) : super(const SignupState.initial());

  final SignupRepo repo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String birthday = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  emitSignupState() async {
    emit(const SignupState.loading());
    ApiResult<SignupResponseBody> result = await repo.signup(SignupRequestBody(
      username: usernameController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      name: nameController.text,
      birthday: birthday,
    ));
    result.when(success: (message) {
      clearData();
      emit(SignupState.success(message.message));

    }, failure: (error) {
      emit(SignupState.error(error.apiErrorModel.message ?? "Error Occurred"));
    });
  }

  clearData(){
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    birthday = '';
  }
}
