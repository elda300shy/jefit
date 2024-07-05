import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jefit/config/cache/cache_constants.dart';
import 'package:jefit/config/cache/cache_helper.dart';
import 'package:jefit/core/networking/api_result.dart';
import 'package:jefit/features/Auth/login/data/models/login_request_body.dart';
import 'package:jefit/features/Auth/login/data/models/login_response_body.dart';
import 'package:jefit/features/Auth/login/data/repos/login_repo.dart';
import 'package:jefit/features/Auth/login/presentation/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.repo}) : super(const LoginState.initial());
  final LoginRepo repo;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  login() async {
    emit(const LoginState.loading());
    ApiResult<LoginResponseBody> result = await repo.login(
        loginRequestBody: LoginRequestBody(
            username: usernameController.text,
            password: passwordController.text));
    result.when(success: (data) {
      clearData();
      saveUserToCache(data);
      saveUserLogin();
      emit(const LoginState.success("Login Successful"));
    }, failure: (error) {
      emit(LoginState.error(error.apiErrorModel.message ?? "Error Occurred"));
    });
  }

  clearData() {
    usernameController.clear();
    passwordController.clear();
  }

  saveUserLogin() async {
    await CacheHelper.setData(key: CacheConstants.isUserLoggedIn, value: true);
  }

  saveUserToCache(LoginResponseBody response) async {
    await CacheHelper.setData(
        key: CacheConstants.userCache,
        value: jsonEncode(response.toJson()));
  }
}
