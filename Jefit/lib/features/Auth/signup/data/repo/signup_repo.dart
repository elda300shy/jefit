import 'package:jefit/core/networking/api_error_handler.dart';
import 'package:jefit/core/networking/api_result.dart';
import 'package:jefit/core/networking/api_service.dart';
import 'package:jefit/features/Auth/signup/data/models/signup_reposnse_body.dart';
import 'package:jefit/features/Auth/signup/data/models/signup_request_body.dart';

class SignupRepo {
  final ApiService _apiService;

  SignupRepo({required ApiService apiService}) : _apiService = apiService;

  Future<ApiResult<SignupResponseBody>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      final response =
          await _apiService.signup(signupRequestBody: signupRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
