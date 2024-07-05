import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/core/common/widget/app_text_form_field.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/core/utils/spacing.dart';
import 'package:jefit/features/Auth/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:jefit/features/Auth/signup/presentation/widgets/date_time_field.dart';
import 'package:jefit/features/Auth/signup/presentation/widgets/signup_bloc_consumer.dart';

class SignupTabBody extends StatelessWidget {
  const SignupTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Form(
        key: context.read<SignupCubit>().formKey,
        child: Column(
          children: [
            verticalSpace(30),
            AppTextFormField(
              controller: context.read<SignupCubit>().nameController,
              hintText: "Name",
              validator: (value) {
                if (value.isNullOrEmpty()) {
                  return "Name is required";
                }
              },
            ),
            verticalSpace(10),
            AppTextFormField(
                controller: context.read<SignupCubit>().usernameController,
                hintText: "UserName",
                validator: (value) {
                  if (value.isNullOrEmpty()) {
                    return "UserName is required";
                  }
                  return null;
                }),
            verticalSpace(10),
            DateTimeField(
              dateSelector: (p0) {
                context.read<SignupCubit>().birthday = p0;
              },
            ),
            verticalSpace(10),
            AppTextFormField(
                controller: context.read<SignupCubit>().passwordController,
                hintText: "Password",
                validator: (value) {
                  if (value.isNullOrEmpty()) {
                    return "Password is required";
                  }
                  return null;
                }),
            verticalSpace(10),
            AppTextFormField(
                controller:
                    context.read<SignupCubit>().confirmPasswordController,
                hintText: "ConfirmPassword",
                validator: (value) {
                  if (value.isNullOrEmpty()) {
                    return "Password is required";
                  }
                  return null;
                }),
            verticalSpace(10),
            const SignupBlocConsumer()
          ],
        ),
      ),
    );
  }
}

