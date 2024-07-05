import 'package:flutter/material.dart';
import 'package:jefit/core/styles/app_text_styles.dart';
import 'package:jefit/features/practice/presentation/widgets/lower_body_listview.dart';

class LowerBodyView extends StatelessWidget {
  const LowerBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'full Body',
          style: AppTextStyles.designe20MediumPrimary(context),
        ),
      ),
      body: const LowerBodyListView(),
    );
  }
}
