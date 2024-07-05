import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jefit/core/common/widget/app_text_button.dart';
import 'package:jefit/core/common/widget/text_button_loading_simulator.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/features/Auth/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:jefit/features/Auth/signup/presentation/logic/cubit/signup_state.dart';

class SignupBlocConsumer extends StatelessWidget {
  const SignupBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(data),
                      content: const Text("Please login to continue"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"))
                      ],
                    ));
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
                  buttonText: "create account",
                  onPressed: () {
                    if (context
                        .read<SignupCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<SignupCubit>().emitSignupState();
                    }
                  },
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                ));
      },
    );
  }
}
