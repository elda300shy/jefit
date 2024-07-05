import 'package:flutter/material.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/core/utils/app_assets.dart';
import 'package:jefit/features/Auth/ui/widgets/auth_body.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
         resizeToAvoidBottomInset: false,
        body: Container(
          height: context.height,
          width: context.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppAssets.gradient,
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
          ),
          child: const AuthBody(),
        ),
      ),
    );
  }
}
