import 'package:flutter/material.dart';
import 'package:jefit/config/router/routes.dart';
import 'package:jefit/core/common/widget/app_logo.dart';
import 'package:jefit/core/common/widget/image_button.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/core/utils/app_assets.dart';
import 'package:jefit/core/utils/spacing.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:false,
          title: const AppLogo(size: 120),
          centerTitle: true,
        ),
        body: Column(
          children: [
            verticalSpace(30),
            ImageButton(
              image: AppAssets.upperBody,
              title: 'Full Body',
              onTap: () {
                context.navigateTo(Routes.upperBodyView);
              },
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.navigateTo(Routes.profileView);
          },
          child: const Icon(Icons.person),
        ));
  
  }
  
}
