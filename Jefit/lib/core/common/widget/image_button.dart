
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/core/styles/app_text_styles.dart';

class ImageButton extends StatelessWidget {
  const ImageButton(
      {super.key,
      required this.image,
      required this.title,
      this.onTap,
      this.size});
  final String image;
  final String title;
  final double? size;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        height: size ?? 100.h,
        width: size ?? context.width,
        decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            border: Border.all(color: context.theme.primaryColor, width: 2),
            image: DecorationImage(
                image: AssetImage(image), fit: BoxFit.cover, opacity: 0.4),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3))
            ]),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.designe20MediumPrimary(context),
          ),
        ),
      ),
    );
  }
}
