import '../../../config.dart';

class HashtagForPostScreen extends StatelessWidget {
  const HashtagForPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.hashTagsForPost, leadingOnTap: () => Get.back()),
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(eGifAssets.hashtagLoader, height: Sizes.s170),
              const VSpace(Sizes.s25),
              Text(appFonts.gatheringContent,
                  style:
                      AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
              const VSpace(Sizes.s15),
              SizedBox(
                  width: Sizes.s75,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                          backgroundColor: appCtrl.appTheme.textField,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              appCtrl.appTheme.primary),
                          value: socialMediaCtrl.progressValue,
                          minHeight: 4))),
              const VSpace(Sizes.s10),
              Text(appFonts.itMayTakeUpTo,
                  style: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.lightText)),
              /*Column(children: [
                Text(appFonts.fillBelowToRight,
                    style:
                        AppCss.outfitBold16.textColor(appCtrl.appTheme.primary)),
                const VSpace(Sizes.s15),
                Column(children: [
                  InputLayout(
                      hintText: appFonts.typeHere,
                      title: appFonts.describeYourPost,
                      isMax: true,
                      controller: socialMediaCtrl.hashtagController,
                      onTap: () => socialMediaCtrl.hashtagController.clear())
                ])
                    .paddingSymmetric(
                        vertical: Insets.i20, horizontal: Insets.i15)
                    .authBoxExtension()
              ]),
              const VSpace(Sizes.s40),
              ButtonCommon(
                title: appFonts.buildSomeMagic,
                onTap: () {},
              )*/
            ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20),
          ).paddingOnly(top: Insets.i50));
    });
  }
}
