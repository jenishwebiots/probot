import '../../../../config.dart';

class WithoutCaptionLayout extends StatelessWidget {
  const WithoutCaptionLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return SingleChildScrollView(
          child: Column(children: [
        Text(appFonts.fillUpTheForm,
            style: AppCss.outfitBold16.textColor(appCtrl.appTheme.primary)),
        const VSpace(Sizes.s15),
        SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Text(appFonts.selectPlatform,
                  style:
                      AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
              const VSpace(Sizes.s10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: socialMediaCtrl.captionCreatorLists
                      .asMap()
                      .entries
                      .map((e) => PlatformLayout(
                          data: e.value,
                          index: e.key,
                          selectedIndex: socialMediaCtrl.selectedIndex,
                          onTap: () => socialMediaCtrl.onPlatformChange(e.key)))
                      .toList()),
              const VSpace(Sizes.s28),
              InputLayout(
                  hintText: appFonts.typeHere,
                  title: appFonts.writeDetail,
                  isMax: true,
                  controller: socialMediaCtrl.captionController,
                  onTap: () => socialMediaCtrl.captionController.clear()),
              const VSpace(Sizes.s20),
              Text(appFonts.targetedAudience,
                  style:
                      AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
              const VSpace(Sizes.s10),
              const TargetAudienceSliderLayout(),
              const VSpace(Sizes.s20),
              Text(appFonts.captionTone,
                  style:
                      AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
              const VSpace(Sizes.s10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: socialMediaCtrl.captionToneLists
                      .asMap()
                      .entries
                      .map((e) => CaptionToneLayout(
                          data: e.value,
                          index: e.key,
                          selectedIndex: socialMediaCtrl.selectedIndexTone,
                          onTap: () =>
                              socialMediaCtrl.onCaptionToneChange(e.key)))
                      .toList())
            ]))
            .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
            .authBoxExtension(),
        const VSpace(Sizes.s30),
        ButtonCommon(title: appFonts.bringMeTheBest,onTap: ()=> socialMediaCtrl.onCaptionGenerate())
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20));
    });
  }
}
