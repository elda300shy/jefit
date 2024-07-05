import 'package:flutter/material.dart';
import 'package:jefit/core/styles/app_text_styles.dart';

class SignupAndLoginTapBar extends StatelessWidget {
  const SignupAndLoginTapBar({super.key, required this.controller});
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerHeight: 0,
      controller: controller,
      tabs: [
        Tab(
          child: Text(
            'Sign Up',
            style: AppTextStyles.designer18MediumOnPrimary(context),
          ),
        ),
        Text(
          'Login',
          style: AppTextStyles.designer18MediumOnPrimary(context),
        ),
      ],
    );
  }
}