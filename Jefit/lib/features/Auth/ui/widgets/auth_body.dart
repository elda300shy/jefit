import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/core/common/widget/app_logo.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/core/utils/spacing.dart';
import 'package:jefit/features/Auth/login/presentation/widgets/login_tab_body.dart';
import 'package:jefit/features/Auth/signup/presentation/widgets/signup_tab_body.dart';
import 'package:jefit/features/Auth/ui/widgets/signup_and_login_tabbar.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(30),
        const AppLogo(size: 180),
        SignupAndLoginTapBar(
          controller: controller,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 20.h),
            alignment: Alignment.bottomCenter,
            constraints: const BoxConstraints.expand(),
            width: context.width,
            decoration: BoxDecoration(
              color: context.theme.primaryColor.withOpacity(0.75),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: controller,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                 const SignupTabBody(),
                      
                      verticalSpace(300),
                    ],
                  ),
                ),
                const LoginTabBody(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
