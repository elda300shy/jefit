
import 'package:dio/dio.dart';
import 'package:jefit/core/networking/api_error_model.dart';

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,

  defaultError
}

class ErrorCodes {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;

  static const int apiLogicError = 422;
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ErrorMessages {
  static const String noContent = ApiErrorsMessages.noContent;
  static const String badRequest = ApiErrorsMessages.badRequestError;
  static const String unauthorized = ApiErrorsMessages.unauthorizedError;
  static const String forbidden = ApiErrorsMessages.forbiddenError;
  static const String notFound = ApiErrorsMessages.notFoundError;

  static const String internalServerError =
      ApiErrorsMessages.internalServerError;
  static const String connectTimeout = ApiErrorsMessages.timeoutError;
  static const String cancel = ApiErrorsMessages.defaultError;
  static const String receiveTimeout = ApiErrorsMessages.timeoutError;
  static const String sendTimeout = ApiErrorsMessages.timeoutError;
  static const String cacheError = ApiErrorsMessages.cacheError;
  static const String noInternetConnection = ApiErrorsMessages.noInternetError;
  static const String defaultError = ApiErrorsMessages.defaultError;
}

class ApiErrorsMessages {
  static const String badRequestError = "The request was invalid.";
  static const String noContent = "No content available.";
  static const String forbiddenError =
      "You do not have permission to access this resource.";
  static const String unauthorizedError =
      "You are not authorized to access this resource.";
  static const String notFoundError = "The requested resource was not found.";
  static const String conflictError = "There is a conflict with your request.";
  static const String internalServerError =
      "An internal server error occurred.";
  static const String unknownError = "An unknown error occurred.";
  static const String timeoutError = "The request timed out. Please try again.";

  static const String cacheError = "There was an error accessing the cache.";
  static const String noInternetError =
      "No internet connection. Please check your connection.";
  static const String loadingMessage = "Loading, please wait...";
  static const String retryAgainMessage =
      "Something went wrong. Please try again.";
  static const String defaultError = "An error occurred. Please try again.";
  static const String ok = "Ok";
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    return ApiErrorModel(
      code: _errorCodeMap[this] ?? ErrorCodes.defaultError,
      message: _errorMessageMap[this] ?? ErrorMessages.defaultError,
    );
  }
}

final Map<DataSource, int> _errorCodeMap = {
  DataSource.noContent: ErrorCodes.noContent,
  DataSource.badRequest: ErrorCodes.badRequest,
  DataSource.unauthorized: ErrorCodes.unauthorized,
  DataSource.forbidden: ErrorCodes.forbidden,
  DataSource.notFound: ErrorCodes.notFound,
  DataSource.internalServerError: ErrorCodes.internalServerError,
  DataSource.connectTimeout: ErrorCodes.connectTimeout,
  DataSource.cancel: ErrorCodes.cancel,
  DataSource.receiveTimeout: ErrorCodes.receiveTimeout,
  DataSource.sendTimeout: ErrorCodes.sendTimeout,
  DataSource.cacheError: ErrorCodes.cacheError,
  DataSource.noInternetConnection: ErrorCodes.noInternetConnection,
  DataSource.defaultError: ErrorCodes.defaultError,
};

final Map<DataSource, String> _errorMessageMap = {
  DataSource.noContent: ErrorMessages.noContent,
  DataSource.badRequest: ErrorMessages.badRequest,
  DataSource.unauthorized: ErrorMessages.unauthorized,
  DataSource.forbidden: ErrorMessages.forbidden,
  DataSource.notFound: ErrorMessages.notFound,
  DataSource.internalServerError: ErrorMessages.internalServerError,
  DataSource.connectTimeout: ErrorMessages.connectTimeout,
  DataSource.cancel: ErrorMessages.cancel,
  DataSource.receiveTimeout: ErrorMessages.receiveTimeout,
  DataSource.sendTimeout: ErrorMessages.sendTimeout,
  DataSource.cacheError: ErrorMessages.cacheError,
  DataSource.noInternetConnection: ErrorMessages.noInternetConnection,
  DataSource.defaultError: ErrorMessages.defaultError,
};

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleDioError(error);
    } else {
      apiErrorModel = DataSource.defaultError.getFailure();
    }
  }
}

ApiErrorModel _handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();

    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      if (error.response != null && error.response?.statusCode != null) {
        return ApiErrorModel.fromJson(error.response!.data);
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badCertificate:
    default:
      return DataSource.defaultError.getFailure();
  }
}
