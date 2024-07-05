import 'package:dio/dio.dart';
import 'package:jefit/core/networking/api_constants.dart';
import 'package:jefit/features/Auth/login/data/models/login_request_body.dart';
import 'package:jefit/features/Auth/login/data/models/login_response_body.dart';
import 'package:jefit/features/Auth/signup/data/models/signup_reposnse_body.dart';
import 'package:jefit/features/Auth/signup/data/models/signup_request_body.dart';

import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // signup new user
  @POST(ApiConstants.signup)
  Future<SignupResponseBody> signup({
    @Body() required SignupRequestBody signupRequestBody,
  });



  /// login user
  @POST(ApiConstants.login)
  Future<LoginResponseBody> login({
    @Body() required LoginRequestBody loginRequestBody,
  });
}
