import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jefit/config/router/routes.dart';
import 'package:jefit/core/common/widget/app_text_button.dart';
import 'package:jefit/core/common/widget/text_button_loading_simulator.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/features/Auth/login/presentation/logic/cubit/login_cubit.dart';
import 'package:jefit/features/Auth/login/presentation/logic/cubit/login_state.dart';

class LoginBlocConsumer extends StatelessWidget {
  const LoginBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(data),
              backgroundColor: context.theme.primaryColor,
              duration: const Duration(seconds: 2),
            ));

            context.navigateTo(Routes.homeView);
          },
          error: (message) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(message),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"))
                      ],
                    ));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
            loading: () => const TextButtonLoadingSimulator(),
            orElse: () => AppTextButton(
                  buttonText: "Login",
                  onPressed: () {
                    if (context
                        .read<LoginCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<LoginCubit>().login();
                    }
                  },
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                ));
      },
    );
  }
}
