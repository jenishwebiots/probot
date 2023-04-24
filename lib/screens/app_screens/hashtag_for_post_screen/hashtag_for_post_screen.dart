import '../../../config.dart';

class HashtagForPostScreen extends StatelessWidget {
  const HashtagForPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return DirectionalityRtl(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppAppBarCommon(
                title: appFonts.hashTagsForPost, leadingOnTap: () => Get.back()),
            body: Stack(children: [
              SingleChildScrollView(
                child: Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(appFonts.fillBelowToRight.tr,
                        style: AppCss.outfitBold16
                            .textColor(appCtrl.appTheme.primary)),
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
                        .authBoxExtension(),
                    const VSpace(Sizes.s30),
                    if (socialMediaCtrl.isHashtagGenerated != true)
                      ButtonCommon(
                          title: appFonts.buildSomeMagic,
                          onTap: () => socialMediaCtrl.onHashtagGenerate())
                  ]),
                  if (socialMediaCtrl.isHashtagGenerated == true)
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputLayout(
                              hintText: appFonts.typeHere,
                              title: appFonts.hashtagsForYou,
                              isMax: false,
                              color: appCtrl.appTheme.white,
                              responseText: socialMediaCtrl.hashtagResponse),
                          const VSpace(Sizes.s30),
                          ButtonCommon(
                              title: appFonts.endHashtagBuilder,
                              onTap: () => socialMediaCtrl.endHashtagGeneratorDialog())
                        ])
                ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20),
              ),
              if (socialMediaCtrl.isLoader == true)
                LoaderScreen(value: socialMediaCtrl.progressValue)
            ])),
      );
    });
  }
}
