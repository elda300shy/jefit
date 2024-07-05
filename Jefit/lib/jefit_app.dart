import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/config/router/app_router.dart';
import 'package:jefit/config/router/routes.dart';
import 'package:jefit/config/theme/dark_theme_manager.dart';
import 'package:jefit/main.dart';

class JefitApp extends StatelessWidget {
  const JefitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: DarkThemeManager.darkTheme,
          initialRoute: isUserLoggedIn ? Routes.homeView : Routes.auth,
          onGenerateRoute: AppRouter.instance.onGenerateRoute,
        );
      },
    );
  }
}
