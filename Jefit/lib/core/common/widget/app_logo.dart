import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/core/utils/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key,
this.size
  });
final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
        height:size?? 200.h,
        width:size?? 200.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.logo),
            fit: BoxFit.contain,
          ),
        ));
  }
}
