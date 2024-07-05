import 'package:flutter/material.dart';
import 'package:jefit/core/common/widget/image_button.dart';
import 'package:jefit/core/utils/app_assets.dart';
import 'package:jefit/features/practice/data/lower_body_model.dart';
import 'package:jefit/features/practice/presentation/widgets/practice_modal_sheet_body.dart';

class LowerBodyListView extends StatelessWidget {
  const LowerBodyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ImageButton(
          image: AppAssets.legCover,
          title: "Legs",
          onTap: () {
            showModalBottomSheetForTraining(context, legsLowerBody);
          },
        ),
        ImageButton(
          image: AppAssets.kneeCover,
          title: "Knees",
          onTap: () {
            showModalBottomSheetForTraining(context, kneeLowerBody);
          },
        ),
        ImageButton(
          image: AppAssets.ankleCover,
          title: "Ankles",
          onTap: () {
            showModalBottomSheetForTraining(context, ankleLowerBody);
          },
        ),

        ImageButton(
          image: AppAssets.armsCover,
          title: "Arms",
          onTap: () {
            showModalBottomSheetForTraining(context, ArmsUpperBody);
          },
        ),
        ImageButton(
          image: AppAssets.chestCover,
          title: "Chest",
          onTap: () {
            showModalBottomSheetForTraining(context, ChestUpperBody);
          },
        ),
        ImageButton(
          image: AppAssets.shouldersCover,
          title: "Shoulders",
          onTap: () {
            showModalBottomSheetForTraining(context, ShouldersUpperBody);
           },
        ),
    ],
    );
  }





  showModalBottomSheetForTraining(
      BuildContext context, List<LowerBodyModel> list) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PracticesModalSheetBody(
          models: list,
        );
      },
    );
  }
}
