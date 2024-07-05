import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/config/cache/cache_constants.dart';
import 'package:jefit/config/cache/cache_helper.dart';
import 'package:jefit/config/router/routes.dart';
import 'package:jefit/core/common/widget/app_text_button.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/core/utils/app_assets.dart';
import 'package:jefit/core/utils/spacing.dart';
import 'package:jefit/features/Auth/login/data/models/login_response_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(50),
             const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(AppAssets.profileIcon),
              ),
              verticalSpace(20),
            const  ProfileData()
            ],
          ),
        ));
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: CacheHelper.getString(key: CacheConstants.userCache),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          LoginResponseBody user =
              LoginResponseBody.fromJson(jsonDecode(snapshot.data ?? ""));
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Name'),
                    subtitle: Text(user.user?.name ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('username'),
                    subtitle: Text(user.user?.username ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('birthday'),
                    subtitle: Text(user.user?.birthday.formattedDate ?? ""),
                  ),
                ),
                verticalSpace(20),
                AppTextButton(
                  buttonText: "Logout",
                  onPressed: () {
                    context.navigateToAndReplace(Routes.auth);
                    logout();
                  },
                )
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  logout() async {
    await CacheHelper.clearAllData();
  }
}
