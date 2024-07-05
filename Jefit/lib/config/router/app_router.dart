import 'package:flutter/material.dart';
import 'package:jefit/config/router/routes.dart';
import 'package:jefit/features/Auth/ui/views/auth_view.dart';
import 'package:jefit/features/home/home_view.dart';
import 'package:jefit/features/practice/presentation/views/lower_body_view.dart';

import 'package:jefit/features/profile/presentation/views/profile_view.dart';

class AppRouter {
  AppRouter._();
  static final AppRouter instance = AppRouter._();
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.auth:
        return MaterialPageRoute(
          builder: (context) => const AuthView(),
        );
      case Routes.homeView:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );

      case Routes.lowerBodyView:
        return MaterialPageRoute(
          builder: (context) => const LowerBodyView(),
        );
      case Routes.upperBodyView:
        return MaterialPageRoute(
          builder: (context) => const LowerBodyView(),
        );
      case Routes.profileView:
        return MaterialPageRoute(
          builder: (context) => const ProfileView(),
        );  
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
