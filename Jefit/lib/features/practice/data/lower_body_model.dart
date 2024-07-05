import 'package:jefit/core/utils/app_assets.dart';

class LowerBodyModel {
  final String title;
  final String image;
  final String? videoAsset;

  LowerBodyModel({required this.title, required this.image, this.videoAsset});
}

List<LowerBodyModel> legsLowerBody = [
  LowerBodyModel(title: "squat", image: AppAssets.legSquat,
      videoAsset: AppAssets.legSquatVideo
  ),
  LowerBodyModel(title: "lunges", image: AppAssets.legLunges,
      videoAsset: AppAssets.lungsVideo),
];
List<LowerBodyModel> kneeLowerBody = [
  LowerBodyModel(title: "long arc quad", image: AppAssets.kneeQuad,
      videoAsset: AppAssets.longquadVideo),
  LowerBodyModel(title: "Heel Slides", image: AppAssets.kneeHeel,
      videoAsset: AppAssets.kneeVideo),
  LowerBodyModel(title: "Squat", image: AppAssets.kneeSquat,
      videoAsset: AppAssets.legSquatVideo),
];

List<LowerBodyModel> ankleLowerBody = [
  LowerBodyModel(title: "Ankle Mobility", image: AppAssets.ankleMobility,videoAsset: AppAssets.mobilityVideo),
  LowerBodyModel(title: "Toe Raise", image: AppAssets.ankleRaise ,
  videoAsset: AppAssets.traiseVideo),
];

List<LowerBodyModel> ArmsUpperBody = [
  LowerBodyModel(title: "biceps", image: AppAssets.bieceps,
      videoAsset: AppAssets.BiecepsVideo
  ),
  LowerBodyModel(title: "triceps", image: AppAssets.tricepes, videoAsset: AppAssets.triecepsVideo),
];
List<LowerBodyModel> ChestUpperBody = [

  LowerBodyModel(title: "video 1", image: AppAssets.chest,videoAsset: AppAssets.firstchestVideo),
  LowerBodyModel(title: "video 2", image: AppAssets.chest,videoAsset: AppAssets.secondchestVideo),
];

List<LowerBodyModel> ShouldersUpperBody = [
  LowerBodyModel(title: "Front", image: AppAssets.ShoulderFront,videoAsset: AppAssets.fshoulderVideo),
  LowerBodyModel(title: "Back", image: AppAssets.ShoulderBack,videoAsset: AppAssets.bshoulderVideo),
];
