import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/core/common/widget/image_button.dart';
import 'package:jefit/core/helpers/extensions.dart';
import 'package:jefit/features/practice/data/lower_body_model.dart';

import 'package:jefit/features/practice/presentation/views/practice_video_view.dart';

class PracticesModalSheetBody extends StatelessWidget {
  const PracticesModalSheetBody({super.key, required this.models});
  final List<LowerBodyModel> models;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.h,
        width: context.width,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: ListView.builder(
          itemCount: models.length,
          itemBuilder: (context, index) {
            return ImageButton(
              image: models[index].image,
              title: models[index].title,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PracticeVideoView(model: models[index])));
              },
            );
          },
        ));
  }
}
