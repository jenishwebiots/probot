import '../../../../config.dart';

class SocialMediaListLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  final int? index;

  const SocialMediaListLayout({Key? key, this.data, this.onTap, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          SvgPicture.asset(data["image"]).paddingAll(Insets.i15).decorated(
              color: appCtrl.appTheme.primary,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8))),
          const HSpace(Sizes.s12),
          Text(data["title"]!.toString().tr,
              style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt))
        ]),
        SvgPicture.asset(
                appCtrl.isRTL || appCtrl.languageVal == "ar"
                    ? eSvgAssets.leftArrow
                    : eSvgAssets.rightArrow1,
                height: 15,
                colorFilter:
                    ColorFilter.mode(appCtrl.appTheme.txt, BlendMode.srcIn))
            .paddingSymmetric(horizontal: Insets.i10)
      ]),
      if (index != 2) const VSpace(Sizes.s15),
      if (index != 2)
        const Divider(height: 1, thickness: 1).paddingOnly(bottom: Insets.i15)
    ]).inkWell(onTap: () {
      if (data["title"] == appFonts.captionAbout) {
        Get.toNamed(routeName.captionCreatorScreen);
      } else if (data["title"] == appFonts.getMusicSuggestion) {
        Get.toNamed(routeName.musicForPostScreen);
      } else {
        Get.toNamed(routeName.hashtagForPostScreen);
      }
    });
  }
}
