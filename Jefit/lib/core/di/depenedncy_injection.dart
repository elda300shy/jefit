import 'package:get_it/get_it.dart';
import 'package:jefit/core/networking/api_service.dart';
import 'package:jefit/core/networking/dio_factory.dart';
import 'package:jefit/features/Auth/login/data/repos/login_repo.dart';
import 'package:jefit/features/Auth/login/presentation/logic/cubit/login_cubit.dart';
import 'package:jefit/features/Auth/signup/data/repo/signup_repo.dart';
import 'package:jefit/features/Auth/signup/presentation/logic/cubit/signup_cubit.dart';

final getIt = GetIt.instance;

setupDependencyInjection() async {

  /// ApiService Dependency Injection
  final dio = DioFactory.getDio();
  getIt.registerSingleton<ApiService>(ApiService(dio));

  /// Signup Dependency Injection
  getIt.registerSingleton<SignupRepo>(SignupRepo(apiService: getIt()));
  getIt.registerSingleton<SignupCubit>(SignupCubit(getIt()));

  /// Login Dependency Injection
  getIt.registerSingleton<LoginRepo>(LoginRepo(apiService: getIt()));
  getIt.registerSingleton<LoginCubit>(LoginCubit(repo: getIt()));
}
