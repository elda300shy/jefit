import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jefit/config/cache/cache_constants.dart';
import 'package:jefit/config/cache/cache_helper.dart';
import 'package:jefit/core/di/depenedncy_injection.dart';
import 'package:jefit/features/Auth/login/presentation/logic/cubit/login_cubit.dart';
import 'package:jefit/features/Auth/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:jefit/jefit_app.dart';
import 'package:jefit/features/practice/presentation/widgets/home_screen.dart';


/// The entry point of the application
late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isUserLoggedIn =
      await CacheHelper.getBool(key: CacheConstants.isUserLoggedIn);
  await setupDependencyInjection();
  cameras = await availableCameras();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => getIt<SignupCubit>()),
    BlocProvider(create: (context) => getIt<LoginCubit>()),
  ], child: const JefitApp()));
}

bool isUserLoggedIn = false;
