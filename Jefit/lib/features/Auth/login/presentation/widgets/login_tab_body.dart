import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/core/common/widget/app_text_form_field.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/core/utils/spacing.dart';
import 'package:jefit/features/Auth/login/presentation/logic/cubit/login_cubit.dart';
import 'package:jefit/features/Auth/login/presentation/widgets/login_bloc_listener.dart';

class LoginTabBody extends StatelessWidget {
  const LoginTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Form(
        key: context.read<LoginCubit>().formKey,
        child: Column(
          children: [
            verticalSpace(70),
            AppTextFormField(
                hintText: "username",
                controller: context.read<LoginCubit>().usernameController,
                validator: (value) {
                  if (value.isNullOrEmpty()) {
                    return "Email is required";
                  }
                }),
            verticalSpace(20),
            AppTextFormField(
                hintText: "Password",
                controller: context.read<LoginCubit>().passwordController,
                validator: (value) {
                  if (value.isNullOrEmpty()) {
                    return "Password is required";
                  }
                }),
            verticalSpace(20),
            const LoginBlocConsumer()
          ],
        ),
      ),
    );
  }
}
