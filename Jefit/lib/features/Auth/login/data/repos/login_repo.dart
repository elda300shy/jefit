import 'package:jefit/core/networking/api_error_handler.dart';
import 'package:jefit/core/networking/api_result.dart';
import 'package:jefit/core/networking/api_service.dart';
import 'package:jefit/features/Auth/login/data/models/login_request_body.dart';
import 'package:jefit/features/Auth/login/data/models/login_response_body.dart';

class LoginRepo {
  final ApiService apiService;

  LoginRepo({required this.apiService});

  Future<ApiResult<LoginResponseBody>> login(
      {required LoginRequestBody loginRequestBody}) async {
    try {
      LoginResponseBody response =
          await apiService.login(loginRequestBody: loginRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
